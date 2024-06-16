import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/network/network_service.dart';
import 'package:task_trekker/features/kanban_board/data/models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
}

@LazySingleton(as: TaskRemoteDataSource)
class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final NetworkService networkService;

  TaskRemoteDataSourceImpl(this.networkService);

  @override
  Future<List<TaskModel>> getTasks() async {
    final response = await networkService.dio.get('/tasks');

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
