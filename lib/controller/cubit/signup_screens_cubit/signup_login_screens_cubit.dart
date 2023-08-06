import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/utils/dio_helper/dio_helper.dart';

import '../../../model/signup_models/user_model.dart';
import '../../utils/sql_helper/sql_helper.dart';

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

  /// ! ........................................................................ ! ///

  Future updateUserData({
    String? name,
    String? password,
    String? email,
    String? mobile,
    String? bio,
    String? address,
  }) async {
    emit(UpdateUserDataLoadingCubitState());
    try {
      if (name != null || password != null) {
        Map<String, dynamic> namePassword = {};
        if (name != null) {
          namePassword.putIfAbsent('name', () => name);
        }
        if (password != null) {
          namePassword.putIfAbsent('password', () => password);
        }
        await DioHelper.putData(
          endPoint: UrlPaths.updateNPProfile,
          token: userModel!.token,
          data: namePassword,
        ).then(
          (response) async {
            if (response!.statusCode == 200) {
              userModel!.name = name!;
              await SqlHelper.updateData(queryStatement: ''' 
                 UPDATE ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.name} = '${userModel!.name}';
            ''');
              emit(UpdateUserDataSuccessCubitState());
            }
          },
        );
      }
      if (email != null) {
        await SqlHelper.insertData(queryStatement: ''' 
            UPDATE ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.email} = '$email'; 
            ''');
        emit(UpdateUserDataSuccessCubitState());
      }
      if (mobile != null || bio != null || address != null) {
        await DioHelper.putData(
            endPoint: '${UrlPaths.updateMBAProfile}${userModel!.id}',
            token: userModel!.token,
            queryParameters: {
              'mobile': mobile ?? userModel!.mobile,
              'bio': bio ?? userModel!.bio,
              'address': address ?? userModel!.address,
            }).then(
          (response) async {
            if (response!.statusCode == 200) {
              userModel!.mobile = mobile;
              await SqlHelper.updateData(queryStatement: ''' 
            UPDATE ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.mobile} = '${userModel!.mobile}', ${UserTableColumnTitles.bio} = '${userModel!.bio}', ${UserTableColumnTitles.address} = '${userModel!.address}';
            ''');
              emit(UpdateUserDataSuccessCubitState());
            }
          },
        );
      }
    } on Exception catch (e) {
      debugPrint('cubit-$e');
      emit(UpdateUserDataErrorCubitState());
    }
  }

  /// ! ........................................................................ ! ///

  void singup({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SingupLoadingCubitState());
    try {
      await DioHelper.postData(
        endPoint: UrlPaths.register,
        queryParameters: {
          'email': email,
          'password': password,
          'name': name,
        },
      ).then((response) async {
        if (response!.statusCode == 200) {
          var collection = response.data['data'] as Map<String, dynamic>;
          collection.putIfAbsent(
              UserTableColumnTitles.token, () => response.data['token']);
          collection[UserTableColumnTitles.login] = false;
          userModel = UserModel.fromMap(collection);
          await _inserData();
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
      debugPrint('cubit-$e');
      emit(SingupErrorCubitState());
    }
  }

  void login({
    required String email,
    required String password,
  }) async {
    emit(SingupLoadingCubitState());
    try {
      await DioHelper.postData(endPoint: UrlPaths.login, data: {
        'email': email,
        'password': password,
      }).then((response) async {
        if (response!.statusCode == 200) {
          var collection = response.data['data'] as Map<String, dynamic>;
          collection.putIfAbsent('token', () => response.data['token']);
          collection[UserTableColumnTitles.login] = true;
          userModel = UserModel.fromMap(collection);
          await _inserData();
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

  Future<void> _inserData() async {
    SqlHelper.deleteData(queryStatement: '''
              DELETE FROM ${UserTableColumnTitles.usersTable};
            ''');
    await SqlHelper.insertData(queryStatement: '''
              INSERT INTO ${UserTableColumnTitles.usersTable}
              (${UserTableColumnTitles.id}, ${UserTableColumnTitles.name}, ${UserTableColumnTitles.otp}, ${UserTableColumnTitles.email}, ${UserTableColumnTitles.createdAt}, ${UserTableColumnTitles.token}, ${UserTableColumnTitles.login})
              VALUES (${userModel!.id}, '${userModel!.name}', ${userModel!.otp}, '${userModel!.email}', '${userModel!.createdAt}', '${userModel!.token}', ${userModel!.isLogin ? 1 : 0});
            ''');
  }

  /// ! ........................................................................ ! ///

  // update the checkbox state
  updateChecked() {
    checked = !checked;
    emit(ChangeCheckedCubitState());
  }
}
