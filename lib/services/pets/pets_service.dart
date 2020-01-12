import 'package:pet_app/model/pet.dart';

abstract class PetsService {
  Future<Pet> addPet(Pet newPet);

  Future<Pet> updatePet(Pet editedPet);

  Future<String> deletePet(String petId);

  Future<List<Pet>> getPetsForOwnerId(String ownerId);

  Future<List<Pet>> getMatingPetsForOwnerId(String ownerId);

  Future<List<Pet>> getPetSittablePetsForOwnerId(String ownerId);

  Future<List<Pet>> getMatingCompanionsForType(String type);
}
