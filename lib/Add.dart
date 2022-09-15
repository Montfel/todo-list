import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

enum priority { low, medium, high }

class _AddState extends State<Add> {
  priority? _priority = priority.medium;

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
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Título da tarefa',
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descrição da tarefa',
                ),
              ),
            ),

            RadioListTile(
              title: const Text("Baixa"),
              value: priority.low,
              groupValue: _priority,
              onChanged: (priority? value) {
                setState(() {
                  _priority = value;
                });
              },
            ),
            RadioListTile(
              title: const Text("Média"),
              value: priority.medium,
              groupValue: _priority,
              onChanged: (priority? value) {
                setState(() {
                  _priority = value;
                });
              },
            ),
            RadioListTile(
              title: const Text("Alta"),
              value: priority.high,
              groupValue: _priority,
              onChanged: (priority? value) {
                setState(() {
                  _priority = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Adicionar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
