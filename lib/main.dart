import 'package:flutter/material.dart';
import 'package:nuli/pages/SignUpScreen.dart';
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
      initialRoute: '/login',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
      home: new WelcomeScreen(),
    );
  }
}
