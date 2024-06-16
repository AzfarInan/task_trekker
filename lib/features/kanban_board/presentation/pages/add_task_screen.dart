import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trekker/core/theme/app_colors.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/add_task/add_task_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/get_task/get_task_cubit.dart';
import 'package:task_trekker/features/shared/presentation/widgets/button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  AddTaskScreenState createState() => AddTaskScreenState();
}

class AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  int _selectedPriority = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: AppColors.primary,
      ),
      body: BlocListener<AddTaskCubit, BaseState>(
        listener: (context, state) {
          if (state is SuccessState) {
            BlocProvider.of<GetTaskCubit>(context).addTask(state.data);
            Navigator.of(context).pop();
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.data!),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: context.read<AddTaskCubit>().contentController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter content';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller:
                      context.read<AddTaskCubit>().descriptionController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<int>(
                  value: _selectedPriority,
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('1 - Low')),
                    DropdownMenuItem(value: 2, child: Text('2 - Medium')),
                    DropdownMenuItem(value: 3, child: Text('3 - High')),
                    DropdownMenuItem(value: 4, child: Text('4 - Urgent')),
                  ],
                  dropdownColor: AppColors.white,
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a priority';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Button(
                  label: 'Add Task',
                  isLoading: context.select(
                    (AddTaskCubit cubit) => cubit.state is LoadingState,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AddTaskCubit>().addTask(
                            priority: _selectedPriority,
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
