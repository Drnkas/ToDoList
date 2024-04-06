import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/src/home/controller/home_controller.dart';
import 'package:todo_list/src/home/view/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

