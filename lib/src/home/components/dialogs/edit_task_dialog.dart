import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals_flutter.dart';
import 'package:todo_list/src/home/controller/home_controller.dart';
import '../../../config/app_colors.dart';
import '../../../models/task_model.dart';

class EditTaskDialog extends StatefulWidget {
  final TaskModel task;

  const EditTaskDialog({super.key, required this.task});

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  final homeController = Get.find<HomeController>();
  late final TextEditingController _textEditingController;
  final desc = signal('');
  final descError = signal<String?>(null);

  late final isValid = computed(() => desc().isEmpty);

  bool validateDesc() {
    bool isValid = true;
    final newDescription = desc();

    if (desc().isEmpty) {
      descError.value = 'Digite uma tarefa';
      isValid = false;
    } else if (newDescription == widget.task.description) {
      descError.value = 'Ei, você precisa fazer uma alteração';
      isValid = false;
    } else {
      descError.value = null;
    }
    return isValid;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.task.description);
    desc.set(widget.task.description!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Text(
            'Editar Tarefa',
          style: GoogleFonts.leagueSpartan(
            textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
      content: TextField(
        maxLines: null,
        cursorColor: AppColors.primary,
        controller: _textEditingController,
        onChanged: desc.set,
        decoration: InputDecoration(
          hintText: 'Digite a descrição da tarefa...',
          hintStyle: TextStyle(color: AppColors.text),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          errorText: descError.value,
          errorStyle: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        style: GoogleFonts.yanoneKaffeesatz(
          textStyle: TextStyle(
            fontSize: 23,
            color: AppColors.details,
            fontWeight: FontWeight.w500,
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
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        //Edit task button
        TextButton(
          onPressed: () {
            isValid.watch(context) ? validateDesc : null;
            if (validateDesc()) {
              final task = TaskModel(
                id: widget.task.id,
                description: desc(),
              );

              homeController.updateTask(task)
                  .then((_) {
                Get.snackbar(
                    'Sucesso',
                    'Tarefa atualizada com sucesso!',
                    backgroundColor: AppColors.success,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 3)
                );
                Navigator.of(context).pop();
              }).catchError((error) {
                Get.snackbar(
                  'Erro',
                  'Houve um erro ao atualizar a tarefa',
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM,
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
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}