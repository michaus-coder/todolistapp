import 'package:flutter/material.dart';
import 'package:nuli/CustomWidget.dart';
import 'package:nuli/dataclass.dart' as dataclass;
import 'package:nuli/dbservices.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late dataclass.User? _user;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() async {
    super.initState();
    _user = await UserService.getUserFromFirestore();
    _firstNameController.text = _user!.firstName;
    _lastNameController.text = _user!.lastName;
    _emailController.text = _user!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: const [
                Icon(Icons.arrow_back_ios, color: Colors.grey),
                Text("Back", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const Text("Edit Profile", style: TextStyle(color: Colors.black)),
            const SizedBox(),
            const SizedBox()
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage(""),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -10,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.edit),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff1C549D)), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color(0xffF27470);
                              } // <-- Splash color
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomTF.textField("Email address",
                  inputColor: Colors.red, textController: _emailController),
              const SizedBox(height: 10),
              CustomTF.fullNameTextField("Full name",
                  inputColor: Colors.yellow,
                  textController: _firstNameController,
                  textController2: _lastNameController),
              const SizedBox(height: 10),
              CustomTF.textField("Password",
                  inputColor: Colors.yellow,
                  isPassword: true,
                  textController: _passwordController),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff1C549D), Color(0xff3392DC)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 100,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () async {
                    await UserService.updateUserToFirestore(
                      user: dataclass.User(
                        email: _emailController.text,
                        fullname:
                            "${_firstNameController.text} ${_lastNameController.text}",
                        uid: _user!.uid,
                      ),
                    )
                        .whenComplete(() =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("User profile updated successfully"),
                              ),
                            ))
                        .catchError(
                          (e) => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Error occured while updating profile"),
                            ),
                          ),
                        );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
