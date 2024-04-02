import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/home/components/edit_task_dialog.dart';
import 'package:todo_list/services/utils_services.dart';

import '../../config/app_colors.dart';
import '../../models/task_model.dart';
import 'confirm_task_dialog.dart';

class TaskTile extends StatefulWidget {
  final TaskModel task;
  TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Card(
        surfaceTintColor: Colors.white,
        color: widget.task.status == 'complete' ? Colors.lightGreen[100] : null,
        elevation: 5,
        child: ListTile(
          leading: Checkbox(
            activeColor: AppColors.success,
            value: widget.task.status == 'complete' ? true : widget.task.isDone,
            visualDensity: const VisualDensity(
              horizontal: -4,
              vertical: -4,
            ),
            onChanged: (isChecked) {
              setState(() {
                bool previousValue = widget.task.isDone;
                showDialog(
                  context: context,
                  builder: (context) => ConfirmTaskDialog(),
                ).then((confirmed) {
                  if (confirmed != null && confirmed) {
                    widget.task.isDone = isChecked!;
                  } else {
                    widget.task.isDone = previousValue;
                  }
                });
              });
            },
          ),

          //Description
          title: Text(
            widget.task.description!,
            style: GoogleFonts.leagueSpartan(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: AppColors.details,
                )
            ),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Status
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_circle_outlined,
                    size: 17,
                    color: AppColors.buttons,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Status: ${widget.task.translatedStatus}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.leagueSpartan(
                          textStyle: TextStyle(
                              fontSize: 14,
                              color: AppColors.details,
                              fontWeight: FontWeight.w400
                          )
                      ),
                    ),
                  ),
                ],
              ),

              //CreatedAt
              Row(
                children: [
                  Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.buttons,
                      size: 17
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Criado em: ${utilsServices.formatDateAndHour(widget.task.createAt!)}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.leagueSpartan(
                          textStyle: TextStyle(
                              fontSize: 14,
                              color: AppColors.details,
                              fontWeight: FontWeight.w400
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          //Edit button
          trailing: widget.task.status != 'complete'
              ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditTaskDialog(task: widget.task),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: AppColors.primary,
                ),
              ),
            ],
          )
              : null,
        ),
      ),
    );
  }
}



