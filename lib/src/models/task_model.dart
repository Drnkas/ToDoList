import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  int? id;
  @JsonKey(name: 'task')
  String? description;
  String? status;
  @JsonKey(name: 'criado_em')
  String? createAt;
  bool isDone;

  TaskModel({
     this.id,
     this.description,
     this.status,
     this.createAt,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

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

  @override
  String toString(){
    return 'id: $id, description: $description, status: $status, createAt: $createAt';
  }
}
