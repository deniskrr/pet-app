import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/services/pets/pets_service.dart';

class FirebasePetsService extends PetsService{
  final Firestore _firestore = Firestore.instance;

  @override
  Future<Pet> addPet(Pet newPet) async {
    await _firestore
        .collection("pets")
        .add(newPet.toJson());
    return newPet;
  }

  @override
  Future<Pet> updatePet(Pet editedPet) async {
    await _firestore
        .collection("pets")
        .document(editedPet.uid)
        .updateData(editedPet.toJson());
    return editedPet;
  }
}