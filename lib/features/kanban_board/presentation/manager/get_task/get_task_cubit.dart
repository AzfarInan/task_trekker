import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/core/base/use_case.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/get_tasks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class GetTaskCubit extends Cubit<BaseState> {
  GetTaskCubit({
    required this.useCase,
  }) : super(InitialState());

  final GetTasks useCase;

  Future<void> getTasks() async {
    emit(const LoadingState());
    try {
      final result = await useCase(NoParams());
      result.fold(
        (l) => emit(ErrorState(data: l.error!.message!)),
        (r) => emit(SuccessState(data: r)),
      );
    } catch (e) {
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }
}
