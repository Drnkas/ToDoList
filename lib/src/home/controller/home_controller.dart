import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/src/home/repository/home_repository.dart';

import '../../models/task_model.dart';

class HomeController extends GetxController{

  HomeController() {
    listPendingTasks();
    listCompleteTasks();
    listAllTasks();
  }

  final homeRepository = HomeRepository();

  RxBool isTaskLoading = false.obs;
  RxList<TaskModel> pendingTasks = <TaskModel>[].obs;
  RxList<TaskModel> completeTasks = <TaskModel>[].obs;
  RxList<TaskModel> allTasks = <TaskModel>[].obs;
  TaskModel taskModel = TaskModel();

  void setLoading(bool value) {
    isTaskLoading.value = value;
  }

  Future<void> listAllTasks() async {
    try {
      setLoading(true);

      final pendingResult = await homeRepository.listPendingTask();
      final completeResult = await homeRepository.listCompleteTask();

      if (pendingResult != null && completeResult != null) {
        allTasks.assignAll([...pendingResult, ...completeResult]);
        allTasks.sort((a, b) => b.createAt!.compareTo(a.createAt!));
      } else if (pendingResult != null) {
        allTasks.assignAll(pendingResult);
        allTasks.sort((a, b) => b.createAt!.compareTo(a.createAt!));
      } else if (completeResult != null) {
        allTasks.assignAll(completeResult);
        allTasks.sort((a, b) => b.createAt!.compareTo(a.createAt!));
      } else {
        allTasks.clear();
      }

      update();
      setLoading(false);
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Houve um erro ao buscar lista de tarefas',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  Future<void> listPendingTasks() async {
    try {
      setLoading(true);
      final result = await homeRepository.listPendingTask();
      if(result != null) {
        pendingTasks.assignAll(result.reversed);
      }
      update();
      setLoading(false);
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Houve um erro  ao buscar lista de tarefas',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  Future<void> listCompleteTasks() async {
    try {
      setLoading(true);
      final result = await homeRepository.listCompleteTask();
      if(result != null) {
        completeTasks.assignAll(result.reversed);
      }
      setLoading(false);
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Houve um erro ao buscar lista de tarefas',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  Future createTask(TaskModel task) async {
    try{
      setLoading(true);
      final result = await homeRepository.createTask(task: task);
      pendingTasks.insert(0, result);
      allTasks.insert(0, result);

      setLoading(false);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try{
      setLoading(true);
      final result = await homeRepository.updateTask(task: task);
      taskModel = result;

      final index = pendingTasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        pendingTasks[index] = result;
      }

      final allIndex = allTasks.indexWhere((t) => t.id == task.id);
      if (allIndex != -1) {
        allTasks[allIndex] = result;
      }

      setLoading(false);
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> completeTask(TaskModel task) async {
    try{
      setLoading(true);
      final result = await homeRepository.completeTask(task: task);
      taskModel = result;

      final index = completeTasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        completeTasks[index] = result;
      } else {
        completeTasks.add(result);
        allTasks.add(result);
      }

      pendingTasks.removeWhere((t) => t.id == task.id);

      await listPendingTasks();
      await listAllTasks();
      await listCompleteTasks();
      setLoading(false);
    } catch (e) {
      rethrow;
    }
  }

  void deleteTask(TaskModel task) async {
    try {
      setLoading(true);
      await homeRepository.deleteTask(task: task);

      pendingTasks.removeWhere((t) => t.id == task.id);
      completeTasks.removeWhere((t) => t.id == task.id);
      allTasks.removeWhere((t) => t.id == task.id);

      setLoading(false);
      update();
    } catch (e) {
      print('Erro ao excluir a tarefa: $e');
    }
  }

}