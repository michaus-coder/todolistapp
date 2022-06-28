import 'package:flutter/material.dart';

class AddEditTask extends StatefulWidget {
  const AddEditTask({Key? key}) : super(key: key);

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NULI - Productive App",
      home: Scaffold(
          backgroundColor: const Color(0xFF1C549D),
          appBar: AppBar(
            title: const Text('NULI - Productive App'),
          ),
          body: Container(
            child: Column(
              children: [
                Text(
                  'Create New Task',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    );
  }
}
