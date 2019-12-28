class User {
  String email;
  String username;
  String uid;
  String pictureUrl;
  bool isPetSitter;

  User(this.email, this.username, this.uid)
      : pictureUrl = "",
        isPetSitter = false;

  Map<String, dynamic> toJson() =>
      {
        'email': email,
        'username': username,
        'uid': uid,
        'picture_url': pictureUrl,
        'pet_sitter': isPetSitter
      };

  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        username = json['username'],
        email = json['email'],
        pictureUrl = json['picture_url'],
        isPetSitter = json['pet_sitter'];
}
