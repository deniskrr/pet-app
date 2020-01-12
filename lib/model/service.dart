import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  String category;
  String name;
  String id;
  String ownerId;
  String pictureUrl;
  String description;
  String address;
  String petType;

  Service(this.id, this.name, this.ownerId, this.category, this.petType)
      : pictureUrl = "",
        description = "";

  Service.empty()
      : id = "",
        ownerId = "",
        name = "",
        category = "",
        description = "",
        pictureUrl = "",
        address = "",
        petType = "";

  Map<String, dynamic> toJson() =>
      {
        'address': address,
        'name': name,
        'id': id,
        'picture_url': pictureUrl,
        'description': description,
        'category': category,
        'owner_id': ownerId,
        'pet_type': petType
      };

  Service.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        address = json['address'],
        pictureUrl = json['picture_url'],
        description = json['description'],
        ownerId = json['owner_id'],
        category = json['category'],
        petType = json['pet_type'];

  Service.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        ownerId = snapshot.data['ownerId'],
        name = snapshot.data['name'],
        description = snapshot.data['description'],
        address = snapshot.data['address'],
        pictureUrl = snapshot.data['picture_url'],
        category = snapshot.data['category'],
        petType = snapshot.data['petType'];
}
