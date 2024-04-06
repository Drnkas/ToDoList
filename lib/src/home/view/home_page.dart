import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/src/home/components/listviews/all_tasks_listview.dart';
import 'package:todo_list/src/home/components/listviews/complete_tasks_listview.dart';
import '../../config/app_colors.dart';
import '../components/custom_app_bar.dart';
import '../components/listviews/pending_tasks_listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [

              //TabBar
              TabBar(
                splashBorderRadius: BorderRadius.circular(35),
                tabAlignment: TabAlignment.center,
                labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                dividerColor: AppColors.background,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide.none,
                ),
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.details
                ),
                unselectedLabelStyle: TextStyle(color: Colors.grey[600]),
                tabs: [
                  //All Tasks tab
                  Tab(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Todas',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Pending tab
                  Tab(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Pendentes',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 17,
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
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //TabView
              const Expanded(
                child: TabBarView(
                  children: [
                    AllTaskListView(),
                    PendingTasksListView(),
                    CompleteTasksListView()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
