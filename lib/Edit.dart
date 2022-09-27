import 'package:flutter/material.dart';
import 'package:todo_list/Task.dart';

import 'Priority.dart';

class Edit extends StatefulWidget {
  late Task task;
  final Function onEdit;

  Edit(this.task, {Key? key, required this.onEdit}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late String title;
  late String description;
  late DateTime date;

  @override
  Widget build(BuildContext context) {
    TextEditingController myControllerTitle = TextEditingController();
    myControllerTitle.text = widget.task.title;
    TextEditingController myControllerDescription = TextEditingController();
    myControllerDescription.text = widget.task.description;
    TextEditingController myControllerDate = TextEditingController();
    myControllerDate.text = '${widget.task.date.day}/${widget.task.date.month}/${widget.task.date.year}';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edite uma tarefa"),
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
                    title: const Text("Baixa" , style: TextStyle(fontSize: 15),),
                    value: Priority.low,
                    groupValue: widget.task.priority,
                    onChanged: (Priority? value) {
                      setState(() {
                        widget.task.priority = value!;
                      });
                    },
                  ),
            RadioListTile(
                  title: const Text("Média" , style: TextStyle(fontSize: 15),),
                  value: Priority.medium,
                  groupValue: widget.task.priority,
                  onChanged: (Priority? value) {
                    setState(() {
                      widget.task.priority = value!;
                    });
                  },
                ),
            RadioListTile(
                  title: const Text("Alta", style: TextStyle(fontSize: 15),),
                  value: Priority.high,
                  groupValue: widget.task.priority,
                  onChanged: (Priority? value) {
                    setState(() {
                      widget.task.priority = value!;
                    });
                  },
                ),



            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  widget.task.title = myControllerTitle.text;
                  widget.task.description = myControllerDescription.text;
                  widget.task.date = date;
                  widget.onEdit(widget.task);
                  Navigator.pop(context);
                },
                child: const Text("Editar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
