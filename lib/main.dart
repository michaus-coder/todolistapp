import 'package:flutter/material.dart';
import 'package:nuli/pages/WelcomePage2.dart';

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
      home: Scaffold(
          appBar: AppBar(
            title: const Text('NULI - Productive App'),
          ),
          body: Container(
            child: Column(
              children: [
                Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WelcomePage2();
                        }));
                      },
                      child: const Text("go to wellcomepage 2"));
                })
              ],
            ),
          )),
    );
  }
}
