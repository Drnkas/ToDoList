import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/src/home/components/listviews/complete_tasks_listview.dart';
import 'package:todo_list/src/models/task_model.dart';
import '../../config/app_colors.dart';
import '../../services/utils_services.dart';
import '../components/dialogs/add_task_dialog.dart';
import '../components/listviews/pending_tasks_listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ Color(0xFFe86e1c),Color(0xFFf1f0ef)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          actions: [

            //Add task
            IconButton(
              padding: const EdgeInsets.only(right: 25, bottom: 25),
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
          bottom: TabBar(
            labelPadding: EdgeInsets.zero,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: AppColors.primary),
              insets: const EdgeInsets.only(right: 110),
            ),
            physics: const BouncingScrollPhysics(),
            tabs: [
              //Pending tab
              Tab(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Pendentes',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: AppColors.details,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //Complete tab
              Tab(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Concluídas',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: AppColors.details,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: TabBarView(
            children: [
              PendingTasksListView(),
              CompleteTasksListView()
            ],
          ),
        ),
      ),
    );
  }
}
