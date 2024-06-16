import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();
}

class InitialState extends BaseState {
  @override
  List<Object?> get props => [];
}

class LoadingState<T> extends BaseState {
  const LoadingState({this.data});

  final T? data;

  @override
  List<Object?> get props => [];
}

class LoadingAgainState<T> extends BaseState {
  const LoadingAgainState({this.data});

  final T? data;

  @override
  List<Object?> get props => [];
}

class SuccessState<T> extends BaseState {
  const SuccessState({this.data});

  final T? data;

  @override
  List<Object?> get props => [];
}

class ErrorState<T> extends BaseState {
  const ErrorState({this.data});

  final T? data;

  @override
  List<Object?> get props => [data];
}