import 'package:flutter/material.dart';
import 'package:job_finder/views/screens/login_screens/login_screen.dart';

class TopTitleOnBoardingScreen extends StatelessWidget {
  const TopTitleOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: AppBar(
        leading: Image.asset(
          'assets/images/logo.png',
          width: 80,
          height: 20,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false);
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color.fromRGBO(107, 114, 128, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
