part of 'job_data_cubit.dart';

abstract class JobDataState {}

class JobDataInitial extends JobDataState {}

class SuggestJobDataLoading extends JobDataState {}

class SuggestJobDataSuccess extends JobDataState {}

class SuggestJobDataError extends JobDataState {}

class RecentJobDataLoading extends JobDataState {}

class RecentJobDataSuccess extends JobDataState {}

class RecentJobDataError extends JobDataState {}

class SaveJobDataLoading extends JobDataState {}

class SaveJobDataSuccess extends JobDataState {}

class SaveJobDataError extends JobDataState {}

class AppliedJobDataLoading extends JobDataState {}

class AppliedJobDataSuccess extends JobDataState {}

class AppliedJobDataError extends JobDataState {}
