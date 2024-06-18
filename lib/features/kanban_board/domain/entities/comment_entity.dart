import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String content;
  final String taskId;
  final DateTime postedAt;

  const CommentEntity({
    required this.id,
    required this.content,
    required this.taskId,
    required this.postedAt,
  });

  String getDate() {
    return '${postedAt.day}/${postedAt.month}/${postedAt.year}';
  }

  @override
  List<Object?> get props => [id, content, taskId, postedAt];
}
