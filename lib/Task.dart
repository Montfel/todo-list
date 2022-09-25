import 'package:uuid/uuid.dart';

import 'Priority.dart';

class Task {
  final String _id = const Uuid().v1();
  String _title;
  String _description;
  Priority _priority;


  Task(this._title, this._description, this._priority);

  String get id => _id;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  Priority get priority => _priority;

  set priority(Priority value) {
    _priority = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }
}
