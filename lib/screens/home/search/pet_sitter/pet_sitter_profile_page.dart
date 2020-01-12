import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../model/user.dart';

class PetSitterProfilePage extends StatefulWidget {
  static final routeName = '/pet-sitter-profile';

  @override
  State<StatefulWidget> createState() => _PetSitterProfilePage();
}

class _PetSitterProfilePage extends State<PetSitterProfilePage> {

  @override
  Widget build(BuildContext context) {

    User currentUser = ModalRoute.of(context).settings.arguments;

    return Scaffold (
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.8)),
              clipper: getClipper(),
            ),
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
                                fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)
                            ),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ]
                        )
                    ),
                    SizedBox(height: 90.0),
                    Text(
                      currentUser.username,
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'
                      ),
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
                        child: Material(
                            borderRadius: BorderRadius.circular(35.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                                onTap: () {},
                                child: Center(
                                  child: Text(
                                      'Start chat now',
                                      style: TextStyle(
                                          color: Colors.white)
                                  ),
                                )
                            )
                        )
                    )
                  ],
                )
            )
          ],
        )
    );
  }
}

class getClipper extends CustomClipper<Path>{

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