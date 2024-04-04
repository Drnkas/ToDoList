import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../../../models/task_model.dart';
import '../../controller/home_controller.dart';

class ConfirmTaskDialog extends StatelessWidget {
  final TaskModel tasks;
  ConfirmTaskDialog({super.key, required this.tasks});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Deseja concluir a tarefa?'),
      actions: [
        //Cancel button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            'Cancelar',
            style: GoogleFonts.yanoneKaffeesatz(
              textStyle: TextStyle(
                  fontSize: 23,
                  color: AppColors.details,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),

        //Complete task button
        TextButton(
          onPressed: () {
            final task = TaskModel(
                id: tasks.id,
                description: tasks.description,
                status: tasks.status,
                createAt: tasks.createAt
            );

            homeController.completeTask(task).then((_) {
              Get.snackbar(
                  'Sucesso',
                  'Ufa, uma tarefa a menos!',
                  backgroundColor: AppColors.success,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 3)
              );
              Navigator.of(context).pop();
            }).catchError((error) {
              Get.snackbar(
                'Erro',
                'Houve um erro ao completarr a tarefa',
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.BOTTOM,
              );
            });
            },
          child: Text(
            'Concluir Tarefa',
            style: GoogleFonts.yanoneKaffeesatz(
              textStyle: TextStyle(
                  fontSize: 23,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
      ],
    );
  }
}