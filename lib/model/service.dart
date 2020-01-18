import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_app/model/pet_type.dart';
import 'package:pet_app/model/service_category.dart';

class Service extends Equatable {
  ServiceCategory category;
  String name;
  String id;
  String ownerId;
  String pictureUrl;
  String description;
  String address;
  PetType petType;

  Service(this.id, this.name, this.ownerId, this.category, this.petType)
      : pictureUrl = "",
        description = "",
        address = "";

  Service.empty()
      : id = "",
        ownerId = "",
        name = "",
        category = ServiceCategory.NotDefined,
        description = "",
        pictureUrl = "",
        address = "",
        petType = PetType.NotDefined;

  Service.keyVal({@required this.id,
    @required this.ownerId,
    @required this.name,
    @required this.petType,
    @required this.category})
      : description = "",
        address = "",
        pictureUrl = "";

  Service.keyValComplete({@required this.id,
    @required this.ownerId,
    @required this.name,
    @required this.description,
    @required this.pictureUrl,
    @required this.address,
    @required this.category,
    @required this.petType});

  Map<String, dynamic> toJson() =>
      {
        'address': address,
        'name': name,
        'id': id,
        'picture_url': pictureUrl,
        'description': description,
        'category': serviceCategory,
        'owner_id': ownerId,
        'pet_type': servicePetType
      };

  Service.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        address = json['address'],
        pictureUrl = json['picture_url'],
        description = json['description'],
        ownerId = json['owner_id'],
        category = EnumToString.fromString(ServiceCategory.values,json['category']),
        petType = EnumToString.fromString(PetType.values,json['pet_type']);

  Service.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        ownerId = snapshot.data['owner_id'],
        name = snapshot.data['name'],
        description = snapshot.data['description'],
        address = snapshot.data['address'],
        pictureUrl = snapshot.data['picture_url'],
        category = EnumToString.fromString(ServiceCategory.values,snapshot.data['category']),
        petType = EnumToString.fromString(PetType.values,snapshot.data['pet_type']);

  @override
  List<Object> get props => [id];

  String get servicePetType {
    return EnumToString.parse(petType);
  }

  set servicePetType(String typeVal) {
    petType = EnumToString.fromString(PetType.values, typeVal);
  }

  String get serviceCategory {
    return EnumToString.parse(category);
  }

  set serviceCategory(String categoryVal) {
    category = EnumToString.fromString(ServiceCategory.values, categoryVal);
  }
}
