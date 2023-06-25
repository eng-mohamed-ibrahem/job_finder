import 'package:flutter_bloc/flutter_bloc.dart';

///
/// this cubit is used to rebuild the grid view when the selected item is changed
/// rebuild only the selected item is changed and not all bloc builder that listen to this cubit
/// this cubit is used to change the selected item in the grid view
/// and the grid view is used to select the work type
/// the work type is a list of work type model
/// the work type model is a model that contain the icon and the text of the work type
///
class WorkTypeSelectedCubit extends Cubit<bool> {
  WorkTypeSelectedCubit() : super(false);

  int currentSelectedItemIndex = -1;
  void changeSelected(int newSelected) {
    currentSelectedItemIndex = newSelected;
    emit(!state);
  }
}
