import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) valueHandler;

  const LabeledCheckbox({Key key, this.label, this.value, this.valueHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: 16.0),
        ),
        Checkbox(
          value: value,
          onChanged: (bool val) => valueHandler(val),
        )
      ],
    );
  }
}
