import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_comment_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/add_comment.dart';

@injectable
class AddCommentCubit extends Cubit<BaseState> {
  AddCommentCubit({required this.usecase}) : super(InitialState());

  final AddComment usecase;

  final TextEditingController contentController = TextEditingController();

  Future<void> addComment({required String taskId}) async {
    emit(const LoadingState());
    try {
      final result = await usecase(
        AddCommentRequestModel(
          content: contentController.text,
          taskId: taskId,
        ),
      );
      result.fold(
        (l) => emit(ErrorState(data: l.error!.message!)),
        (r) {
          clearText();
          emit(const SuccessState());
        },
      );
    } catch (e) {
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }

  void clearText() {
    contentController.clear();
  }
}
