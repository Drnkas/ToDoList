import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/src/home/controller/home_controller.dart';

import '../../../config/app_colors.dart';
import '../../../models/task_model.dart';
import '../dialogs/add_task_dialog.dart';
import '../task_tile.dart';

class PendingTasksListView extends StatefulWidget {
  const PendingTasksListView({super.key});

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
        if (controller.pendingTasks.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Image
                  Image.asset(
                    'assets/task_image.png',
                    width: 280,
                    height: 280,
                  ),
              
                  //Title
                  Text(
                    'Nenhuma tarefa por aqui!',
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20,
                    color: AppColors.details,
                  )),
                  const SizedBox(height: 20),
              
                  //Add task button
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddTaskDialog(task: TaskModel()),
                      );
                    },
                    icon: Icon(
                      Icons.playlist_add,
                      color: AppColors.primary,
                    ),
                    label: const Text('Nova Tarefa'),
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: AppColors.background,
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.pendingTasks.length,
            itemBuilder: (context, index) {
              final task = controller.pendingTasks[index];
              return TaskTile(
                task: task,
              );
            },
          );
        }
      }
    });
  }
}
