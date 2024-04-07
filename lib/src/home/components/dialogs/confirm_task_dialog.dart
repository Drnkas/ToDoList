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
      title: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: 'Concluir tarefa\n\n',
                    style: GoogleFonts.leagueSpartan(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                ),
                TextSpan(
                  text: tasks.description!,
                  style: GoogleFonts.leagueSpartan(
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  )
                ),
              ],
            ),
          )
        ],
      ),
      actions: [
        //Cancel button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Cancelar',
            style: GoogleFonts.yanoneKaffeesatz(
              textStyle: TextStyle(
                fontSize: 23,
                color: AppColors.details,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        //Complete task button
        TextButton(
          onPressed: () async {
            if (!homeController.isTaskLoading.value) {
              try {
                await homeController.completeTask(tasks);
                Get.snackbar(
                  'Sucesso',
                  'Ufa, uma tarefa a menos!',
                  backgroundColor: AppColors.success,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 5),
                );

                Navigator.of(context).pop();
              } catch (error) {
                Get.snackbar(
                  'Erro',
                  'Houve um erro ao completar a tarefa',
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 5),
                );
              }
            }
          },
          child: Text(
            'Concluir Tarefa',
            style: GoogleFonts.yanoneKaffeesatz(
              textStyle: TextStyle(
                fontSize: 23,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}