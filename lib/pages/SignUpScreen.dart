import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  late bool _passwordVisible1;
  late bool _passwordVisible2;

  @override
  void initState() {
    super.initState();
    _passwordVisible1 = false;
    _passwordVisible2 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          const FittedBox(
            child: Image(
              image: AssetImage("assets/nuli/images/signup-image.png"),
              height: 200,
            ),
            fit: BoxFit.fill,
          ),
          Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Hello! Sign up to get started",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Image.asset(
                      "assets/nuli/images/ic_sharp-alternate-email.png",
                      width: 30,
                    ),
                    labelText: "E-mail",
                  ),
                ),
                TextField(
                  controller: _fullnameController,
                  decoration: InputDecoration(
                    icon: Image.asset(
                      "assets/nuli/images/la_user.png",
                      width: 30,
                    ),
                    labelText: "Full Name",
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Image.asset(
                      "assets/nuli/images/fluent_lock-closed-16-regular.png",
                      width: 30,
                    ),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible1
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible1 = !_passwordVisible1;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible1,
                ),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    icon: Image.asset(
                      "assets/nuli/images/fluent_lock-closed-16-regular.png",
                      width: 30,
                    ),
                    labelText: "Confirm Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible2
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible2 = !_passwordVisible2;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible2,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                      shadowColor: Colors.black,
                      elevation: 5),
                  onPressed: () {},
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 13, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        child: const Text(
                          'Log in',
                          style: TextStyle(fontSize: 13, color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
