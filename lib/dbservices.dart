import 'package:nuli/dataclass.dart' as dataclass;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;

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
              email: user.email!, fullname: fullname, uid: user.uid));
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
    firebase_auth.User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    cloud_firestore.DocumentReference userRef = _userCollection.doc(user.uid);
    return userRef.get().then(
        (value) => dataclass.User.fromJson(value.data as Map<String, dynamic>));
  }

  static Future<void> updateUserToFirestore(
      {required dataclass.User user}) async {
    cloud_firestore.DocumentReference userRef = _userCollection.doc(user.uid);
    await userRef
        .update(user.toJson())
        .whenComplete(() => print('User updated'))
        .catchError((e) => print(e));
  }
}
