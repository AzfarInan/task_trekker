import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/core/base/use_case.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/get_tasks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class GetTaskCubit extends Cubit<BaseState> {
  GetTaskCubit({
    required this.useCase,
  }) : super(InitialState());

  final GetTasks useCase;

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

  Future<void> getTasks() async {
    emit(const LoadingState());
    try {
      final result = await useCase(NoParams());
      result.fold(
        (l) => emit(ErrorState(data: l.error!.message!)),
        (r) {
          List<TaskEntity> temp = r;

          for (var element in temp) {
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

          return emit(SuccessState(data: r));
        },
      );
    } catch (e) {
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }

  void moveTask(int fromColumn, int toColumn, TaskEntity task) {
    emit(const LoadingAgainState());
    tasks[fromColumn].remove(task);
    tasks[toColumn].add(task);
    emit(SuccessState(data: tasks)); // Emit updated state
  }
}
