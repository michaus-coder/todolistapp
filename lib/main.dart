import 'package:flutter/material.dart';
import 'package:nuli/pages/AddEditTask.dart';
import 'package:nuli/pages/ProjectDetail.dart';
import 'package:nuli/pages/TaskDetail.dart';
import 'package:nuli/pages/WelcomePage2.dart';
import 'package:nuli/pages/WelcomeScreen.dart';
import 'package:nuli/pages/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NULI - Productive App",
      debugShowCheckedModeBanner: false,
      initialRoute: '/detail_project',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/welcome2': (context) => const WelcomePage2(),
        '/detail_task': (context) => const TaskDetail(),
        '/detail_project': (context) => const ProjectDetail(),
        '/add_edit_task': (context) => const AddEditTask(),
        '/login': (context) => const LoginScreen(),
      },
      home: new TaskDetail(),
    );
  }
}
