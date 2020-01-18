import 'package:flutter/material.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/screens/services/service-profile/service_profile.dart';
import 'package:pet_app/widgets/image_tile.dart';

class ServiceTile extends StatelessWidget {
  final Service service;

  const ServiceTile({Key key, @required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageTile(
        imageUrl: service.pictureUrl,
        placeHolder: AssetImage("assets/blank_services.png"),
      ),
      title: Text(service.name),
      subtitle: Text(service.serviceCategory),
      trailing: Icon(Icons.chat,
        color: Theme.of(context).primaryColorLight,
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(ServiceProfile.routeName, arguments: service);
      },
    );
  }
}
