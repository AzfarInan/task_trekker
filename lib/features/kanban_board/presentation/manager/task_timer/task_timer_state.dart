part of 'task_timer_cubit.dart';

class GetTaskSuccessState<T> extends BaseState {
  const GetTaskSuccessState({this.data});

  final T? data;

  @override
  List<Object?> get props => [data];
}

class SaveTaskSuccessState<T> extends BaseState {
  const SaveTaskSuccessState({this.data});

  final T? data;

  @override
  List<Object?> get props => [data];
}

class RemoveTaskSuccessState<T> extends BaseState {
  const RemoveTaskSuccessState({this.data});

  final T? data;

  @override
  List<Object?> get props => [data];
}
