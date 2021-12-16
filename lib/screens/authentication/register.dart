// register screen
import 'package:flutter/material.dart';
import 'package:pong_bot/widgets/input_field.dart';
import 'package:pong_bot/widgets/button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final isKeboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      reverse: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (!isKeboard)
            Image.asset(
              'assets/logo/Ping-Pong-Download-PNG.png',
              height: 200.0,
            ),
          const SizedBox(height: 25.0),
          const Text(
            'Register',
            style: TextStyle(
              fontSize: 60.0,
              fontWeight: FontWeight.w900,
              color: Colors.black12,
              letterSpacing: 16.0,
            ),
          ),
          const SizedBox(height: 25.0),
          _buildEmailIputField(context),
          _buildPasswordInputField(context),
          _buildLoginButton(context),
          _buildRegisterButton(context),
        ],
      ),
    );
  }

  Widget _buildEmailIputField(BuildContext context) {
    return InputField(
      labelText: 'Enter email',
      controller: myEmailController,
      isEmail: true,
    );
  }

  Widget _buildPasswordInputField(BuildContext context) {
    return InputField(
      labelText: 'Enter password',
      controller: myPasswordController,
      isPassword: true,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Button(
      text: 'Register',
      onPressed: () {},
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Button(
      text: 'Already have an account?',
      flat: true,
      textColor: Colors.blue,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
