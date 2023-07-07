
import 'package:bloc/bloc.dart';
import '../db_helper.dart';
part 'notes_manage_state.dart';



class NotesManageCubit extends Cubit<NotesManageState> {

  NotesManageCubit() : super(NotesManageState(myData:[] ));

  void addNotes (String title, String desc) async{

    await DBhelper().addData(title, desc);
    List <Map<String, dynamic>> myData = await DBhelper().fetchData();
    emit(NotesManageState(myData: myData));

  }

  void getNotes() async {
    List <Map<String, dynamic>> myData = await DBhelper().fetchData();
    emit(NotesManageState(myData: myData));

  }


  void delNotes (int index) async{
    await DBhelper().delData(index);
    List <Map<String, dynamic>> myData = await DBhelper().fetchData();
    emit(NotesManageState(myData: myData));

  }

  void updateNotes (int index, title, desc) async{
    await DBhelper().updateData(index,title, desc);
    List <Map<String, dynamic>> myData = await DBhelper().fetchData();
    emit(NotesManageState(myData: myData));

  }

}





