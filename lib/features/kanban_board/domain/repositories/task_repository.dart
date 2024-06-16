import 'package:dartz/dartz.dart';
import 'package:task_trekker/core/base/failure.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks();
}
