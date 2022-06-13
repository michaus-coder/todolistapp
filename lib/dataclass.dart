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
