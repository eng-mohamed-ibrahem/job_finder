import 'package:flutter/material.dart';
import 'package:job_finder/controller/utils/dio_helper/dio_helper.dart';
import 'package:job_finder/root/root_app.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const Root());
}
