import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/utils/dio_helper/dio_helper.dart';
import '../../../model/job_model/databse_job_model.dart';
import '../../../model/job_model/job_model.dart';
import '../../utils/sql_helper/sql_helper.dart';

part 'job_data_cubit_states.dart';

class JobDataCubit extends Cubit<JobDataState> {
  JobDataCubit() : super(JobDataInitial());

  /// jobs from api
  List<JobModel> recentJobs = [];
  List<JobModel> suggestedJobs = [];

  /// to save interaction with user
  List<DatabaseJobModel> savedJobs = [];
  List<DatabaseJobModel> appliedJobs = [];

  Future<void> getSuggestedJobData({required String token}) async {
    emit(SuggestJobDataLoading());
    try {
      await DioHelper.getData(endPoint: UrlPaths.suggestJob, token: token).then(
        (response) {
          if (response!.statusCode == 200) {
            var list = response.data['data'] as List<Map<String, dynamic>>;
            for (var element in list) {
              suggestedJobs.add(JobModel.fromMap(element));
            }
          }
          emit(SuggestJobDataSuccess());
        },
      );
    } catch (e) {
      emit(SuggestJobDataError());
    }
  }

  Future<void> getRecentJobs() async {
    emit(RecentJobDataLoading());
    try {
      await rootBundle.loadString('assets/files/jobs.json').then((value) {
        var list = jsonDecode(value) as List<Map<String, dynamic>>;
        for (var element in list) {
          recentJobs.add(JobModel.fromMap(element));
        }
      });
      emit(RecentJobDataSuccess());
    } catch (e) {
      emit(RecentJobDataError());
    }
  }

  /// insert in realtime and database
  Future<bool> saveJob(JobModel job) async {
    emit(SaveJobDataLoading());
    try {
      job.isFavorite = !job.isFavorite!;
      // save in realtime list
      DatabaseJobModel savedJobModel = DatabaseJobModel(
        id: job.id,
        name: job.name,
        image: job.image,
        compName: job.compName,
        createdAt: job.createdAt,
      );
      savedJobs.add(savedJobModel);
      // save in database
      await SqlHelper.insertRowAsMap(
        table: SavedJobTableColumnTitles.jobTable,
        values: savedJobModel.toMap(),
      );
      emit(SaveJobDataSuccess());
      return true;
    } catch (e) {
      emit(SaveJobDataError());
      return false;
    }
  }

  /// delete from realtime and database
  Future<bool> deleteSavedJob(JobModel job) async {
    emit(SaveJobDataLoading());
    try {
      // delete from realtime list
      savedJobs.remove(
        DatabaseJobModel(
          id: job.id,
          name: job.name,
          image: job.image,
          compName: job.compName,
          createdAt: job.createdAt,
        ),
      );
      // delete from database
      await SqlHelper.deleteData(queryStatement: '''
      DELETE FROM ${SavedJobTableColumnTitles.jobTable} WHERE ${DatabseJobTableColumnTitles.jobId} = ${job.id}
       ''');
      emit(SaveJobDataSuccess());
      return true;
    } catch (e) {
      emit(SaveJobDataError());
      return false;
    }
  }

  /// get saved jobs from database
  Future<List<JobModel>> getSavedJobs() async {
    emit(SaveJobDataLoading());
    try {
      await SqlHelper.tableHasData(table: SavedJobTableColumnTitles.jobTable)
          .then((data) async {
        if (data) {
          // get data from database
          await SqlHelper.getAllRows(table: SavedJobTableColumnTitles.jobTable)
              .then((jobData) {
            for (var element in jobData) {
              savedJobs.add(DatabaseJobModel.fromMap(element));
            }
            return savedJobs;
          });
          emit(SaveJobDataSuccess());
        }
      });
    } catch (e) {
      emit(SaveJobDataError());
    }
    return [];
  }

  /// insert in realtime & database
  Future<bool> saveAppliedJob(JobModel job) async {
    emit(AppliedJobDataLoading());
    try {
      // save in realtime list
      DatabaseJobModel appliedJobModel = DatabaseJobModel(
        id: job.id,
        name: job.name,
        image: job.image,
        compName: job.compName,
      );
      appliedJobs.add(appliedJobModel);
      // save in database
      await SqlHelper.insertRowAsMap(
        table: AppliedJobTableColumnTitles.jobTable,
        values: appliedJobModel.toMap(),
      );
      emit(AppliedJobDataSuccess());
      return true;
    } catch (e) {
      emit(AppliedJobDataError());
      return false;
    }
  }

  /// delete from realtime & database

  Future<bool> deleteAppliedJob(JobModel job) async {
    emit(AppliedJobDataLoading());
    try {
      // delete from realtime list
      appliedJobs.remove(
        DatabaseJobModel(
          id: job.id,
          name: job.name,
          image: job.image,
          compName: job.compName,
        ),
      );
      // delete from database
      await SqlHelper.deleteData(queryStatement: '''
      DELETE FROM ${AppliedJobTableColumnTitles.jobTable} WHERE ${DatabseJobTableColumnTitles.jobId} = ${job.id}
       ''');
      emit(AppliedJobDataSuccess());
      return true;
    } catch (e) {
      emit(AppliedJobDataError());
      return false;
    }
  }

  /// get applied jobs from database
  Future<void> getAppliedJobs() async {
    emit(AppliedJobDataLoading());
    try {
      await SqlHelper.tableHasData(table: AppliedJobTableColumnTitles.jobTable)
          .then((data) async {
        if (data) {
          await SqlHelper.getAllRows(
                  table: AppliedJobTableColumnTitles.jobTable)
              .then((jobData) {
            for (var element in jobData) {
              appliedJobs.add(DatabaseJobModel.fromMap(element));
            }
          });
          emit(AppliedJobDataSuccess());
        }
      });
    } catch (e) {
      emit(AppliedJobDataError());
    }
  }
}
