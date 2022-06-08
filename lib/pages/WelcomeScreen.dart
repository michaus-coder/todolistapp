import 'package:flutter/material.dart';
import 'package:nuli/pages/tabbarview.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NULI - Productive App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Welcome to NULI - Productive App")),
          ElevatedButton(
            child: const Text("Start"),
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
          ),
          ElevatedButton(
            child: const Text("Home"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => TabBarView1())));
            },
          ),
        ],
      ),
    );
  }
}
