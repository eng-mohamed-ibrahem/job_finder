import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/utils/dio_helper/dio_helper.dart';
import 'package:job_finder/controller/utils/methods.dart';
import '../../utils/sql_helper/sql_helper.dart';

part 'file_path_cubit_state.dart';

class FilePathCubit extends Cubit<FilePathCubitState> {
  FilePathCubit() : super(FilePathCubitInitialState());

  String imagePath = '';
  void setImageFromGallery() async {
    await pickImageFromGallery().then((path) {
      if (path != null) {
        imagePath = path;
        saveProfileImage();
        emit(ImageFilePathCubitState());
      }
    });
  }

  void getProfileImage() async {
    await SqlHelper.queryData(
      queryStatement:
          ''' SELECT ${UserTableColumnTitles.profileImage} FROM ${UserTableColumnTitles.usersTable};''',
    ).then((result) {
      if (result.isNotEmpty) {
        imagePath = result.first[UserTableColumnTitles.profileImage] as String;
        emit(ImageFilePathCubitState());
      }
    });
  }

  void saveProfileImage() async {
    await SqlHelper.updateData(
        queryStatement:
            ''' UPDATE ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.profileImage} = "$imagePath";''');
  }

  void setImageFromCamera() async {
    await pickImageFromCamera().then((path) {
      if (path != null) {
        imagePath = path;
        saveProfileImage();
        emit(ImageFilePathCubitState());
      }
    });
  }

  List<FileContent> files = [];
  int selectedFileIndex = -1;

  set selectFile(int index) {
    selectedFileIndex = index;
    emit(SelectedFilePathCubitState());
  }

  Future getPortoflios({
    required int userId,
    required String token,
  }) async {
    emit(PortfolioDownloadCubitLoadingState());
    try {
      await DioHelper.getData(
              endPoint: '${UrlPaths.uploadPortfolio}/$userId', token: token)
          .then((response) {
        if (response!.statusCode == 200) {
          final data = response.data['data'] as List<Map>;
          files = List.generate(data.length, (index) {
            return FileContent(path: data[index]['name']);
          });
        }
      });
      emit(PortfolioDownloadCubitCompleteState());
    } catch (e) {
      debugPrint(e.toString());
      emit(PortfolioDownloadCubitErrorState());
    }
  }

  Future<bool> _uploadPortfolio(
      {String? path, required String token, required int userId}) async {
    emit(PortfolioUploadCubitLoadingState());
    try {
      await DioHelper.postData(
        endPoint: '${UrlPaths.uploadPortfolio}/$userId',
        data: {
          'cv_file': await MultipartFile.fromFile(
            path!,
            filename: path.split('/').last,
          ),
          'name': path,
        },
        token: token,
      );
      emit(PortfolioUploadCubitCompleteState());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      emit(PortfolioUploadCubitErrorState());
      return false;
    }
  }

  void pickPortfolio({required String token, required int userId}) async {
    try {
      String? path = await pickFile();
      if (path != null) {
        if (!files.any(
          (element) {
            return element.path == path;
          },
        )) {
          await _uploadPortfolio(
            path: path,
            token: token,
            userId: userId,
          ).then((uploaded) {
            if (uploaded) {
              files.add(FileContent(path: path));
            }
          });
          emit(PortfolioCubitState());
        }
      }
    } on FileSystemException catch (e) {
      log(e.message);
    }
  }

  void removePdfFile(int index) {
    files.removeAt(index);
    emit(PortfolioCubitState());
  }
}

class FileContent {
  final String path;
  late String _name;
  late String _size;
  FileContent({required this.path}) {
    _size = getFileSizeAsString(File(path));
    _name = path.split('/').last;
  }

  String get name => _name;
  String get size => _size;

  String getFileSizeAsString(File file) {
    String fileSize = 'Unknown';
    try {
      final size = file.lengthSync();

      if (size < 1048576) {
        fileSize = '${(size / 1024).toStringAsFixed(2)} KB';
      } else if (size < 1073741824) {
        fileSize = '${(size / 1048576).toStringAsFixed(2)} MB';
      }

      return fileSize;
    } on FileSystemException catch (e) {
      log(e.toString());
      return fileSize;
    }
  }

  @override
  String toString() => 'FileContent(path: $path, _name: $_name, _size: $_size)';
}
