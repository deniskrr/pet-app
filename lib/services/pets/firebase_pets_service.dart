import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/pets/pets_service.dart';
import 'package:pet_app/services/services.dart';

class FirebasePetsService extends PetsService {
  final Firestore _firestore = Firestore.instance;

  @override
  Future<Pet> addPet(Pet newPet) async {
    await _firestore.collection("pets").add(newPet.toJson());
    return newPet;
  }

  @override
  Future<Pet> updatePet(Pet editedPet) async {
    await _firestore
        .collection("pets")
        .document(editedPet.id)
        .updateData(editedPet.toJson());
    return editedPet;
  }

  @override
  Future<List<Pet>> getPetsForOwnerId(String ownerId) async {
    final querySnapshot = await _firestore
        .collection("pets")
        .where("ownerId", isEqualTo: ownerId)
        .getDocuments();

    return querySnapshot.documents
        .map((document) => Pet.fromDocumentSnapshot(document))
        .toList();
  }

  @override
  Future<List<Pet>> getMatingCompanionsForType(String type) async {
    final querySnapshot = await _firestore
        .collection("pets")
        .where("type", isEqualTo: type)
        .where("pet_mating", isEqualTo: true)
        .getDocuments();

    final currentUserId = services
        .get<AuthService>()
        .currentUserUid;

    return querySnapshot.documents
        .map((document) => Pet.fromDocumentSnapshot(document))
        .where((pet) => pet.ownerId != currentUserId)
        .toList();
  }
}
