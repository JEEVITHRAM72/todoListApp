import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  DateTime? dueDate;
  @HiveField(4)
  bool isComplete;
  @HiveField(5)
  Priority priority;

  Task({
    String? id,
    required this.title,
    this.description,
    this.dueDate,
    this.isComplete = false,
    this.priority = Priority.low,
  }) : id = id ?? const Uuid().v4();

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isComplete,
    Priority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isComplete: isComplete ?? this.isComplete,
      priority: priority ?? this.priority,
    );
  }
}
