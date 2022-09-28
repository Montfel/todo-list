import 'package:flutter/material.dart';
import 'package:todo_list/Task.dart';

import 'Priority.dart';

class DateField extends StatefulWidget {
  late DateTime date;
  final Function onDateClick;

  DateField(this.date, {Key? key, required this.onDateClick}) : super(key: key);

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {

  @override
  Widget build(BuildContext context) {
    TextEditingController myControllerDate = TextEditingController();
    myControllerDate.text ='${widget.date.day}/${widget.date.month}/${widget.date.year}';
    return TextField(
      readOnly: true,
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2030));
        if (newDate == null) return;
        setState(() {
          widget.date = newDate;
          widget.onDateClick(newDate);
        });
      },
      controller: myControllerDate,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Data da tarefa',
      ),
    );
  }
}
