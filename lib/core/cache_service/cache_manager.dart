import 'package:task_trekker/core/cache_service/cached_task_entity.dart';

abstract class CacheManager {
  Future<void> saveTask(CachedTaskEntity task);
  Future<List<CachedTaskEntity>> getTasks();
  Future<CachedTaskEntity?> getTaskById(String taskId);
  Future<void> removeTaskById(String taskId);
  void clearTasks();
}
