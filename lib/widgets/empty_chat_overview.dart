import 'package:flutter/material.dart';

class EmptyChatOverview extends StatelessWidget {
  const EmptyChatOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
              child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "You haven't talked to anyone yet!",
                    style: TextStyle(fontSize: 17),
                  ))),
          SizedBox(
            height: 10,
          ),
          Align(
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  "Connect with pet sitters or pet service owners by searching for them on the search page",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ))
        ]);
  }
}
