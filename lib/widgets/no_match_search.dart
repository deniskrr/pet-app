import 'package:flutter/cupertino.dart';

class NoMatchSearch extends StatelessWidget {
  const NoMatchSearch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        "Sorry, no match found!",
        style: TextStyle(fontSize: 16.0),
      ),
    ]);
  }
}
