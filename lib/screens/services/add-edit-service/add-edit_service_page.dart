import 'package:flutter/material.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/screens/home/home_page.dart';
import 'package:pet_app/screens/services/add-edit-service/add-edit_service_form.dart';
import 'package:pet_app/screens/services/my-services/my_services_page.dart';
import 'package:pet_app/services/services/services_service.dart';
import 'package:pet_app/services/services.dart';

class AddEditServicePage extends StatefulWidget {
  static final routeName = '/add-Service';

  @override
  _AddEditServicePageState createState() => _AddEditServicePageState();
}

class _AddEditServicePageState extends State<AddEditServicePage> {
  final ServicesService _servicesService = services.get<ServicesService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Service"),
      ),
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AddEditServiceForm(
                  addServiceHandler: (Service serviceObject) async {
                    if (serviceObject.id.isEmpty) {
                      _servicesService.addService(serviceObject).then((_) =>
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(MyServicesPage.routeName, ModalRoute.withName(HomePage.routeName)));
                    } else {
                      _servicesService
                          .updateService(serviceObject)
                          .then((_) => Navigator.of(context).pop());
                    }
                  },

                ),
            ],
      ),
          ),
        ),),
    );
  }
}
