import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:task_trekker/features/kanban_board/data/models/comment_model.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateMocks([CommentModel])
void main() {
  final taskModel = CommentModel(
    id: '1',
    taskId: 'taskId',
    content: 'content',
    postedAt: DateTime.now(),
  );

  group('fromJson', () {
    test(
      'should return a valid comment model',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('comment.json'));
        // act
        final result = CommentModel.fromJson(jsonMap);
        // assert
        expect(result.id, taskModel.id);
      },
    );
  });
}
