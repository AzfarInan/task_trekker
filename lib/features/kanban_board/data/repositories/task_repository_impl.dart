import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/failure.dart';
import 'package:task_trekker/features/kanban_board/data/data_sources/task_data_resource.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_comment_request_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/update_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/comment_entity.dart';
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

  @override
  Future<Either<Failure, TaskEntity>> updateTask({
    required UpdateTaskRequestModel request,
  }) async {
    try {
      final task = await remoteDataSource.updateTask(request);
      return Right(task);
    } catch (e) {
      return Left(Failure('Failed to update task'));
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
      String taskId) async {
    try {
      final tasks = await remoteDataSource.getComments(taskId);
      return Right(tasks);
    } catch (e) {
      return Left(Failure('Failed to fetch comments'));
    }
  }

  @override
  Future<Either<Failure, CommentEntity>> addComment({
    required AddCommentRequestModel request,
  }) async {
    try {
      final comment = await remoteDataSource.addComment(request);
      return Right(comment);
    } catch (e) {
      return Left(Failure('Failed to add comment'));
    }
  }
}
