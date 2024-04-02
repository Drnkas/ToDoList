import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../models/task_model.dart';

class EditTaskDialog extends StatelessWidget {
  final TaskModel task;
  final TextEditingController _textEditingController;

  EditTaskDialog({super.key, required this.task})
      : _textEditingController = TextEditingController(text: task.description);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Tarefa'),
      content: TextField(
        cursorColor: AppColors.primary,
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: 'Digite a descrição da tarefa...',
          hintStyle: TextStyle(color: AppColors.details),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
        style: TextStyle(color: AppColors.details),
      ),
      actions: [
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
        TextButton(
          onPressed: () {
            // Todo: chamar api
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
