import 'package:dashboard/Todo_dash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
//kj

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      home: Scaffold(
        body: TodoListScreen()
      ),
    );
  }
}
