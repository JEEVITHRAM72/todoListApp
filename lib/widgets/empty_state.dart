import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 24),
          const Text('No tasks yet! Add your first task.'),
        ],
      ),
    );
  }
} 