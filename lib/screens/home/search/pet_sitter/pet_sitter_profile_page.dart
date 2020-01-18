import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_app/model/user.dart';

class PetSitterProfilePage extends StatelessWidget {
  static final routeName = '/pet-sitter-profile';

  @override
  Widget build(BuildContext context) {
    User currentUser = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: new Stack(
      children: <Widget>[
        Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(currentUser.pictureUrl),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 90.0),
                Text(
                  currentUser.username,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  currentUser.bio,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 25.0),
                Container(
                    height: 50.0,
                    width: 95.0,
                    child: FlatButton(
                        padding: EdgeInsets.all(8.0),
                        color: Colors.green,
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Start chat now",
                              style: TextStyle(fontSize: 20.0),
                            ))))
              ],
            ))
      ],
    ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
