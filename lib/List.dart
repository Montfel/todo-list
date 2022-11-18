import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Task.dart';

import 'Add.dart';
import 'Edit.dart';
import 'GoogleSignInProvider.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({Key? key}) : super(key: key);

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
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
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          )
        ],
      ),
      body: StreamBuilder<List<Task>>(
        stream: readTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Algo deu errado');
          } else if (snapshot.hasData) {
            final tasks = snapshot.data!;
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                tasks.isEmpty
                    ? const Center(
                        child: Text(
                          "Insira uma nova Tarefa",
                          style: TextStyle(fontSize: 30),
                        ),
                      )
                    : ListView.builder(
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
                                            Edit(tasks[index])));
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text("Excluir tarefa"),
                                          content: const Text(
                                              "Deseja excluir a tarefa?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                deleteTask(tasks[index].id);
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
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Add()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future deleteTask(String id) async {
    final docTask = FirebaseFirestore.instance.collection('tasks').doc(id);
    docTask.delete();
  }

  Stream<List<Task>> readTasks() => FirebaseFirestore.instance
      .collection('tasks')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());
}
