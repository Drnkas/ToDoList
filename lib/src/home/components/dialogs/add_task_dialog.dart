import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals_flutter.dart';
import 'package:todo_list/src/home/controller/home_controller.dart';
import 'package:todo_list/src/models/task_model.dart';
import '../../../config/app_colors.dart';

class AddTaskDialog extends StatefulWidget {
  final TaskModel task;
  const AddTaskDialog({super.key, required this.task});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final homeController = Get.find<HomeController>();
  final desc = signal('');
  final descError = signal<String?>(null);

  late final isValid = computed(() => desc().isEmpty);

  bool validateDesc() {

    bool isValid = true;

    if(desc().isEmpty){
      descError.value = 'Digite uma tarefa';
      isValid = false;
    } else {
      descError.value = null;
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Tarefa'),
      content: TextField(
        cursorColor: AppColors.primary,
        onChanged: desc.set,
        decoration: InputDecoration(
            hintText: 'Digite a descrição da tarefa...',
            hintStyle: TextStyle(color: AppColors.details),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorText: descError.value,
            errorStyle: const TextStyle(
                fontWeight: FontWeight.w400
            )
        ),
        style: GoogleFonts.yanoneKaffeesatz(
          textStyle: TextStyle(
              fontSize: 23,
              color: AppColors.details,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
      actions: [
        //Cancel button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
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

        //Add new task button
        TextButton(
          onPressed: () {
            isValid.watch(context) ? validateDesc() : null;
            if(validateDesc()){
              final task = TaskModel(
                description: desc(),
              );
              homeController.createTask(task).then((_) {
                Navigator.of(context).pop();
                Get.snackbar(
                    'Sucesso',
                    'Tarefa criada com sucesso',
                    backgroundColor: AppColors.success,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2)
                );
              }).catchError((error) {
                Get.snackbar(
                  'Erro',
                  'Houve um erro ao criar tarefa',
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.TOP,
                );
              });
            }
          },
          child: Text(
            'Salvar',
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
