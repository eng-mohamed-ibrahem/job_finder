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
          CircleAvatar(
            radius: MediaQuery.of(context).size.width,
            backgroundColor: const Color.fromRGBO(214, 228, 255, 0.14),
          ),
          CircleAvatar(
            radius: (MediaQuery.of(context).size.width - 85) - 95,
            backgroundColor: const Color.fromRGBO(214, 228, 255, 0.14),
          ),
          CircleAvatar(
            radius: (MediaQuery.of(context).size.width - 180) - 95,
            backgroundColor: const Color.fromRGBO(214, 228, 255, 0.14),
          ),
          CircleAvatar(
            radius: (MediaQuery.of(context).size.width - 260) - 95,
            backgroundColor: const Color.fromRGBO(214, 228, 255, 0.3),
          ),
          Image.asset(
            'assets/images/Logo.png',
            width: 141,
            height: 31,
          ),
        ],
      ),
    );
  }
}
