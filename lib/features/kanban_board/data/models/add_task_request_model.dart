class AddTaskRequestModel {
  final String content;
  final String description;
  final int priority;
  final List<String> labels;

  AddTaskRequestModel({
    required this.content,
    required this.description,
    required this.priority,
    required this.labels,
  });
}
