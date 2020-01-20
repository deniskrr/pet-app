import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_app/model/pet_type.dart';
import 'package:enum_to_string/enum_to_string.dart';

class Pet extends Equatable {
  String id;
  String ownerId;
  String name;
  PetType type;
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

  Pet.keyVal({@required this.id,
    @required this.ownerId,
    @required this.name,
    @required this.type,
    @required this.age})
      : biography = "",
        pictureUrl = "",
        forPetSitting = false,
        forPetMating = false;

  Pet.keyValComplete({@required this.id,
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
        type = PetType.NotDefined,
        biography = "",
        pictureUrl = "",
        age = 0,
        forPetSitting = false,
        forPetMating = false;

  Map<String, dynamic> toJson() => {
    'ownerId': ownerId,
    'name': name,
    'type': petType,
    'age': age,
    'picture_url': pictureUrl,
    'biography': biography,
    'pet_sitting': forPetSitting,
    'pet_mating': forPetMating
  };

  Pet.fromJson(Map<String, dynamic> json)
      : ownerId = json['ownerId'],
        name = json['name'],
        type = EnumToString.fromString(PetType.values,json['type']),
        age = json['age'],
        pictureUrl = json['picture_url'],
        biography = json['biography'],
        forPetSitting = json['pet_sitting'],
        forPetMating = json['pet_mating'];

  Pet.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        ownerId = snapshot.data['ownerId'],
        name = snapshot.data['name'],
        type =  EnumToString.fromString(PetType.values,snapshot.data['type']),
        age = snapshot.data['age'],
        pictureUrl = snapshot.data['picture_url'],
        biography = snapshot.data['biography'],
        forPetSitting = snapshot.data['pet_sitting'],
        forPetMating = snapshot.data['pet_mating'];

  @override
  List<Object> get props => [id];

  String get petType {
    return EnumToString.parse(type);
  }

  set petType(String typeVal) {
    type = EnumToString.fromString(PetType.values, typeVal);
  }
}
