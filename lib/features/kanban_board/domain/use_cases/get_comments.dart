import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/failure.dart';
import 'package:task_trekker/core/base/use_case.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/comment_entity.dart';
import 'package:task_trekker/features/kanban_board/domain/repositories/task_repository.dart';

@injectable
class GetComments implements UseCase<Either<Failure, List<CommentEntity>>, String> {
  final TaskRepository repository;

  GetComments(this.repository);

  @override
  call(String taskId) async {
    return await repository.getComments(taskId);
  }
}
