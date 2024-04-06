import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../models/task_model.dart';
import '../../services/utils_services.dart';
import 'dialogs/add_task_dialog.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(160);

  @override
  Widget build(BuildContext context) {
    final utilsServices = UtilsServices();
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          Text(
            'To-Do List',
            style: GoogleFonts.leagueSpartan(
              fontSize: 35,
              color: AppColors.details,
            ),
          ),
          //Date
          Text(
            utilsServices.getFormattedDate(),
            style: GoogleFonts.rokkitt(
              textStyle: TextStyle(
                fontSize: 20,
                color: AppColors.details,
              ),
            ),
          ),
        ],
      ),
      toolbarHeight: 160,
      backgroundColor: AppColors.background,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe86e1c), Color(0xFFf1f0ef)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      actions: [
        //Add task
        IconButton(
          padding: const EdgeInsets.only(right: 30, bottom: 25),
          icon: Icon(
            Icons.add_rounded,
            size: 39,
            color: AppColors.details,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddTaskDialog(task: TaskModel()),
            );
          },
        ),
      ],
    );
  }
}
