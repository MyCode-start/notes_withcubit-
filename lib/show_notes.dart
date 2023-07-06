import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit_integration/notes_manage_cubit.dart';
import 'db_helper.dart';

class notesecondpage extends StatefulWidget {
  final int index;

  notesecondpage({required this.index});

  @override
  State<notesecondpage> createState() => _notesecondpageState();
}

class _notesecondpageState extends State<notesecondpage> {



  @override
  void initState() {
    BlocProvider.of<NotesManageCubit>(context).getNotes();
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
            uiheadersecond(context),
            BodyContentsecond(index: widget.index),
          ],
        ),
      ),
    );
  }

  Widget uiheadersecond (context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(11),
                color: Colors.black.withOpacity (0.2),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: Icon (Icons.arrow_back_ios_new_outlined, color: Colors.white))),
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(11),
                color: Colors.black.withOpacity (0.2),
              ),
              child: Icon (Icons.edit_note, color: Colors.white))
        ],
      ),
    );
  }
}

class BodyContentsecond extends StatelessWidget {

  final int index;
  var titleditingcontroller= TextEditingController();
  var descditingcontroller= TextEditingController();

  BodyContentsecond({required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesManageCubit, NotesManageState>(
      builder: (context, state) {
        titleditingcontroller = TextEditingController(text:  state.myData[index][DBhelper().columnTitle]);
        descditingcontroller = TextEditingController(text:  state.myData[index][DBhelper().columnDesc]);
        return Expanded(
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
                        style: TextStyle(color: Colors.white), // Set text color to white
                        cursorColor: Colors.white, // Set cursor color to white
                        maxLength: 100, // Maximum number of characters allowed in the text field
                        maxLines: null,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white), // Set line color to white
                          ),
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
                      style: TextStyle(color: Colors.white), // Set text color to white
                      cursorColor: Colors.white, // Set cursor color to white
                      maxLines: null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), // Set line color to white
                        ),
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
        );
      },
    );
  }
}