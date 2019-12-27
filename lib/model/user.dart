class User {
  final String email;
  final String uid;

  User(this.email, this.uid);

  Map<String, dynamic> toJson() =>
      {
        'email': email,
        'uid': uid,
      };
}
