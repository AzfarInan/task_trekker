import 'package:task_trekker/features/kanban_board/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.id,
    required super.taskId,
    required super.content,
    required super.postedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      taskId: json['task_id'],
      content: json['content'],
      postedAt: DateTime.parse(json['posted_at']),
    );
  }
}
