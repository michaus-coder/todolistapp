import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuli/dataclass.dart' as dataclass;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;

import 'dataclass.dart';

class UserService {
  static final cloud_firestore.CollectionReference _userCollection =
      cloud_firestore.FirebaseFirestore.instance.collection('tblUser');
  static final firebase_auth.FirebaseAuth _auth =
      firebase_auth.FirebaseAuth.instance;

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
      ));
      return _userFromFirebase(user);
    } catch (e) {
      return e.toString();
    }
  }

  static Future signIn(String email, String password) async {
    try {
      firebase_auth.UserCredential result = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      firebase_auth.User user = result.user!;
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
    );
    cloud_firestore.DocumentReference userRef = _userCollection.doc(user.uid);

    await userRef
        .set(userData.toJson())
        .whenComplete(() => print('User saved'))
        .catchError((e) => print(e));
  }

  static Future<dynamic> getUserFromFirestore() async {
    await _auth.signInWithEmailAndPassword(
        email: "michaelwong306@gmail.com", password: "thisispassword");
    firebase_auth.User? user = _auth.currentUser;
    cloud_firestore.DocumentReference userRef = _userCollection.doc(user!.uid);
    print(user);
    User userData = await userRef
        .get()
        .then((value) => User.fromJson(value.data() as Map<String, dynamic>));

    // return user;
    return userData;
  }

  static Future<void> updateUserToFirestore(
      {required dataclass.User user}) async {
    cloud_firestore.DocumentReference userRef = _userCollection.doc(user.uid);
    await userRef
        .update(user.toJson())
        .whenComplete(() => print('User updated'))
        .catchError((e) => print(e));
  }

  static String getCurrentUserFirstName() {
    firebase_auth.User? user = _auth.currentUser;
    if (user == null) {
      return "";
    }
    return user.uid.toString();
  }
}

// CollectionReference _taskCollection = FirebaseFirestore.instance
//     .collection('tblTask')
//     .doc('r0003LzTzDUMPx9zle9EaNcWlCE2')
//     .collection('myTasks');

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

  static Future<void> addData(String uid, Task item) async {
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

  static Future<void> editData(String uid, Task item) async {
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
}
