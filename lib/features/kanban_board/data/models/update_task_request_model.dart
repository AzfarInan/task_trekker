class UpdateTaskRequestModel {
  final String id;
  final List<String>? labels;
  final String? due_date;
  final int? duration;
  final String? duration_unit;

  UpdateTaskRequestModel({
    required this.id,
    this.labels,
    this.due_date,
    this.duration,
    this.duration_unit,
  });
}
