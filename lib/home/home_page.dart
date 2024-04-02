import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/config/app_data.dart' as appData;
import 'package:todo_list/home/components/add_task_dialog.dart';
import '../config/app_colors.dart';
import '../services/utils_services.dart';
import 'components/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To-Do List',
              style: GoogleFonts.leagueSpartan(
                fontSize: 25,
                color: AppColors.details,
              ),
            ),
            Text(
              utilsServices.getFormattedDate(),
              style: GoogleFonts.rokkitt(
                textStyle: TextStyle(
                fontSize: 20,
                color: AppColors.details,
                  fontWeight: FontWeight.w400
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
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                //Complete tasks
                Column(
                  children: [

                    //Title
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Tarefas Concluídas',
                          style: GoogleFonts.yanoneKaffeesatz(
                              textStyle: TextStyle(
                                  fontSize: 23,
                                  color: AppColors.details,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                        ),
                      ),
                    ),

                    //Divider
                    SizedBox(
                      width: 360,
                      child: Divider(
                        color: Colors.grey.withAlpha(90),
                        thickness: 2,
                      ),
                    ),

                    //ListView
                    SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: appData.items.length,
                        itemBuilder: (_, index) {
                          return TaskTile(
                            task: appData.items[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),

                //Pending tasks
                Column(
                  children: [

                    //Title
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          'Tarefas Pendentes',
                          style: GoogleFonts.yanoneKaffeesatz(
                              textStyle: TextStyle(
                                  fontSize: 23,
                                  color: AppColors.details,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                        ),
                      ),
                    ),

                    //Divider
                    SizedBox(
                      width: 360,
                      child: Divider(
                        color: Colors.grey.withAlpha(90),
                        thickness: 2,
                      ),
                    ),

                    //ListView
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),


      // Add task button
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddTaskDialog(),
            );
          },
          shape: const CircleBorder(),
          backgroundColor: AppColors.primary,
          child: Icon(Icons.add, color: AppColors.details, size: 45),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
