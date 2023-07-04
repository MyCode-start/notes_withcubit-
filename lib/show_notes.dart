import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit_integration/notes_manage_cubit.dart';
import 'db_helper.dart';

class notesecondpage extends StatefulWidget {

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
    return Scaffold(
        backgroundColor: Colors.pinkAccent,
        body: Column(
          children: [
            uiheadersecond(context),
            BodyContentsecond(),
          ],
        )

    );
  }

  Widget uiheadersecond(BuildContext context) {
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

                  child: Icon(
                      Icons.arrow_back_ios_new_outlined, color: Colors.white))),
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: Colors.black.withOpacity(0.2),
              ),
              child: Icon(Icons.edit_note, color: Colors.white))
        ],
      ),
    );
  }

  Widget BodyContentsecond() {
    return BlocBuilder<NotesManageCubit, NotesManageState>(
        builder: (context, state)
    {
      return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(state.myData[index][DBhelper().columnTitle],
                    style: TextStyle(
                        fontSize: 21, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(state.myData[index][DBhelper().columnDesc],
                      style: TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('body'),
                ),
              ],
            ),
          )

      );
    }
    );
  }
}