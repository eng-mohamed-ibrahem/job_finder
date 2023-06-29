import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_cubit_states.dart';

class SignupLoginScreenCubit extends Cubit<SignupCubitState> {
  SignupLoginScreenCubit() : super(SignupCubitInitialState());

  bool visible = false;
  bool changed = false;
  bool checked = false;

  updateVisibility() {
    visible = !visible;
    emit(ObscureVisbilityCubitState());
  }

  changeButtonStyle() {
    changed = !changed;
    emit(ChangeButtonStyleCubitState());
  }

  updateChecked() {
    checked = !checked;
    emit(ChangeCheckedCubitState());
  }
}
