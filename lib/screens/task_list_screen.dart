import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart';
import '../widgets/task_item.dart';
import '../widgets/empty_state.dart';
import 'add_edit_task_screen.dart';
import 'package:lottie/lottie.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: TextStyle(
            fontFamily: 'Montserrat', // Add a custom font if you like
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            // TODO: Implement pull-to-refresh with backend
          },
          child: tasks.isEmpty
              ? const EmptyState()
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: Icon(
                          task.isComplete ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: task.isComplete ? Colors.green : Colors.grey,
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: task.isComplete ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: Text(task.description ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                task.isComplete ? Icons.undo : Icons.check,
                                color: task.isComplete ? Colors.orange : Colors.green,
                              ),
                              tooltip: task.isComplete ? 'Mark as Incomplete' : 'Mark as Complete',
                              onPressed: () {
                                ref.read(todoListProvider.notifier).toggleComplete(task.id);
                              },
                            ),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditTaskScreen(task: task),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, size: 32),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditTaskScreen()),
          );
        },
      ),
    );
  }
}
