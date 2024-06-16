import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/failure.dart';
import 'package:task_trekker/core/base/use_case.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';
import 'package:task_trekker/features/kanban_board/domain/repositories/task_repository.dart';

@injectable
class GetTasks implements UseCase<Either<Failure, List<TaskEntity>>, NoParams> {
  final TaskRepository repository;

  GetTasks(this.repository);

  @override
  call(NoParams params) async {
    return await repository.getTasks();
  }
}
