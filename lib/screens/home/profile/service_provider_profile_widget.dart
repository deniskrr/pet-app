import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/screens/services/add-service/add_service_page.dart';
import 'package:pet_app/screens/services/my-services/my_services_page.dart';

class ServiceProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text("Add Service"),
              onPressed: () {
                Navigator.of(context).pushNamed(AddServicePage.routeName,
                    arguments: Service.empty());
              },
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text("My Services"),
              onPressed: () {
                Navigator.of(context).pushNamed(MyServicesPage.routeName);
              },
            )
          ],
        );
      },
    );
  }
}