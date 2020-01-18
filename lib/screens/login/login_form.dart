import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/widgets/input_field.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String) loginHandler;

  const LoginForm({Key key, this.loginHandler}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              controller: passwordController,
              hintText: "Password",
              isObscure: true
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    widget.loginHandler(
                        emailController.text, passwordController.text);
                  }
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
