import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class TaskManagerCubit extends Cubit<BaseState> {
  TaskManagerCubit() : super(InitialState());

  final List<TaskEntity> todoTasks = [];
  final List<TaskEntity> inProgressTasks = [];
  final List<TaskEntity> doneTasks = [];
  TaskEntity? activeTask;

  final List<List<TaskEntity>> tasks = [
    [],
    [],
    [],
  ];

  int draggedFromColumn = 0;
  TaskEntity? draggedTask;

  void initiateTasks(List<TaskEntity> t) {
    emit(const LoadingState());

    for (var element in t) {
      if (element.isTodoTask()) {
        todoTasks.add(element);
      } else if (element.isInProgressTask()) {
        inProgressTasks.add(element);
      } else if (element.isCompletedTask()) {
        doneTasks.add(element);
      } else if (element.isActiveTask()) {
        activeTask = element;
        inProgressTasks.add(element);
      }
    }

    tasks[0] = todoTasks;
    tasks[1] = inProgressTasks;
    tasks[2] = doneTasks;

    return emit(const SuccessState());
  }

  void addTask(TaskEntity taskEntity) {
    emit(const LoadingState());
    todoTasks.add(taskEntity);
    tasks[0] = todoTasks;
    emit(SuccessState(data: tasks)); // Emit updated state
  }

  void moveTask(int fromColumn, int toColumn, TaskEntity task) {
    emit(const LoadingState());
    tasks[fromColumn].remove(task);
    tasks[toColumn].add(task);
    emit(SuccessState(data: tasks)); // Emit updated state
  }
}
