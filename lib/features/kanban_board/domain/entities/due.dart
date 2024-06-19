part of 'task_entity.dart';

class Due extends Equatable {
  final DateTime date;
  final String? timezone;
  final String dateString;
  final String lang;
  final bool isRecurring;
  final DateTime? datetime;

  const Due({
    required this.date,
    this.timezone,
    required this.dateString,
    required this.lang,
    required this.isRecurring,
    this.datetime,
  });

  @override
  List<Object?> get props => [
    date,
    timezone,
    dateString,
    lang,
    isRecurring,
    datetime,
  ];
}
