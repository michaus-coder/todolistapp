import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nuli/dataclass.dart' as dataclass;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;

import 'dataclass.dart';

class UserService {
  static final cloud_firestore.CollectionReference _userCollection =
      cloud_firestore.FirebaseFirestore.instance.collection('tblUser');
  static final firebase_auth.FirebaseAuth _auth =
      firebase_auth.FirebaseAuth.instance;
  static final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: "gs://nuli-todolist.appspot.com");

  static firebase_auth.User? _userFromFirebase(firebase_auth.User? user) {
    if (user == null) {
      return null;
    }
    return user;
  }

  static Future signUp(
      {required String email,
      required String password,
      required String fullname}) async {
    try {
      firebase_auth.UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      firebase_auth.User user = result.user!;
      storeUserToFirestore(
          user: dataclass.User(
        email: user.email!,
        fullname: fullname,
        uid: user.uid,
        photoUrl: "",
      ));
      return _userFromFirebase(user);
    } catch (e) {
      return e.toString();
    }
  }

  static Future signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isLoggedIn() {
    firebase_auth.User? user = _auth.currentUser;
    if (user == null) {
      return false;
    }
    return true;
  }

  static String getCurrentUserID() {
    firebase_auth.User? user = _auth.currentUser;
    if (user == null) {
      return "";
    }
    return user.uid.toString();
  }

  static Future<void> storeUserToFirestore(
      {required dataclass.User user}) async {
    dataclass.User userData = dataclass.User(
      email: user.email,
      fullname: user.fullname,
      uid: user.uid,
      photoUrl: user.photoUrl,
    );
    cloud_firestore.DocumentReference userRef = _userCollection.doc(user.uid);

    await userRef
        .set(userData.toJson())
        .whenComplete(() => print('User saved'))
        .catchError((e) => print(e));
  }

  static Future<String> getDownloadUrl(String uid) async {
    var defaultStorageRef = _storage.ref().child("users/images/default.png");
    String url = await defaultStorageRef.getDownloadURL();
    var storageRef = _storage.ref().child("users/images/$uid.png");
    await storageRef.getDownloadURL().then((value) {
      if (value.isNotEmpty) {
        url = value;
      }
    }).catchError((e) {});
    return url;
  }

  static Future<dynamic> getUserFromFirestore() async {
    await _auth.signInWithEmailAndPassword(
        email: "michaelwong306@gmail.com", password: "thisispassword");
    firebase_auth.User? user = _auth.currentUser;
    cloud_firestore.DocumentReference userRef = _userCollection.doc(user!.uid);
    User userData = await userRef
        .get()
        .then((value) => User.fromJson(value.data() as Map<String, dynamic>));

    String photoUrl = await getDownloadUrl(userData.uid);
    userData.photoUrl = photoUrl;

    // return user;
    return userData;
  }

  static Future<bool> verifyPassword(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> updateUserToFirestore(
      {required dataclass.User user}) async {
    cloud_firestore.DocumentReference userRef = _userCollection.doc(user.uid);
    await userRef
        .update(user.toJson())
        .whenComplete(() => print('User updated'))
        .catchError((e) => print(e));
  }

  static Future<String> uploadImage(String path) async {
    var user = _auth.currentUser;
    var storageRef = _storage.ref().child("users/images/${user!.uid}.png");
    storageRef
        .putFile(File(path))
        .whenComplete(() => storageRef.getDownloadURL());
    return "default.png";
  }

  static Future<bool> updatePassword(String email, String newpassword) async {
    var user = _auth.currentUser;
    bool result = await user!.updatePassword(newpassword).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
    return result;
  }

  static Future<int> getTaskDoneCount() async {
    var firstDayOfWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    var lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
    var user = _auth.currentUser;
    int count = 0;
    // QuerySnapshot tasksDone = await cloud_firestore.FirebaseFirestore.instance
    //     .collection("tblTask")
    //     .doc(user!.uid)
    //     .collection("myTasks")
    //     .where("isdone", isEqualTo: true)
    //     .where("date_time", isGreaterThanOrEqualTo: firstDayOfWeek)
    //     .where("date_time", isLessThanOrEqualTo: lastDayOfWeek)
    //     .get()
    //     .then((value) {
    //   count = value.docs.length;
    //   return value;
    // }).catchError((e) {
    //   count = 0;
    // });
    return count;
  }

  static Future<int> getTaskPendingCount() async {
    var firstDayOfWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    var lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
    var user = _auth.currentUser;
    // QuerySnapshot tasksUndone = await cloud_firestore.FirebaseFirestore.instance
    //     .collection("tblTask")
    //     .doc(user!.uid)
    //     .collection("myTasks")
    //     .where("isdone", isEqualTo: false)
    //     .where("date_time", isGreaterThanOrEqualTo: firstDayOfWeek)
    //     .where("date_time", isLessThanOrEqualTo: lastDayOfWeek)
    //     .get();
    return 0;
  }

  static Future<int> getProjectDoneCount() async {
    var firstDayOfWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    var lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
    var user = _auth.currentUser;
    QuerySnapshot projectsDone = await cloud_firestore
        .FirebaseFirestore.instance
        .collection("tblProject")
        .doc(user!.uid)
        .collection("myProjects")
        .where("isdone", isEqualTo: true)
        .get();
    return projectsDone.docs.length;
  }

  static Future<int> getProjectPendingCount() async {
    var user = _auth.currentUser;
    QuerySnapshot projectsUndone = await cloud_firestore
        .FirebaseFirestore.instance
        .collection("tblProject")
        .doc(user!.uid)
        .collection("myProjects")
        .where("isdone", isEqualTo: false)
        .get();
    return projectsUndone.docs.length;
  }
}

