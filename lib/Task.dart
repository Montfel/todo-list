import 'Priority.dart';

class Task {
  int _id;
  String _title;
  String _description;
  Priority _priority;


  Task(this._id, this._title, this._description, this._priority);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

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
