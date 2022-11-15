import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/Task.dart';

import 'Add.dart';
import 'Edit.dart';
import 'GoogleSignInProvider.dart';
import 'package:provider/provider.dart';


class ListTasks extends StatefulWidget {
  const ListTasks({Key? key}) : super(key: key);

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {

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
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          tasks.isEmpty?
          const Center(child: Text("Insira uma nova Tarefa" , style: TextStyle(fontSize: 30),),)
          :ListView.builder(
            shrinkWrap: true,
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
          )
        ],
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
