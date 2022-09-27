import 'package:flutter/material.dart';
import 'package:todo_list/Task.dart';

import 'Add.dart';
import 'Edit.dart';
import 'List.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Seu Todo List em Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ButtonStyle style =
  ElevatedButton.styleFrom(minimumSize: const Size(50, 50), elevation: 3, backgroundColor: Colors.green, textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Welcome to your ToDoApp",style: TextStyle(fontSize: 30)),
          const Image(image: AssetImage("lib/images/todo_logo.png"))
          ,
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => const ListTasks()));

            },
            child: const Text("Iniciar"),
          ),
        ],
      )
    );
  }
}


