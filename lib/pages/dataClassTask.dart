class itemTask {
  final String task_name;
  String status;

  itemTask({required this.task_name, required this.status});

  Map<String, dynamic> toJson() {
    return {
      'task_name': task_name,
      'status': status,
    };
  }

  factory itemTask.fromJson(Map<String, dynamic> json) {
    return itemTask(
      task_name: json['task_name'],
      status: json['status'],
    );
  }
}
