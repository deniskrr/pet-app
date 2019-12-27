class User {
  final String email;
  final String username;
  final String uid;

  User(this.email, this.username, this.uid);

  Map<String, dynamic> toJson() =>
      {
        'email': email,
        'username': username,
        'uid': uid,
      };

  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        username = json['username'],
        email = json['email'];
}
