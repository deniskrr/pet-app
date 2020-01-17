import 'package:pet_app/model/service.dart';

abstract class ServicesService {
  Future<Service> addService(Service newService);

  Future<Service> updateService(Service editedService);

  Future<String> deleteService(String serviceId);

  Future<List<Service>> getServicesForOwnerId(String ownerId);

  Future<List<Service>> getServicesForCategory(String category);

  Future<List<Service>> getServicesForPetType(String petType);
}
