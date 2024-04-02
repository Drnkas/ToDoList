class TaskModel {
  int? id;
  String? description; //task
  String? status;
  String? createAt;
  bool isDone;

  TaskModel({
    required this.id,
    required this.description,
    required this.status,
    required this.createAt,
    this.isDone = false,
  });

  String get translatedStatus {
    switch (status) {
      case 'complete':
        return 'Concluído';
      case 'pending':
        return 'Pendente';
      default:
        return status ?? '';
    }
  }
}
