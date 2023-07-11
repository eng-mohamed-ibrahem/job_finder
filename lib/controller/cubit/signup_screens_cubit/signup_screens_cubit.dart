import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/utils/dio_helper/dio_helper.dart';
import '../../../model/signup_models/user_model.dart';
import '../../utils/dio_helper/url_paths.dart';

part 'signup_cubit_states.dart';

class SignupLoginScreenCubit extends Cubit<SignupCubitState> {
  SignupLoginScreenCubit() : super(SignupCubitInitialState());

  bool visible = false;
  bool changed = false;
  bool checked = false;
  UserModel? userModel;
  String? errorMessageWhileSignup;

  updateVisibility() {
    visible = !visible;
    emit(ObscureVisbilityCubitState());
  }

  changeButtonStyle() {
    changed = !changed;
    emit(ChangeButtonStyleCubitState());
  }

  Response? response;
  // sign up user with name, email and password
  void singup({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SingupLoadingCubitState());
    try {
      await DioHelper.postData(
        endPoint: UrlPaths.register,
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
        queryParameters: {
          'email': email,
          'password': password,
          'name': name,
        },
      ).then((response) {
        this.response = response;
        if (response!.statusCode == 200) {
          var collection = response.data['data'] as Map<String, dynamic>;
          collection.putIfAbsent('token', () => response.data['token']);
          userModel = UserModel.fromMap(collection);
          debugPrint(userModel.toString());
          emit(SingupSuccessCubitState());
        } else if (response.statusCode == 401) {
          errorMessageWhileSignup = response.data['massege']['email'][0];
          emit(SignupUnauthorizedCubitState());
        } else {
          emit(SingupErrorCubitState());
        }
      });
    } catch (e) {
      emit(SingupErrorCubitState());
      log(response.toString());
    }
  }

  // login user with email and password
  void login({
    required String email,
    required String password,
  }) async {
    try {
      await DioHelper.postData(endPoint: UrlPaths.login, data: {
        'email': email,
        'password': password,
      }).then((response) {
        if (response!.statusCode == 200) {
          // update any data of user changed in database
          var collection = response.data['data'] as Map<String, dynamic>;
          collection.update('token', (value) => response.data['token']);
          userModel = UserModel.fromMap(collection);
          emit(SingupSuccessCubitState());
        } else if (response.statusCode == 401) {
          errorMessageWhileSignup = response.data['massege'];
          emit(SignupUnauthorizedCubitState());
        } else {
          emit(SingupErrorCubitState());
        }
      });
    } catch (e) {
      emit(SingupErrorCubitState());
    }
  }

  // update the checkbox state
  updateChecked() {
    checked = !checked;
    emit(ChangeCheckedCubitState());
  }
}
