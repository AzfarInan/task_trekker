import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/features/kanban_board/data/models/add_task_request_model.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/add_task.dart';

@injectable
class AddTaskCubit extends Cubit<BaseState> {
  AddTaskCubit({required this.usecase}) : super(InitialState());

  final AddTask usecase;

  final TextEditingController contentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> addTask({required int priority}) async {
    emit(const LoadingState());
    try {
      final result = await usecase(
        AddTaskRequestModel(
          content: contentController.text,
          description: descriptionController.text,
          priority: priority,
          labels: ["TODO"],
        ),
      );
      result.fold((l) => emit(ErrorState(data: l.error!.message!)), (r) {
        clearText();
        emit(SuccessState(data: r));
      });
    } catch (e) {
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }

  void clearText() {
    contentController.clear();
    descriptionController.clear();
  }
}
