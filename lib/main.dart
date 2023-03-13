import 'package:flutter/material.dart';
import 'todo_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 162, 210, 255)),
        home: const Scaffold(
          body: TodoPage(),
        ));
  }
}
