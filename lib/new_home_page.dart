import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_cubit/show_notes.dart';
import '../db_helper.dart';
import 'cubit_integration/notes_manage_cubit.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';



class newmainnotespagefromprovider extends StatefulWidget {

  @override
  State<newmainnotespagefromprovider> createState() => _newmainnotespagefromproviderState();
}


class _newmainnotespagefromproviderState extends State<newmainnotespagefromprovider> {

  var titlecontroller = TextEditingController();
  var descriptioncontroller = TextEditingController();
  var title;
  var desc;
  var orientation;
  Color mycolor = Colors.lightBlue;

  var arrcolor = [

    /*{'bgcolor' : Color(0xffFFAB91)},
    {'bgcolor' : Color(0xffFFCC80)} ,
    {'bgcolor' : Color(0xffE6EE9B)} ,
    {'bgcolor' : Color(0xff80DEEA)},
    {'bgcolor' :  Color(0xffCF93D9)},
    {'bgcolor' : Color(0xff80CBC4)} ,
    {'bgcolor' : Color(0xffF48FB1)} ,*/

    Color(0xffFFAB91),
    Color(0xffFFCC80),
    Color(0xffE6EE9B),
    Color(0xff80DEEA),
    Color(0xffCF93D9),
    Color(0xff80CBC4),
    Color(0xffF48FB1),


  ];






  @override
  void initState() {
    BlocProvider.of<NotesManageCubit>(context).getNotes();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var orientation = mq.orientation;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black26,
          body: Column(
            children: [
              uiheader(),
              Container(
                child: orientation == Orientation.portrait ?
                BodyContentPotraite(context) : BodyContentLandscape(context),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {

            showDialog( context: context, builder: (BuildContext context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: Text('Add a new note'),
                  content: Container(
                    height: 450,
                    child: Column(
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
                        SizedBox(height: 30),
                        Container(
                          width: 200,
                          height: 300,
                          child: BlockPicker(
                            pickerColor: mycolor, //default color
                            onColorChanged: (Color color){ //on color picked
                              setState(() {
                                mycolor = color;
                              });
                            },
                          ),
                        ),


                        /*Row(
                          children: [
                            InkWell(
                              onTap: () {
                                selectedcolor = 1;

                              },
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.5),
                                  color: Color(0xffFFAB91),
                                ),
                              ),
                            ),

                            SizedBox(width: 10),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.5),
                                color:  Color(0xffFFCC80),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.5),
                                color:     Color(0xffE6EE9B),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.5),
                                color:  Color(0xff80DEEA),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.5),
                                color:   Color(0xffCF93D9),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.5),
                                color: Color(0xff80CBC4),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.5),
                                color:  Color(0xffF48FB1),
                              ),
                            ),
                          ],
                        )*/

                      ],
                    ),
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

                    TextButton(
                      onPressed: () {

                        Navigator.pop(context);

                      },
                      child: Text('CANCEL'),
                    ),
                  ],
                ),
              );

            },
            );

          },
              child: Icon(Icons.add)

          )

      ),
    );
  }


  Widget uiheader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Notes', style: TextStyle(fontWeight: FontWeight.w800,
              color: Colors.white, fontSize: 30)),
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: Colors.black.withOpacity(0.2),
              ),
              child: Icon(Icons.search, color: Colors.white))
        ],
      ),
    );
  }


  Widget BodyContentPotraite(BuildContext context) {
    return BlocBuilder<NotesManageCubit, NotesManageState>(
      builder: (context, state) {
        return Expanded(
            child: GridView.custom(
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(2, 4),
                  QuiltedGridTile(3, 2),
                  QuiltedGridTile(2, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) =>
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(

                        onTap: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: ((context) =>
                              notesecondpage(index: index))));
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
                                      delNotes(state.myData[index][DBhelper()
                                          .columnId]);

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
                          color: mycolor,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.myData[index][DBhelper().columnTitle],
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      state.myData[index][DBhelper()
                                          .columnDesc],
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ),
                      ),
                    ),

                childCount: state.myData.length,
              ),
            )

        );
      },
    );
  }






  Widget BodyContentLandscape(BuildContext context) {
    return BlocBuilder<NotesManageCubit, NotesManageState>(
        builder: (context, state) {
          return Expanded(
        child: GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              QuiltedGridTile(1, 2),
              QuiltedGridTile(1, 2),
              QuiltedGridTile(2, 4),
              QuiltedGridTile(2, 2),
              QuiltedGridTile(2, 2),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
                (context, index) =>
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(

                    onTap: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: ((context) =>
                          notesecondpage(index: index))));
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
                                  BlocProvider.of<NotesManageCubit>(context)
                                      .
                                  delNotes(state.myData[index][DBhelper()
                                      .columnId]);

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
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.myData[index][DBhelper().columnTitle],
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  state.myData[index][DBhelper()
                                      .columnDesc],
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                  ),
                ),

            childCount: state.myData.length,
          ),
        )

    );
  }
  );
}

}