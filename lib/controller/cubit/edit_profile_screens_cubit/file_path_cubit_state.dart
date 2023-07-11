part of 'file_path_cubit.dart';

abstract class FilePathCubitState {}

class FilePathCubitInitialState extends FilePathCubitState {}

// !----------------------------------------! //

class ImagePathCubitState extends FilePathCubitState {}

class PdfPathCubitState extends FilePathCubitState {}

// !----------------------------------------! //

class FilePathCubitLoadingSizeState extends FilePathCubitState {}

class FilePathCubitCompleteSizeState extends FilePathCubitState {}

class FilePathCubitErrorState extends FilePathCubitState {}
