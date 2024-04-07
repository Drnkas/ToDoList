import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../models/task_model.dart';
import '../../services/utils_services.dart';
import '../controller/home_controller.dart';
import 'dialogs/confirm_task_dialog.dart';
import 'dialogs/edit_task_dialog.dart';

class TaskTile extends StatefulWidget {
  final TaskModel task;
  const TaskTile({super.key, required this.task});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final UtilsServices utilsServices = UtilsServices();
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        surfaceTintColor: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
                child: Checkbox(
                  activeColor: AppColors.success,
                  fillColor: widget.task.status == 'complete'
                      ? MaterialStateColor.resolveWith((states) => AppColors.success)
                      : MaterialStateColor.resolveWith((states) => Colors.grey.withAlpha(55)),
                  value: widget.task.status == 'complete' ? true : widget.task.isDone,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  side: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onChanged: (isChecked) {
                    setState(() {
                      if (widget.task.status != 'complete') {
                        bool previousValue = widget.task.isDone;
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmTaskDialog(tasks: widget.task),
                        ).then((confirmed) {
                          if (confirmed != null && confirmed) {
                            widget.task.isDone = isChecked!;
                          } else {
                            widget.task.isDone = previousValue;
                          }
                        });
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Title
                    Text(
                      widget.task.description!,
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: widget.task.status == 'complete'
                              ? Colors.grey
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        //Status
                        Icon(
                          Icons.lightbulb_circle_outlined,
                          size: 17,
                          color: AppColors.buttons,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Status: ${widget.task.translatedStatus}',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.leagueSpartan(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color:  widget.task.status == 'complete'
                                    ? Colors.grey
                                    : AppColors.details,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        //CreatedAt
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            size: 17,
                            color: AppColors.buttons,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Criado em: ${utilsServices.formatDateAndHour(widget.task.createAt!)}',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.leagueSpartan(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: widget.task.status == 'complete'
                                    ? Colors.grey
                                    : AppColors.text,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  if (widget.task.status != 'complete')
                  //Edit Button
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditTaskDialog(task: widget.task),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  //Delete button
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: IconButton(
                      onPressed: () {
                        homeController.deleteTask(widget.task);
                      },
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



