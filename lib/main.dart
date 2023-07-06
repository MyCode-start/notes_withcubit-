import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_integration/color_selection_manage_cubit.dart';
import 'cubit_integration/notes_manage_cubit.dart';
import 'new_home_page.dart';
import 'notes_home_cubit.dart';


void main() {
  runApp( MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider<NotesManageCubit>(create: (context) => NotesManageCubit()),
          BlocProvider<ColorSelectionManageCubit>(create: (context) => ColorSelectionManageCubit()),
    ], child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: newmainnotespagefromprovider(),
    ),
    );
  }
}
