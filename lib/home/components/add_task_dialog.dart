import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Tarefa'),
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
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            //Todo chamar api
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
