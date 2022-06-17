import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
      body: const Center(
        child: Text('Edit Profile'),
      ),
    );
  }
}
