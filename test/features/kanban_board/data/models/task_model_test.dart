import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:task_trekker/features/kanban_board/data/models/task_model.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateMocks([TaskModel])
void main() {
  final taskModel = TaskModel(
    id: '8116674865',
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
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('task.json'));
        // act
        final result = TaskModel.fromJson(jsonMap);
        // assert
        expect(result.id, taskModel.id);
      },
    );
  });
}
