import 'package:hive/hive.dart';

part 'cached_task_entity.g.dart';

@HiveType(typeId: 0)
class CachedTaskEntity extends HiveObject {
  @HiveField(0)
  final String taskId;

  @HiveField(1)
  final DateTime taskActivationTime;

  CachedTaskEntity({
    required this.taskId,
    required this.taskActivationTime,
  });

  Map<String, dynamic> toJson() => {
    'taskId': taskId,
    'taskActivationTime': taskActivationTime,
  };

  static CachedTaskEntity fromJson(Map<String, dynamic> json) => CachedTaskEntity(
    taskId: json['taskId'],
    taskActivationTime: json['taskActivationTime'],
  );
}
