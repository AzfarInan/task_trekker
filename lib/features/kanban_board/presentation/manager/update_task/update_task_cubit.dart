import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/features/kanban_board/data/models/update_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/update_task.dart';

@injectable
class UpdateTaskCubit extends Cubit<BaseState> {
  UpdateTaskCubit({required this.usecase}) : super(InitialState());

  final UpdateTask usecase;

  Future<void> changeLabel({
    required int index,
    required String taskId,
  }) async {
    emit(const LoadingState());
    try {
      String label = '';
      if (index == 0) {
        label = "TODO";
      } else if (index == 1) {
        label = "In Progress";
      } else if (index == 2) {
        label = "Completed";
      }

      final result = await usecase(
        UpdateTaskRequestModel(
          id: taskId,
          labels: [label],
        ),
      );
      result.fold(
        (l) => emit(ErrorState(data: l.error!.message!)),
        (r) => emit(SuccessState(data: r)),
      );
    } catch (e) {
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }

  Future<void> activateTask({required String taskId}) async {
    emit(const LoadingState());
    try {
      final result = await usecase(
        UpdateTaskRequestModel(
          id: taskId,
          labels: ['ACTIVE'],
        ),
      );
      result.fold(
        (l) => emit(ErrorState(data: l.error!.message!)),
        (r) => emit(SuccessState(data: r)),
      );
    } catch (e) {
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }

  Future<void> deactivateTask({
    required String taskId,
    required int duration,
  }) async {
    emit(const LoadingState());
    try {
      final result = await usecase(
        UpdateTaskRequestModel(
          id: taskId,
          labels: ['In Progress'],
          duration: duration,
          duration_unit: 'minute',
        ),
      );
      result.fold(
        (l) => emit(ErrorState(data: l.error!.message!)),
        (r) => emit(SuccessState(data: r)),
      );
    } catch (e) {
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }
}
