import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/failure.dart';
import 'package:task_trekker/core/base/use_case.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_comment_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/comment_entity.dart';
import 'package:task_trekker/features/kanban_board/domain/repositories/task_repository.dart';

@injectable
class AddComment
    implements UseCase<Either<Failure, CommentEntity>, AddCommentRequestModel> {
  final TaskRepository repository;

  AddComment(this.repository);

  @override
  call(AddCommentRequestModel request) async {
    return await repository.addComment(request: request);
  }
}
