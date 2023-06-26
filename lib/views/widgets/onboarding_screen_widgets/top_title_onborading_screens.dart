import 'package:flutter/material.dart';
import '../../screens/create_account_screens/signup_screen.dart';

class TopTitleOnBoardingScreen extends StatelessWidget {
  const TopTitleOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: AppBar(
        leading: Image.asset(
          'assets/images/Logo.png',
          width: 80,
          height: 20,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
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
