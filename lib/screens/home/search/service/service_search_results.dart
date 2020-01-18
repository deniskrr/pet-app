import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/model/service_category.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/services/services_service.dart';
import 'package:pet_app/widgets/no_match_search.dart';
import 'package:pet_app/widgets/service_list_view.dart';

class ServicesSearchResults extends StatelessWidget {
  final Pet forPet;
  final ServiceCategory forCategory;
  final ServicesService _serviceService = services.get<ServicesService>();

  ServicesSearchResults({@required this.forPet, @required this.forCategory});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _serviceService.getServicesForSearch(forPet.petType, EnumToString.parse(forCategory)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Service> services = snapshot.data;
          if (services.isNotEmpty)
            return ServiceListView(
              serviceList: services,
            );
          else
            return NoMatchSearch();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
