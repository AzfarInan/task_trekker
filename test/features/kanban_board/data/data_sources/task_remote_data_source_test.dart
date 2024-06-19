import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:task_trekker/core/network/network_service.dart';
import 'package:task_trekker/features/kanban_board/data/data_sources/task_data_source.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_comment_request_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/comment_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/task_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/update_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/comment_entity.dart';

import 'task_remote_data_source_test.mocks.dart';

@GenerateMocks([NetworkService, Dio])
void main() {
  late TaskRemoteDataSourceImpl dataSource;
  late MockNetworkService mockNetworkService;
  late MockDio mockDio;

  setUp(() {
    mockNetworkService = MockNetworkService();
    mockDio = MockDio();
    when(mockNetworkService.dio).thenReturn(mockDio);
    dataSource = TaskRemoteDataSourceImpl(mockNetworkService);
  });

  group('getTasks', () {
    test('should return a list of TaskModel when the call to the API is successful', () async {
      // Arrange
      final tasksJson = [
        {
          'id': 'id',
          'projectId': 'projectId',
          'order': 1,
          'content': 'content',
          'description': 'description',
          'isCompleted': false,
          'labels': ['TODO'],
          'priority': 2,
          'commentCount': 0,
          'createdAt': '2023-06-19T00:00:00.000Z',
          'url': 'url',
          'creatorId': 'creatorId'
        }
      ];
      final response = Response(data: tasksJson, statusCode: 200, requestOptions: RequestOptions(path: '/tasks'));
      when(mockDio.get('/tasks')).thenAnswer((_) async => response);

      // Act
      final result = await dataSource.getTasks();

      // Assert
      expect(result, isA<List<TaskModel>>());
      expect(result.length, 1);
      verify(mockDio.get('/tasks'));
    });

    test('should throw an exception when the call to the API is unsuccessful', () async {
      // Arrange
      final response = Response(data: 'Error', statusCode: 404, requestOptions: RequestOptions(path: '/tasks'));
      when(mockDio.get('/tasks')).thenAnswer((_) async => response);

      // Act & Assert
      expect(() => dataSource.getTasks(), throwsA(isA<Exception>()));
      verify(mockDio.get('/tasks'));
    });
  });

  group('addTask', () {
    final requestModel = AddTaskRequestModel(
      content: 'Test Content',
      description: 'Test Description',
      priority: 2,
      labels: ['TODO'],
    );

    test('should return TaskModel when the call to the API is successful', () async {
      // Arrange
      final taskJson = {
        'id': 'id',
        'projectId': 'projectId',
        'order': 1,
        'content': 'Test Content',
        'description': 'Test Description',
        'isCompleted': false,
        'labels': ['TODO'],
        'priority': 2,
        'commentCount': 0,
        'createdAt': '2023-06-19T00:00:00.000Z',
        'url': 'url',
        'creatorId': 'creatorId'
      };
      final response = Response(data: taskJson, statusCode: 200, requestOptions: RequestOptions(path: '/tasks'));
      when(mockDio.post('/tasks', data: anyNamed('data'))).thenAnswer((_) async => response);

      // Act
      final result = await dataSource.addTask(requestModel);

      // Assert
      expect(result, isA<TaskModel>());
      verify(mockDio.post('/tasks', data: anyNamed('data')));
    });

    test('should throw an exception when the call to the API is unsuccessful', () async {
      // Arrange
      final response = Response(data: 'Error', statusCode: 400, requestOptions: RequestOptions(path: '/tasks'));
      when(mockDio.post('/tasks', data: anyNamed('data'))).thenAnswer((_) async => response);

      // Act & Assert
      expect(() => dataSource.addTask(requestModel), throwsA(isA<Exception>()));
      verify(mockDio.post('/tasks', data: anyNamed('data')));
    });
  });

  group('updateTask', () {
    final requestModel = UpdateTaskRequestModel(
      id: 'id',
      labels: ['ACTIVE'],
    );

    test('should return TaskModel when the call to the API is successful', () async {
      // Arrange
      final taskJson = {
        'id': 'id',
        'projectId': 'projectId',
        'order': 1,
        'content': 'content',
        'description': 'description',
        'isCompleted': false,
        'labels': ['ACTIVE'],
        'priority': 2,
        'commentCount': 0,
        'createdAt': '2023-06-19T00:00:00.000Z',
        'url': 'url',
        'creatorId': 'creatorId'
      };
      final response = Response(data: taskJson, statusCode: 200, requestOptions: RequestOptions(path: '/tasks/id'));
      when(mockDio.post('/tasks/id', data: anyNamed('data'))).thenAnswer((_) async => response);

      // Act
      final result = await dataSource.updateTask(requestModel);

      // Assert
      expect(result, isA<TaskModel>());
      verify(mockDio.post('/tasks/id', data: anyNamed('data')));
    });

    test('should throw an exception when the call to the API is unsuccessful', () async {
      // Arrange
      final response = Response(data: 'Error', statusCode: 400, requestOptions: RequestOptions(path: '/tasks/id'));
      when(mockDio.post('/tasks/id', data: anyNamed('data'))).thenAnswer((_) async => response);

      // Act & Assert
      expect(() => dataSource.updateTask(requestModel), throwsA(isA<Exception>()));
      verify(mockDio.post('/tasks/id', data: anyNamed('data')));
    });
  });

  group('getComments', () {
    const taskId = 'id';

    test('should return a list of CommentModel when the call to the API is successful', () async {
      // Arrange
      final commentsJson = [
        {
          'id': 'id',
          'content': 'Test Comment',
          'taskId': 'id',
          'postedAt': '2023-06-19T00:00:00.000Z'
        }
      ];
      final response = Response(data: commentsJson, statusCode: 200, requestOptions: RequestOptions(path: '/comments'));
      when(mockDio.get('/comments?task_id=$taskId')).thenAnswer((_) async => response);

      // Act
      final result = await dataSource.getComments(taskId);

      // Assert
      expect(result, isA<List<CommentEntity>>());
      expect(result.length, 1);
      verify(mockDio.get('/comments?task_id=$taskId'));
    });

    test('should throw an exception when the call to the API is unsuccessful', () async {
      // Arrange
      final response = Response(data: 'Error', statusCode: 404, requestOptions: RequestOptions(path: '/comments'));
      when(mockDio.get('/comments?task_id=$taskId')).thenAnswer((_) async => response);

      // Act & Assert
      expect(() => dataSource.getComments(taskId), throwsA(isA<Exception>()));
      verify(mockDio.get('/comments?task_id=$taskId'));
    });
  });

  group('addComment', () {
    final requestModel = AddCommentRequestModel(
      content: 'Test Comment',
      taskId: 'id',
    );

    test('should return CommentModel when the call to the API is successful', () async {
      // Arrange
      final commentJson = {
        'id': 'id',
        'content': 'Test Comment',
        'taskId': 'id',
        'postedAt': '2023-06-19T00:00:00.000Z'
      };
      final response = Response(data: commentJson, statusCode: 200, requestOptions: RequestOptions(path: '/comments'));
      when(mockDio.post('/comments', data: anyNamed('data'))).thenAnswer((_) async => response);

      // Act
      final result = await dataSource.addComment(requestModel);

      // Assert
      expect(result, isA<CommentModel>());
      verify(mockDio.post('/comments', data: anyNamed('data')));
    });

    test('should throw an exception when the call to the API is unsuccessful', () async {
      // Arrange
      final response = Response(data: 'Error', statusCode: 400, requestOptions: RequestOptions(path: '/comments'));
      when(mockDio.post('/comments', data: anyNamed('data'))).thenAnswer((_) async => response);

      // Act & Assert
      expect(() => dataSource.addComment(requestModel), throwsA(isA<Exception>()));
      verify(mockDio.post('/comments', data: anyNamed('data')));
    });
  });
}
