import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';

class ConfirmTaskDialog extends StatelessWidget {
  const ConfirmTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Deseja concluir a tarefa?'),
      actions: [
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
        TextButton(
          onPressed: () {
            //Todo chamar api
            Navigator.of(context).pop(false);
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