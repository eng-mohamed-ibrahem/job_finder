import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontSize = 12,
    this.backgroundColor,
    this.textColor,
  });
  final void Function()? onPressed;
  final String text;
  final double fontSize;
  final MaterialStateProperty<Color?>? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        // minimumSize: const MaterialStatePropertyAll(
        //   Size(double.infinity, 48),
        // ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
        textStyle: MaterialStatePropertyAll(
          TextStyle(color: Colors.white, fontSize: fontSize),
        ),
        backgroundColor: backgroundColor ??
            const MaterialStatePropertyAll(
              Color.fromRGBO(51, 102, 255, 1),
            ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor ?? Colors.white),
      ),
    );
  }
}
