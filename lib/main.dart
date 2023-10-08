import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sqflite_bloc/screens/home/home_screen.dart';
import 'package:todo_app_sqflite_bloc/todo_bloc/todo_bloc.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context)=>TodoBloc()),
          ],
          child: HomeScreen()),
    );
  }
}
