import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Priority.dart';

class Task {
  final String _id = const Uuid().v1();
  String _title;
  String _description;
  DateTime _date;
  Priority _priority;

  Task(this._title, this._description, this._date, this._priority);

  String get id => _id;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  Priority get priority => _priority;

  set priority(Priority value) {
    _priority = value;
  }
}
