import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/failure.dart';
import 'package:task_trekker/features/kanban_board/data/data_sources/task_data_resource.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';
import 'package:task_trekker/features/kanban_board/domain/repositories/task_repository.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final tasks = await remoteDataSource.getTasks();
      return Right(tasks);
    } catch (e) {
      return Left(Failure('Failed to fetch tasks'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> addTask({
    required AddTaskRequestModel request,
  }) async {
    try {
      final task = await remoteDataSource.addTask(request);
      return Right(task);
    } catch (e) {
      return Left(Failure('Failed to add task'));
    }
  }
}
