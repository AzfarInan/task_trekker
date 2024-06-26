import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'due.dart';
part 'task_duration.dart';

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
  int commentCount;
  final String creatorId;
  final DateTime createdAt;
  final Due? due;
  final String url;
  TaskDuration? duration;

  TaskEntity({
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

  bool isTodoTask() => labels.contains('TODO');
  bool isActiveTask() => labels.contains('ACTIVE');
  bool isInProgressTask() => labels.contains('In Progress');
  bool isCompletedTask() => labels.contains('Completed');

  void updateDuration(int value) {
    duration = TaskDuration(amount: value, unit: 'minute');
  }

  String getPriority() {
    switch (priority) {
      case 1:
        return 'LOW';
      case 2:
        return 'MEDIUM';
      case 3:
        return 'HIGH';
      case 4:
        return 'URGENT';
      default:
        return 'LOW';
    }
  }

  String getDuration() {
    if (duration != null) {
      return '${duration!.amount} ${duration!.unit}s';
    }
    return '0 minutes';
  }

  String getCompletedOn() {
    if (due != null) {
      return due!.date.toString();
    }

    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  int getActivatedTime() {
    if (duration != null) {
      return duration!.amount;
    } else {
      return 0;
    }
  }

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