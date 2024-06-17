import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/core/cache_service/cache_manager.dart';
import 'package:task_trekker/core/cache_service/cached_task_entity.dart';

part 'task_timer_state.dart';

@injectable
class TaskTimerCubit extends Cubit<BaseState> {
  TaskTimerCubit(this._cacheManager) : super(InitialState());

  final CacheManager _cacheManager;

  /// Get Task
  Future<void> getTask(String taskId) async {
    print('AZFAR: getTask');
    emit(const LoadingState());
    try {
      final CachedTaskEntity? task = await _cacheManager.getTaskById(taskId);
      print("AZFAR: success: $task");
      if (task != null) {
        emit(GetTaskSuccessState(data: task));
      } else {
        emit(const ErrorState(data: 'Task not found'));
      }
    } catch (e) {
      print("AZFAR: error: $e");
      emit(const ErrorState(data: 'An error occurred while fetching the task'));
    }
  }

  /// Save Task
  Future<void> saveTask(CachedTaskEntity task) async {
    emit(const LoadingState());
    try {
      await _cacheManager.saveTask(task);
      emit(const SaveTaskSuccessState(data: 'Task saved successfully'));
    } catch (e) {
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }

  /// Remove Task
  Future<void> removeTask(String taskId) async {
    emit(const LoadingState());
    try {
      await _cacheManager.removeTaskById(taskId);
      emit(const RemoveTaskSuccessState(data: 'Task removed successfully'));
    } catch (e) {
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }
}
