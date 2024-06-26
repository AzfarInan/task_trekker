import 'package:equatable/equatable.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    super.assignerId,
    super.assigneeId,
    required super.projectId,
    super.sectionId,
    super.parentId,
    required super.order,
    required super.content,
    required super.description,
    required super.isCompleted,
    required super.labels,
    required super.priority,
    required super.commentCount,
    required super.creatorId,
    required super.createdAt,
    Due? due,
    required super.url,
    super.duration,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      assignerId: json['assigner_id'],
      assigneeId: json['assignee_id'],
      projectId: json['project_id'],
      sectionId: json['section_id'],
      parentId: json['parent_id'],
      order: json['order'],
      content: json['content'],
      description: json['description'],
      isCompleted: json['is_completed'],
      labels: List<String>.from(json['labels']),
      priority: json['priority'],
      commentCount: json['comment_count'],
      creatorId: json['creator_id'],
      createdAt: DateTime.parse(json['created_at']),
      due: json['due'] != null ? Due.fromJson(json['due']) : null,
      url: json['url'],
      duration: json['duration'] != null
          ? TaskDuration(
              amount: json['duration']['amount'],
              unit: json['duration']['unit'],
            )
          : null,
    );
  }
}

class Due extends Equatable {
  final DateTime date;
  final String? timezone;
  final String dateString;
  final String lang;
  final bool isRecurring;
  final DateTime? datetime;

  const Due({
    required this.date,
    this.timezone,
    required this.dateString,
    required this.lang,
    required this.isRecurring,
    this.datetime,
  });

  factory Due.fromJson(Map<String, dynamic> json) {
    return Due(
      date: DateTime.parse(json['date']),
      timezone: json['timezone'],
      dateString: json['string'],
      lang: json['lang'],
      isRecurring: json['is_recurring'],
      datetime:
          json['datetime'] != null ? DateTime.parse(json['datetime']) : null,
    );
  }

  @override
  List<Object?> get props =>
      [date, timezone, dateString, lang, isRecurring, datetime];
}
