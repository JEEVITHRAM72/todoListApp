import 'package:flutter/material.dart';
import '../models/task.dart';

class PriorityChip extends StatelessWidget {
  final Priority priority;
  final bool selected;
  final VoidCallback? onSelected;

  const PriorityChip({
    super.key,
    required this.priority,
    this.selected = false,
    this.onSelected,
  });

  Color get color {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.yellow;
      case Priority.low:
      default:
        return Colors.blue;
    }
  }

  String get label {
    switch (priority) {
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
      default:
        return 'Low';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected != null ? (_) => onSelected!() : null,
      selectedColor: color.withOpacity(0.2),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(color: color),
      side: BorderSide(color: color),
    );
  }
} 