import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/failure.dart';
import 'package:task_trekker/core/base/use_case.dart';
import 'package:task_trekker/features/kanban_board/data/models/update_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';
import 'package:task_trekker/features/kanban_board/domain/repositories/task_repository.dart';

@injectable
class UpdateTask
    implements UseCase<Either<Failure, TaskEntity>, UpdateTaskRequestModel> {
  final TaskRepository repository;

  UpdateTask(this.repository);

  @override
  call(UpdateTaskRequestModel request) async {
    return await repository.updateTask(request: request);
  }
}
