import 'package:todo_list/src/constants/endpoints.dart';
import 'package:todo_list/src/models/task_model.dart';
import 'package:todo_list/src/services/http_manager.dart';

class HomeRepository {

  final HttpManager _httpManager = HttpManager();

  Future listPendingTask() async {
    try {
      final response = await _httpManager.restRequest(
          url: Endpoints.listPendingTask,
          method: HttpMethods.get
      );

      if (response.isNotEmpty) {
        final tasks = <TaskModel>[];

        for (final item in response) {
          final task = TaskModel.fromJson(item);
          tasks.add(task);
        }
        return tasks;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future listCompleteTask() async {
    try {
      final response = await _httpManager.restRequest(
          url: Endpoints.listCompleteTask,
          method: HttpMethods.get
      );

      if (response.isNotEmpty) {
        final tasks = <TaskModel>[];

        for (final item in response) {
          final task = TaskModel.fromJson(item);
          tasks.add(task);
        }
        return tasks;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskModel> createTask({required TaskModel task}) async {
    try {
      final Map<String, dynamic> taskJson = task.toJson();
      final Map<String, dynamic> response = await _httpManager.restRequest(
        url: Endpoints.createTask,
        method: HttpMethods.post,
        body: taskJson,
      );

      if (response.isNotEmpty) {
        final createdTask = TaskModel.fromJson(response);
        return createdTask;
      } else {
        throw Exception("Resposta inválida do servidor");
      }

    } catch (e) {
      rethrow;
    }
  }

  Future<TaskModel> updateTask({required TaskModel task}) async {
    try {
      final Map<String, dynamic> taskJson = task.toJson();
      final response = await _httpManager.restRequest(
        url: Endpoints.updateTask(task.id!),
        method: HttpMethods.put,
        body: taskJson,
      );

      if (response.isNotEmpty) {
        final updateTask = TaskModel.fromJson(response);
        return updateTask;
      } else {
        throw Exception("Resposta inválida do servidor");
      }

    } catch (e) {
      rethrow;
    }
  }

  Future<TaskModel> completeTask({required TaskModel task}) async {
    try{
      final Map<String, dynamic> taskJson = task.toJson();
      final response = await _httpManager.restRequest(
        url: Endpoints.completeTask(task.id!),
        method: HttpMethods.post,
        body: taskJson,
      );

      if (response.isNotEmpty) {
        final completeTask = TaskModel.fromJson(response);
        return completeTask;
      } else {
        throw Exception("Resposta inválida do servidor");
      }

    }catch (e){
      rethrow;
    }
  }

}