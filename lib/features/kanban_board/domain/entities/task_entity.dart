import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String? assignerId;
  final String? assigneeId;
  final String projectId;
  final String? sectionId;
  final String? parentId;
  final int order;
  final String content;
  final String description;
  final bool isCompleted;
  final List<String> labels;
  final int priority;
  final int commentCount;
  final String creatorId;
  final DateTime createdAt;
  final Due? due;
  final String url;
  final Duration? duration;

  const TaskEntity({
    required this.id,
    this.assignerId,
    this.assigneeId,
    required this.projectId,
    this.sectionId,
    this.parentId,
    required this.order,
    required this.content,
    required this.description,
    required this.isCompleted,
    required this.labels,
    required this.priority,
    required this.commentCount,
    required this.creatorId,
    required this.createdAt,
    this.due,
    required this.url,
    this.duration,
  });

  @override
  List<Object?> get props => [
        id,
        content,
        isCompleted,
        labels,
        priority,
        due,
        duration,
      ];
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

  /// toJson method
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'timezone': timezone,
      'date_string': dateString,
      'lang': lang,
      'is_recurring': isRecurring,
      'datetime': datetime?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        date,
        timezone,
        dateString,
        lang,
        isRecurring,
        datetime,
      ];
}
