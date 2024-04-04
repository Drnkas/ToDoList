import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/src/home/controller/home_controller.dart';

import '../../../config/app_colors.dart';
import '../task_tile.dart';

class PendingTasksListView extends StatefulWidget {
  const PendingTasksListView({Key? key});

  @override
  State<PendingTasksListView> createState() => _PendingTasksListViewState();
}

class _PendingTasksListViewState extends State<PendingTasksListView> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<HomeController>();
      if (controller.isTaskLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.details,
          ),
        );
      } else {
        return ListView.builder(
          itemCount: controller.pendingTasks.length,
          itemBuilder: (context, index) {
            final task = controller.pendingTasks[index];
            return TaskTile(
              onDelete: controller.deleteTask,
              task: task,
            );
          },
        );
      }
    });
  }
}
