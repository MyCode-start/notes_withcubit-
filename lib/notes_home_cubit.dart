import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_cubit/show_notes.dart';
import '../db_helper.dart';
import 'cubit_integration/notes_manage_cubit.dart';


class mainnotespagefromprovider extends StatefulWidget {

  @override
  State<mainnotespagefromprovider> createState() => _mainnotespagefromproviderState();
}


class _mainnotespagefromproviderState extends State<mainnotespagefromprovider> {

  var titlecontroller= TextEditingController();
  var descriptioncontroller= TextEditingController();
  var title;
  var desc;

  /*List<Map<String, dynamic>> arrNotes = [];*/



  @override
  void initState() {
      BlocProvider.of<NotesManageCubit>(context).getNotes();
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Note app'),
        ),
        backgroundColor: Colors.black26,
        body: BlocBuilder<NotesManageCubit, NotesManageState>(
        builder: (context, state) {
          return GridView.builder(
              itemCount: state.myData.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 10),
                  child: InkWell(

                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context)=>notesecondpage())));
                    },

                    onLongPress: () {
                      showDialog(
                        context: context, builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Delete'),
                            content: Text(
                                'Are you sure you want to delete the text'),
                            actions: [
                              TextButton(

                                onPressed: () {
                                  BlocProvider.of<NotesManageCubit>(context).
                                  delNotes(state.myData[index][DBhelper().columnId]);

                                  Navigator.pop(context);

                                }, child: Text('Delete'),


                              ),
                              TextButton(

                                onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text('Cancel'),
                              )
                            ]
                        );
                      },
                      );
                    }, child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.greenAccent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.myData[index][DBhelper().columnTitle],
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                             state.myData[index][DBhelper().columnDesc],
                              style: TextStyle(fontSize: 15)),
                        ),
                      ],
                    ),

                  ),
                  ),
                );
              }
          );
        }
        ),


        floatingActionButton: FloatingActionButton(onPressed: () {

          showDialog( context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Add a new note'),
              content: Column(
                children: [
                  TextField(
                    controller: titlecontroller,
                    decoration: InputDecoration(hintText: 'Title'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: descriptioncontroller,
                    decoration: InputDecoration(hintText: 'Description'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    title = titlecontroller.text.toString();
                    desc = descriptioncontroller.text.toString();

                    BlocProvider.of<NotesManageCubit>(context).addNotes(title, desc);
                    Navigator.pop(context);

                  },
                  child: Text('SAVE'),
                ),
              ],
            );

          },
          );

        }, child: Icon (Icons.add),

        )
    );
  }


}