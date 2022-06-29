import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nuli/pages/EditProfile.dart';
import 'package:nuli/pages/ProjectDetail.dart';
import 'package:nuli/pages/SplashScreen.dart';
import 'package:nuli/pages/TaskDetail.dart';
import 'package:nuli/pages/WelcomePage2.dart';
import 'package:nuli/pages/SignUpScreen.dart';
import 'package:nuli/pages/WelcomeScreen.dart';
import 'package:nuli/pages/LoginScreen.dart';
import 'package:nuli/pages/add_task.dart';
import 'package:nuli/pages/home.dart';
import 'package:nuli/pages/tabbarview.dart';
import 'package:nuli/pages/profile.dart';
import 'package:nuli/temp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: '/login',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/welcome2': (context) => const WelcomePage2(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const Profile(),
        '/detail_project': (context) => const ProjectDetail(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/temppage': (context) => const TempPage(),
        '/tabbarview': (context) => const TabBarView1(),
        '/add_task': (context) => const AddTaskPage(),
      },
    );
  }
}
