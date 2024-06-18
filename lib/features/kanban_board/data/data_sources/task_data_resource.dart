import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/network/network_service.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_comment_request_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/comment_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/task_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/update_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/comment_entity.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> addTask(AddTaskRequestModel request);
  Future<TaskModel> updateTask(UpdateTaskRequestModel request);
  Future<List<CommentEntity>> getComments(String taskId);
  Future<CommentModel> addComment(AddCommentRequestModel request);
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

  @override
  Future<TaskModel> addTask(AddTaskRequestModel request) async {
    final response = await networkService.dio.post(
      '/tasks',
      data: {
        'content': request.content,
        'description': request.description,
        'priority': request.priority,
        'labels': request.labels,
      },
    );

    if (response.statusCode == 200) {
      return TaskModel.fromJson(response.data);
    } else {
      throw Exception('Failed to add task');
    }
  }

  @override
  Future<TaskModel> updateTask(UpdateTaskRequestModel request) async {
    final response = await networkService.dio.post(
      '/tasks/${request.id}',
      data: {
        if (request.labels != null) 'labels': request.labels,
        if (request.due_date != null) 'due_date': request.due_date,
        if (request.duration != null) 'duration': request.duration,
        if (request.duration_unit != null)
          'duration_unit': request.duration_unit,
      },
    );

    if (response.statusCode == 200) {
      return TaskModel.fromJson(response.data);
    } else {
      throw Exception('Failed to update task');
    }
  }

  @override
  Future<List<CommentEntity>> getComments(String taskId) async {
    final response = await networkService.dio.get('/comments?task_id=$taskId');

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  @override
  Future<CommentModel> addComment(AddCommentRequestModel request) async {
    final response = await networkService.dio.post(
      '/comments',
      data: {
        'content': request.content,
        'task_id': request.taskId,
      },
    );

    if (response.statusCode == 200) {
      return CommentModel.fromJson(response.data);
    } else {
      throw Exception('Failed to add comment');
    }
  }
}
