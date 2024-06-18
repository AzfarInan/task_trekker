import 'package:injectable/injectable.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/features/kanban_board/domain/use_cases/get_comments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class GetCommentsCubit extends Cubit<BaseState> {
  GetCommentsCubit({
    required this.useCase,
  }) : super(InitialState());

  final GetComments useCase;

  Future<void> getComments({required String taskId}) async {
    emit(const LoadingState());
    try {
      final result = await useCase(taskId);
      result.fold(
        (l) => emit(ErrorState(data: l.error!.message!)),
        (r) => emit(SuccessState(data: r)),
      );
    } catch (e) {
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }
}
