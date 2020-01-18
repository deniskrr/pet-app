import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;

  const InputField({Key key, this.controller, this.hintText, this.isObscure = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          hintMaxLines: 4),
      obscureText: isObscure,
    );
  }
}
