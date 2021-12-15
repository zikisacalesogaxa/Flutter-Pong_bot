import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? labelText;
  final bool isPassword;
  final bool isEmail;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSubmitted;

  // ignore: use_key_in_widget_constructors
  const InputField(
      {@required this.labelText,
      this.isPassword = false,
      this.isEmail = false,
      this.controller,
      this.onChanged,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onChanged: (String value) {
          _onChanged(value);
        },
      ),
    );
  }

  void _onChanged(String value) {
    if (onChanged != null) {
      onChanged!(value);
    }
  }
}
