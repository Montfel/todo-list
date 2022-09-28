import 'package:flutter/material.dart';
import 'package:todo_list/Task.dart';

import 'Priority.dart';

class RadioGroup extends StatefulWidget {
  late Priority priority;
  final Function onPriorityClick;

  RadioGroup(this.priority, {Key? key, required this.onPriorityClick}): super(key: key);

  @override
  State<RadioGroup> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RadioListTile(
        title: const Text(
          "Baixa",
          style: TextStyle(fontSize: 15),
        ),
        value: Priority.low,
        groupValue: widget.priority,
        onChanged: (Priority? value) {
          setState(() {
            widget.priority = value!;
            widget.onPriorityClick(value);
          });
        },
      ),
      RadioListTile(
        title: const Text(
          "Média",
          style: TextStyle(fontSize: 15),
        ),
        value: Priority.medium,
        groupValue: widget.priority,
        onChanged: (Priority? value) {
          setState(() {
            widget.priority = value!;
            widget.onPriorityClick(value);
          });
        },
      ),
      RadioListTile(
        title: const Text(
          "Alta",
          style: TextStyle(fontSize: 15),
        ),
        value: Priority.high,
        groupValue: widget.priority,
        onChanged: (Priority? value) {
          setState(() {
            widget.priority = value!;
            widget.onPriorityClick(value);
          });
        },
      )
    ]);
  }
}
