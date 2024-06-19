part of 'task_entity.dart';

class TaskDuration extends Equatable {
  final int amount;
  final String unit;

  const TaskDuration({
    required this.amount,
    required this.unit,
  });

  @override
  List<Object?> get props => [
        amount,
        unit,
      ];
}