class TaskService {
  Stream<QuerySnapshot> getData(String uid, String judul) {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblTask')
        .doc(uid)
        .collection('myTasks');

    if (judul == "")
      return _taskCollection.snapshots();
    else
      return _taskCollection
          .orderBy("title")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  }

  static Future<void> addData(String uid, dataclass.Task item) async {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblTask')
        .doc(uid)
        .collection('myTasks');

    DocumentReference docRef = _taskCollection.doc(item.taskid);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("Data berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  bool toggleTodoStatus(String uid, dataclass.Task item) {
    item.isdone = !item.isdone;
    TaskService.editData(uid, item);

    return item.isdone;
  }

  static Future<void> editData(String uid, dataclass.Task item) async {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblTask')
        .doc(uid)
        .collection('myTasks');

    DocumentReference docRef = _taskCollection.doc(item.taskid);

    await docRef
        .update(item.toJson())
        .whenComplete(() => print("Data berhasil diubah"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData(String uid, String taskid) async {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblTask')
        .doc(uid)
        .collection('myTasks');

    DocumentReference docRef = _taskCollection.doc(taskid);

    await docRef
        .delete()
        .whenComplete(() => print("Data berhasil dihapus"))
        .catchError((e) => print(e));
  }

  // void countDocuments() async {
  //   QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('product').doc();
  //   List<DocumentSnapshot> _myDocCount = _myDoc.documents;
  //   print(_myDocCount.length);  // Count of Documents in Collection
  // }

  static Future<int> countPendingTask(String uid, String projectid) async {
    final Query<Map<String, dynamic>> undoneTasks = FirebaseFirestore.instance
        .collection('tblTask')
        .doc(uid)
        .collection('myTasks')
        .where('isdone', isEqualTo: false);

    Future<int> undone = undoneTasks.snapshots().length;
    return undone;
  }
}

class ProjectService {
  Stream<QuerySnapshot> getData(String _uid, String judul) {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(_uid)
        .collection('myProjects');

    if (judul == "")
      return _taskCollection.snapshots();
    else
      return _taskCollection
          .orderBy("title")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  }

  Stream<QuerySnapshot> getDataDone(String _uid, String judul) {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(_uid)
        .collection('myProjects');

    if (judul == "")
      return _taskCollection.snapshots();
    else
      return _taskCollection
          .orderBy("title")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
  }

  static Future<void> addData(String uid, Project item) async {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(uid)
        .collection('myProjects');

    DocumentReference docRef = _taskCollection.doc(item.projectid);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("Data berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  static Future<void> editData(String uid, dataclass.Project item) async {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(uid)
        .collection('myProjects');

    DocumentReference docRef = _taskCollection.doc(item.projectid);

    await docRef
        .update(item.toJson())
        .whenComplete(() => print("Data berhasil diubah"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData(String uid, String projectid) async {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(uid)
        .collection('myProjects');

    DocumentReference docRef = _taskCollection.doc(projectid);

    await docRef
        .delete()
        .whenComplete(() => print("Data berhasil dihapus"))
        .catchError((e) => print(e));
  }
}

class TaskforProjectServices {
  Stream<QuerySnapshot> getData(String _uid, String projectid, String judul) {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(_uid)
        .collection('myProjects')
        .doc(projectid)
        .collection('tasks');

    if (judul == "") {
      return _taskCollection.snapshots();
    } else {
      return _taskCollection
          .orderBy("title")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
    }
  }

  Stream<QuerySnapshot> getData2(String _uid, String projectid, String judul) {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(_uid)
        .collection('myProjects')
        .doc(projectid)
        .collection('tasks');

    if (judul == "") {
      return _taskCollection.snapshots();
    } else {
      return _taskCollection
          .orderBy("title")
          .startAt([judul]).endAt([judul + '\uf8ff']).snapshots();
    }
  }

  static Future<void> addData(
      String uid, String projectid, dataclass.TaskforProject item) async {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(uid)
        .collection('myProjects')
        .doc(projectid)
        .collection('tasks');

    DocumentReference docRef = _taskCollection.doc(item.taskid);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("Data berhasil ditambahkan"))
        .catchError((e) => print(e));
  }

  bool toggleTodoStatus(
      String uid, String projectid, dataclass.TaskforProject item) {
    item.isdone = !item.isdone;
    TaskforProjectServices.editData(uid, projectid, item);

    return item.isdone;
  }

  static Future<void> editData(
      String uid, String projectid, dataclass.TaskforProject item) async {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(uid)
        .collection('myProjects')
        .doc(projectid)
        .collection('tasks');

    DocumentReference docRef = _taskCollection.doc(item.taskid);

    await docRef
        .update(item.toJson())
        .whenComplete(() => print("Data berhasil diubah"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData(
      String uid, String projectid, String taskid) async {
    final CollectionReference _taskCollection = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(uid)
        .collection('myProjects')
        .doc(projectid)
        .collection('tasks');

    DocumentReference docRef = _taskCollection.doc(taskid);

    await docRef
        .delete()
        .whenComplete(() => print("Data berhasil dihapus"))
        .catchError((e) => print(e));
  }

  // Future<int> countProgress(String uid, String projectid) async {
  //   final Query<Map<String, dynamic>> undoneTasks = FirebaseFirestore.instance
  //       .collection('tblProject')
  //       .doc(uid)
  //       .collection('myProjects')
  //       .doc(projectid)
  //       .collection('tasks')
  //       .where('isdone', isEqualTo: false);

  //   Future<int> undone = undoneTasks.snapshots().length;

  //   final Query<Map<String, dynamic>> doneTasks = FirebaseFirestore.instance
  //       .collection('tblProject')
  //       .doc(uid)
  //       .collection('myProjects')
  //       .doc(projectid)
  //       .collection('tasks')
  //       .where('isdone', isEqualTo: false);

  //   Future<int> done = doneTasks.snapshots().length;

  //   int progress = (undone / done) * 100.round();
  // }

  static Future<int> countPendingTask(String uid, String projectid) async {
    final Query<Map<String, dynamic>> undoneTasks = FirebaseFirestore.instance
        .collection('tblProject')
        .doc(uid)
        .collection('myProjects')
        .doc(projectid)
        .collection('tasks')
        .where('isdone', isEqualTo: false);

    Future<int> undone = undoneTasks.snapshots().length;
    return undone;
  }
}
