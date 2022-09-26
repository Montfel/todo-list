import 'package:flutter/material.dart';
import 'package:todo_list/Task.dart';

import 'Add.dart';
import 'Edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<Task> tasks = [];

  onAddFunction(task) {
    setState(() {
      tasks.add(task);
    });
  }

  onEditFunction(task) {
    setState(() {
      int taskId = tasks.indexWhere((element) => element.id == task.id);
      tasks[taskId] = task;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Edit(tasks[index], onEdit: onEditFunction)));
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text("Excluir tarefa"),
                          content: const Text("Deseja excluir a tarefa?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  tasks.removeAt(index);
                                });
                                Navigator.pop(context);
                              },
                              child: const Text("Sim"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Não"),
                            ),
                          ],
                        ));
              },
              title: Text(tasks[index].title),
              subtitle: Text(tasks[index].description),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Add(onAdd: onAddFunction)));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
