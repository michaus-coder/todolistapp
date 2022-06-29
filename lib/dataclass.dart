import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String fullname;
  final String uid;

  User({
    required this.email,
    required this.fullname,
    required this.uid,
  });

  String get firstName => fullname.split(' ')[0];
  String get lastName => fullname.substring(fullname.indexOf(' ') + 1);

  Map<String, dynamic> toJson() => {
        'email': email,
        'fullname': fullname,
        'uid': uid,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        fullname: json['fullname'],
        uid: json['uid'],
      );
}

class Task {
  String title;
  DateTime date_time;
  String reminder;
  String desc;
  bool isdone;

  Task(
      {
      required this.title,
      required this.date_time,
      required this.reminder,
      required this.desc,
      required this.isdone});

  Map<String, dynamic> toJson() => {
        'title': title,
        'date_time': Timestamp.fromMillisecondsSinceEpoch(
            date_time.millisecondsSinceEpoch),
        'reminder': reminder,
        'desc': desc,
        'isdone': isdone
      };

  // factory Task.fromJson1(Map<String, dynamic> json) => Task(
  //     title: json['title'],
  //     date_time: json['date_time'],
  //     reminder: json['reminder'],
  //     desc: json['desc'],
  //     isdone: json['isdone']);

  factory Task.fromJson(Map<String, dynamic> json) {
    // Timestamp timestamp = json['date_time'];
    // DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(timestamp);

    return Task(
        title: json['title'],
        date_time:json['date_time'],
        reminder: json['reminder'],
        desc: json['desc'],
        isdone: json['isdone']);
  }
}

class Project {
  String projectid;
  String title;
  String deadline;
  String desc;
  bool isdone;
  String reminder;

  Project(
      {required this.projectid,
      required this.title,
      required this.deadline,
      required this.desc,
      required this.isdone,
      required this.reminder});

  Map<String, dynamic> toJson() => {
        'taskid': '',
        'title': title,
        'deadline': deadline,
        'reminder': reminder,
        'desc': desc,
        'isdone': isdone
      };

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        projectid: '',
        title: json['title'],
        deadline: json['deadline'],
        reminder: json['reminder'],
        desc: json['desc'],
        isdone: json['isdone']);
  }
}
