import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final Function(String, String) registerHandler;

  const RegisterForm({Key key, this.registerHandler}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
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
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "E-mail",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              obscureText: true,
            ),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                hintText: "Confirm password",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    widget.registerHandler(
                        emailController.text, passwordController.text);
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
