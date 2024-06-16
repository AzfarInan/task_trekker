import 'package:dartz/dartz.dart';
import 'package:task_trekker/core/base/failure.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/update_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks();
  Future<Either<Failure, TaskEntity>> addTask({
    required AddTaskRequestModel request,
  });
  Future<Either<Failure, TaskEntity>> updateTask({
    required UpdateTaskRequestModel request,
  });
}
