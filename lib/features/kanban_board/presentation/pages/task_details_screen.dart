import 'package:flutter/material.dart';
import 'package:task_trekker/core/theme/app_colors.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Text(task.content),
          Text(task.priority.toString()),
          Text(task.labels.first),
        ],
      ),
    );
  }
}
