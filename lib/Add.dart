import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/Task.dart';

import 'Priority.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  Priority? _priority = Priority.medium;
  final myControllerTitle = TextEditingController();
  final myControllerDescription = TextEditingController();
  final myControllerDate = TextEditingController();
  late String title;
  late String description;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    myControllerDate.text = '${date.day}/${date.month}/${date.year}';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicione uma tarefa"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: myControllerTitle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título da tarefa',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextField(
                  controller: myControllerDescription,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descrição da tarefa',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextField(
                  readOnly: true,
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030));
                    if (newDate == null) return;
                    setState(() {
                      date = newDate;
                    });
                  },
                  controller: myControllerDate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data da tarefa',
                  ),
                ),
              ),
              const Text("Prioridade da tarefa"),
              RadioListTile(
                title: const Text(
                  "Baixa",
                  style: TextStyle(fontSize: 15),
                ),
                value: Priority.low,
                groupValue: _priority,
                onChanged: (Priority? value) {
                  setState(() {
                    _priority = value;
                  });
                },
              ),
              RadioListTile(
                title: const Text(
                  "Média",
                  style: TextStyle(fontSize: 15),
                ),
                value: Priority.medium,
                groupValue: _priority,
                onChanged: (Priority? value) {
                  setState(() {
                    _priority = value;
                  });
                },
              ),
              RadioListTile(
                title: const Text(
                  "Alta",
                  style: TextStyle(fontSize: 15),
                ),
                value: Priority.high,
                groupValue: _priority,
                onChanged: (Priority? value) {
                  setState(() {
                    _priority = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    createTask(myControllerTitle.text,
                        myControllerDescription.text, date, _priority!);
                    Navigator.pop(context);
                  },
                  child: const Text("Adicionar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createTask(String title, String description, DateTime date,
      Priority priority) async {
    final docTask = FirebaseFirestore.instance.collection('tasks').doc();
    final task = Task(
        id: docTask.id,
        title: title,
        description: description,
        date: date,
        priority: priority);
    final json = task.toJson();
    await docTask.set(json);
  }
}
