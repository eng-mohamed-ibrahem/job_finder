import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_cubit_states.dart';

class SignupScreenCubit extends Cubit<SignupCubitState> {
  SignupScreenCubit() : super(SignupCubitInitialState());

  bool visible = false;
  bool changed = false;

  updateVisibility() {
    visible = !visible;
    emit(SignupVisbilityCubitState());
  }

  changeButtonStyle() {
    changed = !changed;
    emit(SignupButtonCubitState());
  }
}
