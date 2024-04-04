import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../controller/home_controller.dart';
import '../task_tile.dart';

class CompleteTasksListView extends StatefulWidget {
  const CompleteTasksListView({Key? key});

  @override
  State<CompleteTasksListView> createState() => _CompleteTasksListViewState();
}

class _CompleteTasksListViewState extends State<CompleteTasksListView> {
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
         // controller: _scrollController,
          itemCount: controller.completeTasks.length,
          itemBuilder: (context, index) {
            final task = controller.completeTasks[index];
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


