import 'Priority.dart';

class Task {
  final String id;
  String title;
  String description;
  DateTime date;
  Priority priority;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.date,
      required this.priority});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toString(),
      'priority': priority.index,
    };
  }

  static Task fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        date: DateTime.parse(json['date']),
        priority: Priority.values[json['priority']],
      );
}
