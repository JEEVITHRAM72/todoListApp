import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/task.dart';
import 'priority_chip.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final VoidCallback onToggleComplete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onTap,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        leading: GestureDetector(
          onTap: onToggleComplete,
          child: Icon(
            task.isComplete ? Icons.check_circle : Icons.radio_button_unchecked,
            color: task.isComplete ? Colors.green : Colors.grey,
          ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isComplete ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null && task.description!.isNotEmpty)
              Text(task.description!),
            Row(
              children: [
                if (task.dueDate != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      '${task.dueDate!.month}/${task.dueDate!.day}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                PriorityChip(priority: task.priority),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
} 