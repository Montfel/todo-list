import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/Task.dart';

import 'DateField.dart';
import 'Priority.dart';
import 'RadioGroup.dart';

class Edit extends StatefulWidget {
  late Task task;

  Edit(this.task, {Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    onPriorityClick(value) {
      widget.task.priority = value;
    }

    onDateClick(value) {
      widget.task.date = value;
    }

    TextEditingController myControllerTitle = TextEditingController();
    myControllerTitle.text = widget.task.title;
    TextEditingController myControllerDescription = TextEditingController();
    myControllerDescription.text = widget.task.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edite uma tarefa"),
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
                  child: DateField(widget.task.date, onDateClick: onDateClick)),
              const Text("Prioridade da tarefa"),
              RadioGroup(widget.task.priority,
                  onPriorityClick: onPriorityClick),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    widget.task.title = myControllerTitle.text;
                    widget.task.description = myControllerDescription.text;
                    updateTask(
                        widget.task.id,
                        myControllerTitle.text,
                        myControllerDescription.text,
                        widget.task.date,
                        widget.task.priority);
                    Navigator.pop(context);
                  },
                  child: const Text("Editar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future updateTask(String id, String title, String description, DateTime date,
      Priority priority) async {
    final docTask = FirebaseFirestore.instance.collection('tasks').doc(id);
    docTask.update({
      'title': title,
      'description': description,
      'date': date.toString(),
      'priority': priority.index,
    });
  }
}
