class User {
  String email;
  String username;
  String uid;
  String pictureUrl;
  String bio;
  bool isPetSitter;

  User(this.email, this.username, this.uid)
      : pictureUrl = "",
        bio = "",
        isPetSitter = false;

  Map<String, dynamic> toJson() =>
      {
        'email': email,
        'username': username,
        'uid': uid,
        'picture_url': pictureUrl,
        'bio': bio,
        'pet_sitter': isPetSitter
      };

  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        username = json['username'],
        email = json['email'],
        pictureUrl = json['picture_url'],
        bio = json['bio'],
        isPetSitter = json['pet_sitter'];
}
