import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/cache_service/cache_manager.dart';

import 'cached_task_entity.dart';

@LazySingleton(as: CacheManager)
class CacheManagerImpl extends CacheManager {
  static const String taskBoxName = 'taskBox';

  CacheManagerImpl() {
    _initBox();
  }

  Future<void> _initBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CachedTaskEntityAdapter());
    }
    if (!Hive.isBoxOpen(taskBoxName)) {
      await Hive.openBox<CachedTaskEntity>(taskBoxName);
    }
  }

  Future<Box<CachedTaskEntity>> _getBox() async {
    await _initBox();
    return Hive.box<CachedTaskEntity>(taskBoxName);
  }

  @override
  Future<void> saveTask(CachedTaskEntity task) async {
    final box = await _getBox();
    await box.put(task.taskId, task);
  }

  @override
  Future<List<CachedTaskEntity>> getTasks() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<CachedTaskEntity?> getTaskById(String taskId) async {
    final box = await _getBox();
    return box.get(taskId);
  }

  @override
  Future<void> removeTaskById(String taskId) async {
    final box = await _getBox();
    await box.delete(taskId);
  }

  @override
  Future<void> clearTasks() async {
    final box = await _getBox();
    await box.clear();
  }
}
