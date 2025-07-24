import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../providers/todo_provider.dart';
import '../widgets/priority_chip.dart';

class AddEditTaskScreen extends ConsumerStatefulWidget {
  final Task? task;
  const AddEditTaskScreen({super.key, this.task});

  @override
  ConsumerState<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends ConsumerState<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  String? _description;
  DateTime? _dueDate;
  Priority _priority = Priority.low;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _dueDate = widget.task!.dueDate;
      _priority = widget.task!.priority;
    } else {
      _title = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title *'),
                validator: (value) => value == null || value.isEmpty ? 'Title required' : null,
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Due Date'),
                subtitle: Text(_dueDate != null ? _dueDate!.toLocal().toString().split(' ')[0] : 'None'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _dueDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) setState(() => _dueDate = picked);
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Priority:'),
                  const SizedBox(width: 8),
                  for (final p in Priority.values)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: PriorityChip(
                        priority: p,
                        selected: _priority == p,
                        onSelected: () => setState(() => _priority = p),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final notifier = ref.read(todoListProvider.notifier);
                    if (widget.task == null) {
                      notifier.addTask(Task(
                        title: _title,
                        description: _description,
                        dueDate: _dueDate,
                        priority: _priority,
                      ));
                    } else {
                      notifier.updateTask(widget.task!.copyWith(
                        title: _title,
                        description: _description,
                        dueDate: _dueDate,
                        priority: _priority,
                      ));
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.task == null ? 'Add Task' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
