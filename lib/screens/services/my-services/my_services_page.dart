import 'package:flutter/material.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services/services_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/widgets/service_list_view.dart';

class MyServicesPage extends StatelessWidget {
  static final routeName = '/my-services';
  final ServicesService _servicesService = services.get<ServicesService>();
  final AuthService _authService = services.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Services"),
      ),
      body: FutureBuilder(
        future: _servicesService.getServicesForOwnerId(_authService.currentUserUid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Service> services = snapshot.data;
            return Flex(
              direction: Axis.vertical,
              children: [
                ServiceListView(
                  serviceList: services,
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
