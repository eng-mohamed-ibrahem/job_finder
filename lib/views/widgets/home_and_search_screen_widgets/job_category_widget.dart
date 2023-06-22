import 'package:flutter/material.dart';

class JobCategoryWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final String category;
  const JobCategoryWidget({
    super.key,
    required this.category,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color.fromRGBO(214, 228, 255, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(
              color: textColor ?? const Color.fromRGBO(51, 102, 255, 1)),
        ),
      ),
    );
  }
}
