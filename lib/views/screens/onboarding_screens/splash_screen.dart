import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 800),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const OnBoradingScreen()),
            (route) => false);
      },
    );
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(214, 228, 255, 0.14),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 85) - 95,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(214, 228, 255, 0.14),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 180) - 95,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(214, 228, 255, 0.14),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 260) - 95,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(214, 228, 255, 0.3),
            ),
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 141,
            height: 31,
          ),
        ],
      ),
    );
  }
}
