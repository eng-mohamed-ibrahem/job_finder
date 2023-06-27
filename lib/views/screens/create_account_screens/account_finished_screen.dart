import 'package:flutter/material.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';

class AccountFinishedScreen extends StatelessWidget {
  const AccountFinishedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Image.asset(
              'assets/images/Success_Account.png',
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Your account has been set up!',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromRGBO(17, 24, 39, 1),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'We have customized feeds according to your preferences',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color.fromRGBO(107, 114, 128, 1),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Get Started',
                fontSize: 16,
                onPressed: () {
                  // TODO : Navigate to home screen
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
