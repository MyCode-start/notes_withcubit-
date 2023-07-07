import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit_integration/notes_manage_cubit.dart';
import 'db_helper.dart';

class newnotesecondpage extends StatefulWidget {
  final int index;

  newnotesecondpage({required this.index});

  @override
  State<newnotesecondpage> createState() => _newnotesecondpageState();
}

class _newnotesecondpageState extends State<newnotesecondpage> {

  var newTitle;
  var newDesc;
  var titleditingcontroller = TextEditingController();
  var descditingcontroller = TextEditingController();


  @override
  void initState() {
    BlocProvider.of<NotesManageCubit>(context).getNotes();
    titleditingcontroller.text = BlocProvider.of<NotesManageCubit>(context) .state .myData[widget.index][DBhelper().columnTitle];
    descditingcontroller.text = BlocProvider.of<NotesManageCubit>(context) .state .myData[widget.index][DBhelper().columnDesc];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<NotesManageCubit, NotesManageState>(
                builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios_new_outlined,
                                color: Colors.white))),
                    Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: InkWell(
                            onTap: () {

                              newTitle = titleditingcontroller.text.toString();
                              newDesc = descditingcontroller.text.toString();

                              BlocProvider.of<NotesManageCubit>(context).updateNotes(state.myData[widget.index]
                                          [DBhelper().columnId], newTitle, newDesc);


                              Navigator.pop(context);
                            },
                            child: Icon(Icons.edit_note, color: Colors.white)))
                  ],
                ),
              );
            }),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: titleditingcontroller,
                          style: TextStyle(color: Colors.white),
                          // Set text color to white
                          cursorColor: Colors.white,
                          // Set cursor color to white
                          maxLength: 100,
                          // Maximum number of characters allowed in the text field
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),

                        /*Text(
                      state.myData[index][DBhelper().columnTitle],
                      style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                    ),*/
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: descditingcontroller,
                          style: TextStyle(color: Colors.white),
                          // Set text color to white
                          cursorColor: Colors.white,
                          // Set cursor color to white
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),

                        /*Text(
                      state.myData[index][DBhelper().columnDesc],
                      style: TextStyle(fontSize: 18, color: Colors.white,),
                    ),*/
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('body'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
