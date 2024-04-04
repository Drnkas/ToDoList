import 'package:get/get.dart';
import 'package:todo_list/src/home/repository/home_repository.dart';

import '../../models/task_model.dart';

class HomeController extends GetxController{

  HomeController(){
    listPendingTasks();
    listCompleteTasks();
  }

  final homeRepository = HomeRepository();

  RxBool isTaskLoading = false.obs;
  RxList<TaskModel> pendingTasks = <TaskModel>[].obs;
  RxList<TaskModel> completeTasks = <TaskModel>[].obs;
  TaskModel taskModel = TaskModel();

  void setLoading(bool value) {
    isTaskLoading.value = value;
  }

  Future<void> listPendingTasks() async {
    setLoading(true);
    try {
      final result = await homeRepository.listPendingTask();
      if(result != null) {
        pendingTasks.assignAll(result.reversed);
      }
    } catch (e) {
      rethrow;
    }

    setLoading(false);
  }

  Future<void> listCompleteTasks() async {
    setLoading(true);
    try {
      final result = await homeRepository.listCompleteTask();
      if(result != null) {
        completeTasks.assignAll(result.reversed);
      }
    } catch (e) {
      rethrow;
    }

    setLoading(false);
  }

  Future createTask(TaskModel task) async {
    setLoading(true);
    try{
      final result = await homeRepository.createTask(task: task);
      pendingTasks.add(result);
    } catch (e) {
      rethrow;
    }

    setLoading(false);
  }

  Future<void> updateTask(TaskModel task) async {
    setLoading(true);
    try{
      final result = await homeRepository.updateTask(task: task);
      taskModel = result;

      final index = pendingTasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        pendingTasks[index] = result;
      }
    } catch (e) {
      rethrow;
    }
    setLoading(false);
  }

  Future<void> completeTask(TaskModel task) async {
    setLoading(true);
    try{
      final result = await homeRepository.completeTask(task: task);
      taskModel = result;

      final index = completeTasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        completeTasks[index] = result;
      }
    } catch (e) {
      rethrow;
    }
    setLoading(false);
  }

  void deleteTask(TaskModel task) {
    completeTasks.remove(task);
    pendingTasks.remove(task);
    update();
  }

}