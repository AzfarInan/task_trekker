import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_trekker/core/base/use_case.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_comment_request_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/data/models/update_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/comment_entity.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';
import 'package:task_trekker/features/kanban_board/domain/repositories/task_repository.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/add_comment.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/add_task.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/get_comments.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/get_tasks.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/update_task.dart';

import 'task_repository_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late AddComment addComment;
  late AddTask addTask;
  late GetComments getComments;
  late GetTasks getTasks;
  late UpdateTask updateTask;

  late MockTaskRepository mockTaskRepository;

  setUpAll(() {
    mockTaskRepository = MockTaskRepository();
  });

  group('Get Tasks', () {
    setUp(() {
      getTasks = GetTasks(mockTaskRepository);
    });

    final List<TaskEntity> taskList = [
      TaskEntity(
        id: 'id1',
        projectId: 'projectId',
        order: 1,
        content: 'content',
        description: 'description',
        isCompleted: false,
        labels: const ['TODO'],
        priority: 2,
        commentCount: 0,
        createdAt: DateTime.now(),
        url: 'url',
        creatorId: 'creatorId',
      ),
    ];

    test(
      'should get tasks from the task repository',
      () async {
        when(mockTaskRepository.getTasks())
            .thenAnswer((_) async => Right(taskList));

        final result = await getTasks(NoParams());

        expect(result, Right(taskList));

        verify(mockTaskRepository.getTasks());
        verifyNoMoreInteractions(mockTaskRepository);
      },
    );
  });

  group('Add Task', () {
    setUp(() {
      addTask = AddTask(mockTaskRepository);
    });

    final requestModel = AddTaskRequestModel(
      content: 'Test Content',
      description: 'Test Description',
      priority: 2,
      labels: ['TODO'],
    );

    final task = TaskEntity(
      id: 'id2',
      projectId: 'projectId',
      order: 2,
      content: 'Test Content',
      description: 'Test Description',
      isCompleted: false,
      labels: const ['TODO'],
      priority: 2,
      commentCount: 0,
      createdAt: DateTime.now(),
      url: 'url',
      creatorId: 'creatorId',
    );

    test(
      'should add task to the task repository',
      () async {
        when(mockTaskRepository.addTask(request: requestModel))
            .thenAnswer((_) async => Right(task));

        final result = await addTask(requestModel);

        expect(result, Right(task));

        verify(mockTaskRepository.addTask(request: requestModel));
        verifyNoMoreInteractions(mockTaskRepository);
      },
    );
  });

  group('Update Task', () {
    setUp(() {
      updateTask = UpdateTask(mockTaskRepository);
    });

    final request = UpdateTaskRequestModel(
      id: 'id3',
      labels: ['ACTIVE'],
    );

    final task = TaskEntity(
      id: 'id3',
      projectId: 'projectId',
      order: 3,
      content: 'content',
      description: 'description',
      isCompleted: false,
      labels: const ['ACTIVE'],
      priority: 2,
      commentCount: 0,
      createdAt: DateTime.now(),
      url: 'url',
      creatorId: 'creatorId',
    );

    test(
      'should update task in the task repository',
      () async {
        when(mockTaskRepository.updateTask(request: request))
            .thenAnswer((_) async => Right(task));

        final result = await updateTask(request);

        expect(result, Right(task));

        verify(mockTaskRepository.updateTask(request: request));
        verifyNoMoreInteractions(mockTaskRepository);
      },
    );
  });

  group('Get Comments', () {
    setUp(() {
      getComments = GetComments(mockTaskRepository);
    });

    const taskId = 'id4';

    final comments = [
      CommentEntity(
        id: 'id1',
        content: 'Test Comment',
        taskId: 'id4',
        postedAt: DateTime.now(),
      ),
    ];

    test(
      'should get comments from the task repository',
      () async {
        when(mockTaskRepository.getComments(taskId))
            .thenAnswer((_) async => Right(comments));

        final result = await getComments(taskId);

        expect(result, Right(comments));

        verify(mockTaskRepository.getComments(taskId));
        verifyNoMoreInteractions(mockTaskRepository);
      },
    );
  });

  group(
    'Add Comment',
    () {
      setUp(() {
        addComment = AddComment(mockTaskRepository);
      });

      const taskId = 'id5';

      final request = AddCommentRequestModel(
        content: 'Test Comment',
        taskId: 'id5',
      );

      final comment = CommentEntity(
        id: 'id5',
        content: 'Test Comment',
        taskId: 'id5',
        postedAt: DateTime.now(),
      );

      test(
        'should add comment to the task repository',
        () async {
          when(mockTaskRepository.addComment(request: request))
              .thenAnswer((_) async => Right(comment));

          final result = await addComment(request);

          expect(result, Right(comment));
          expect(taskId, Right(comment).value.taskId);

          verify(mockTaskRepository.addComment(request: request));
          verifyNoMoreInteractions(mockTaskRepository);
        },
      );
    },
  );
}
