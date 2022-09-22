import 'package:flutter/material.dart';
import 'package:todo_list/Task.dart';

import 'Priority.dart';

class Edit extends StatefulWidget {
  late Task task;
  final Function onEdit;
  Edit({Key? key, required Task task, required this.onEdit}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  Priority? _priority = Priority.medium;
  final myControllerTitle = TextEditingController();
  final myControllerDescription = TextEditingController();
  late String title;
  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicione uma tarefa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: myControllerTitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Título da tarefa',
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: TextField(
                controller: myControllerDescription,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descrição da tarefa',
                ),
              ),
            ),

            RadioListTile(
              title: const Text("Baixa"),
              value: Priority.low,
              groupValue: _priority,
              onChanged: (Priority? value) {
                setState(() {
                  _priority = value;
                });
              },
            ),
            RadioListTile(
              title: const Text("Média"),
              value: Priority.medium,
              groupValue: _priority,
              onChanged: (Priority? value) {
                setState(() {
                  _priority = value;
                });
              },
            ),
            RadioListTile(
              title: const Text("Alta"),
              value: Priority.high,
              groupValue: _priority,
              onChanged: (Priority? value) {
                setState(() {
                  _priority = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  widget.onEdit(Task(1, myControllerTitle.text, myControllerDescription.text, _priority!!));
                  Navigator.pop(context);
                },
                child: const Text("Adicionar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
