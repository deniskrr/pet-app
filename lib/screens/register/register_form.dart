import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/widgets/input_field.dart';

class RegisterForm extends StatefulWidget {
  final Function(String, String, String) registerHandler;

  const RegisterForm({Key key, this.registerHandler}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            InputField(
              controller: emailController,
              hintText: "E-mail",
            ),
            InputField(
              controller: usernameController,
              hintText: "Username",
            ),
            InputField(
              controller: passwordController,
              hintText: "Password",
              isObscure: true,
            ),
            InputField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              isObscure: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    widget.registerHandler(emailController.text,
                        usernameController.text, passwordController.text);
                  }
                },
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
