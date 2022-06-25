class User {
  final String email;
  final String fullname;
  final String uid;

  User({
    required this.email,
    required this.fullname,
    required this.uid,
  });

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
  String taskid;
  String title;
  String date_time;
  String reminder;
  String desc;
  bool isdone;

  Task(
      {required this.taskid,
      required this.title,
      required this.date_time,
      required this.reminder,
      required this.desc,
      required this.isdone});

  Map<String, dynamic> toJson() => {
        'taskid': '',
        'title': title,
        'date_time': date_time,
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
    return Task(
        taskid: '',
        title: json['title'],
        date_time: json['date_time'],
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
