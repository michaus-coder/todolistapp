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
          appBar: AppBar(
            title: const Text('NULI - Productive App'),
          ),
          body: Container(
            child: Column(
              children: [],
            ),
          )),
    );
  }
}
