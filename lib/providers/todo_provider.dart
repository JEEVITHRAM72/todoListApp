import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Task>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Task>> {
  TodoListNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void updateTask(Task updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task
    ];
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }

  void toggleComplete(String id) {
    state = [
      for (final task in state)
        if (task.id == id) task.copyWith(isComplete: !task.isComplete) else task
    ];
  }
} 