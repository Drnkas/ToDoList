import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/src/home/view/home_page.dart';
import '../config/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 4), () {
      Get.off(() => const HomePage());
    });

    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.background,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/task_image.png',
              width: 280,
              height: 280,
            ),
            Text(
                'To-Do List',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 39,
                  color: AppColors.details,
                )),
            Text(
                'Seu Aplicativo de Tarefas',
                style: GoogleFonts.rokkitt(
                  fontSize: 16,
                  color: AppColors.details,
                )
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
