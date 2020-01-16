import 'package:flutter/material.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/widgets/service_tile.dart';

class ServiceListView extends StatelessWidget {
  final List<Service> serviceList;

  const ServiceListView({Key key, this.serviceList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black12,
        ),
        itemCount: serviceList.length,
        itemBuilder: (context, index) {
          Service currentService = serviceList[index];
          return ServiceTile(
            service: currentService,
          );
        },
      ),
    );
  }
}
