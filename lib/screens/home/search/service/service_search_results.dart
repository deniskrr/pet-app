import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/model/service_category.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/services/services_service.dart';
import 'package:pet_app/widgets/service_list_view.dart';

class ServicesSearchResults extends StatelessWidget {
  final Pet forPet;
  final ServiceCategory forCategory;
  final ServicesService _serviceService = services.get<ServicesService>();

  ServicesSearchResults({@required this.forPet, @required this.forCategory});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _serviceService.getServicesForSearch(forPet.petType, forCategory.toString()),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Service> services = snapshot.data;
          return ServiceListView(
            serviceList: services,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
