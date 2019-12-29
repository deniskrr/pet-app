import 'package:flutter/cupertino.dart';

class Pet {
  String id;
  String ownerId;
  String name;
  String type;
  String biography;
  String pictureUrl;
  int age;
  bool forPetSitting;
  bool forPetMating;

  Pet(this.id, this.ownerId, this.name, this.type, this.age)
      : biography = "",
        pictureUrl = "",
        forPetSitting = false,
        forPetMating = false;

  Pet.complete(this.id, this.ownerId, this.name, this.type, this.biography,
      this.pictureUrl, this.age, this.forPetMating, this.forPetSitting);

  Pet.keyVal(
      {@required this.id,
      @required this.ownerId,
      @required this.name,
      @required this.type,
      @required this.age})
      : biography = "",
        pictureUrl = "",
        forPetSitting = false,
        forPetMating = false;

  Pet.keyValComplete(
      {@required this.id,
      @required this.ownerId,
      @required this.name,
      @required this.type,
      @required this.biography,
      @required this.pictureUrl,
      @required this.age,
      @required this.forPetSitting,
      @required this.forPetMating});

  Pet.empty()
      : id = "",
        ownerId = "",
        name = "",
        type = "",
        biography = "",
        pictureUrl = "",
        age = 0,
        forPetSitting = false,
        forPetMating = false;

  Map<String, dynamic> toJson() => {
        'ownerId': ownerId,
        'name': name,
        'type': type,
        'age': age,
        'picture_url': pictureUrl,
        'biography': biography,
        'pet_sitting': forPetSitting,
        'pet_mating': forPetMating
      };

  Pet.fromJson(Map<String, dynamic> json)
      : ownerId = json['ownerId'],
        name = json['name'],
        type = json['type'],
        age = int.parse(json['age']),
        pictureUrl = json['picture_url'],
        biography = json['biography'],
        forPetSitting = json['pet_sitting'],
        forPetMating = json['pet_mating'];
}
