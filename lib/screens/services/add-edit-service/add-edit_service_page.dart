import 'package:flutter/material.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/screens/services/add-edit-service/add-edit_service_form.dart';
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
      resizeToAvoidBottomPadding: false,
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AddEditServiceForm(
                  addServiceHandler: (Service newService) async {
                    _servicesService
                        .addService(newService)
                        .then((value) => Navigator.of(context).pop());
                  },
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
