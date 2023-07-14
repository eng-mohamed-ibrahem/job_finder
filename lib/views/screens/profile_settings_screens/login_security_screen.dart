import 'package:flutter/material.dart';
import 'package:job_finder/views/screens/profile_settings_screens/phone_number_screen.dart';

import 'change_email_screen.dart';
import 'change_password_screen.dart';

class LoginAndSecurityScreen extends StatefulWidget {
  const LoginAndSecurityScreen({super.key});

  @override
  State<LoginAndSecurityScreen> createState() => _LoginAndSecurityScreenState();
}

class _LoginAndSecurityScreenState extends State<LoginAndSecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login and Security'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xffF4F4F5),
              border: Border.all(
                color: const Color(0xffE5E7EB),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Account access',
                style: TextStyle(
                  color: Color(0xffF4F4F5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                leading: const Text('Email address'),
                trailing: const Row(
                  children: [
                    Text(''),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangeEmailScreen(),
                    ),
                  );
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                leading: const Text('Phone number'),
                trailing: const Row(
                  children: [
                    Text(''),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhoneNumberScreen(),
                    ),
                  );
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                leading: const Text('Change password'),
                trailing: const Row(
                  children: [
                    Text(''),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                leading: const Text('Two-Step verification'),
                trailing: const Row(
                  children: [
                    Text(
                      'Not-active',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  // move to Two-Step verification screen
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                leading: const Text('Face ID'),
                trailing: const Row(
                  children: [
                    Text(''),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  // move to Face ID screen
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
