import 'package:flutter/material.dart';
import 'package:todo_list/Task.dart';

import 'Priority.dart';

class Add extends StatefulWidget {
  final Function onAdd;

  const Add({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
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
            const Text("Prioridade da tarefa"),
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
                  widget.onAdd(Task(myControllerTitle.text,
                      myControllerDescription.text, _priority!));
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
