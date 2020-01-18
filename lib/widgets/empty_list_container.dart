import 'package:flutter/material.dart';

class EmptyListContainer extends StatelessWidget {
  const EmptyListContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
              child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Your list is empty now!",
                    style: TextStyle(fontSize: 16),
                  ))),
          SizedBox(
            height: 10,
          ),
          Align(
              child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              "Click + button to add new items!",
              style: TextStyle(fontSize: 16),
            ),
          ))
        ]);
  }
}
