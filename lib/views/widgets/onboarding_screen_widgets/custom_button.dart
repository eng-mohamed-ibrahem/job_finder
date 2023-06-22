import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text});
  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: const MaterialStatePropertyAll(
          Size(double.infinity, 48),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const MaterialStatePropertyAll(
          Color.fromRGBO(51, 102, 255, 1),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
