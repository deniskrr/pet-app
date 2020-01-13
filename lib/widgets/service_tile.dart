import 'package:flutter/material.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/screens/services/service-profile/service_profile.dart';

class ServiceTile extends StatelessWidget {
  final Service service;

  const ServiceTile({Key key, @required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: service.pictureUrl.isEmpty
          ? Image.asset(
        "assets/blank_pet_profile.png",
      )
          : Image.network(
        service.pictureUrl,
      ),
      title: Text(service.name),
      subtitle: Text(service.category),
      onTap: () {
        Navigator.of(context)
            .pushNamed(ServiceProfile.routeName, arguments: service);
      },
    );
  }
}