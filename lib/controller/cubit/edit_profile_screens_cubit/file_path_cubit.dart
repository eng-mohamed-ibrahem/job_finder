import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_path_cubit_state.dart';

class FilePathCubit extends Cubit<FilePathCubitState> {
  FilePathCubit() : super(FilePathCubitInitialState());

  String imagePath = '';
  void setImagePath(String path) {
    imagePath = path;
    emit(ImagePathCubitState());
  }

  List<FileContent> files = [];

  void setPdfPath(String path) {
    if (!files.any(
      (element) {
        return element.path == path;
      },
    )) {
      files.add(FileContent(path: path));
      emit(PdfPathCubitState());
    }
  }

  void removePdfFile(int index) {
    files.removeAt(index);
    emit(PdfPathCubitState());
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
}
