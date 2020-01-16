import 'package:flutter/material.dart';

class EmptyListContainer extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const EmptyListContainer({Key key, this.controller, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              'No data found',
              style: TextStyle(fontSize: 16),
          )
        ]
      );
    }
}