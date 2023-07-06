import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'color_selection_manage_state.dart';

class ColorSelectionManageCubit extends Cubit<ColorSelectionManageState> {
  ColorSelectionManageCubit() : super(ColorSelectionManageState(iscontainerselected : false));

   void Selection () {
     //emit(ColorSelectionManageState(iscontainerselected : true));
     var newState = ColorSelectionManageState(iscontainerselected: true);
     emit(newState);

   }


}


