import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final bool? endabled;
  VoidCallback? onPressed;
  bool flat = false;

  Button({
    Key? key,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.endabled,
    this.onPressed,
    this.flat = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: !flat
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: backgroundColor ?? Colors.blue,
            )
          : null,
      child: TextButton(
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              text ?? '',
              style: TextStyle(
                fontSize: 20,
                color: textColor ?? Colors.white,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
