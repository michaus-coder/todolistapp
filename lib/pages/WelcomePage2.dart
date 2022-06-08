import 'package:flutter/material.dart';

class WelcomePage2 extends StatefulWidget {
  const WelcomePage2({Key? key}) : super(key: key);

  @override
  State<WelcomePage2> createState() => _WelcomePage2State();
}

class _WelcomePage2State extends State<WelcomePage2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NULI - Productive App",
      home: Scaffold(
          backgroundColor: Color(0xFFF6FAFD),
          appBar: AppBar(
            title: const Text('NULI - Productive App'),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset("assets/nuli/images/welcome2-image.png"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "NULI help you to organize your projects and to do list. Let’s build something amazing with NULI !",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF1C549D),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Builder(builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C549D),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  );
                })
              ],
            ),
          )),
    );
  }
}
