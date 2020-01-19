import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services/services_service.dart';
import 'package:pet_app/services/services.dart';

class FirebaseServicesService extends ServicesService {
  final Firestore _firestore = Firestore.instance;

  @override
  Future<Service> addService(Service newService) async {
    await _firestore
        .collection("services")
        .add(newService.toJson());
    return newService;
  }

  @override
  Future<Service> updateService(Service editedService) async {
    await _firestore
        .collection("services")
        .document(editedService.id)
        .updateData(editedService.toJson());
    return editedService;
  }

  @override
  Future<String> deleteService(String serviceId) async {
    await _firestore
        .collection("services")
        .document(serviceId)
        .delete();
    return serviceId;
  }

  @override
  Future<List<Service>> getServicesForOwnerId(String ownerId) async {
    final querySnapshot = await _firestore
        .collection("services")
        .where("owner_id", isEqualTo: ownerId)
        .getDocuments();

    return querySnapshot.documents
        .map((document) => Service.fromDocumentSnapshot(document))
        .toList();
  }

  @override
  Future<List<Service>> getServicesForSearch(String petType, String category) async {
    if (category == null)
      return getServicesForPetType(petType);
    else
      return getServicesForPetTypeAndCategory(petType, category);
  }

  Future<List<Service>> getServicesForPetType(String petType) async {
    final querySnapshot = await _firestore
          .collection("services")
          .where("pet_type", isEqualTo: petType)
          .getDocuments();

    final currentUserId = services
        .get<AuthService>()
        .currentUserUid;

    return querySnapshot.documents
        .map((document) => Service.fromDocumentSnapshot(document))
        .where((service) => service.ownerId != currentUserId)
        .toList();
  }

  Future<List<Service>> getServicesForPetTypeAndCategory(String petType, String category) async {
    final querySnapshot = await _firestore
        .collection("services")
        .where("pet_type", isEqualTo: petType)
        .where("category", isEqualTo: category)
        .getDocuments();

    final currentUserId = services
        .get<AuthService>()
        .currentUserUid;

    return querySnapshot.documents
        .map((document) => Service.fromDocumentSnapshot(document))
        .where((service) => service.ownerId != currentUserId)
        .toList();
  }
}
