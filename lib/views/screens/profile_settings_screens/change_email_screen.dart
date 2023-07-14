import 'package:flutter/material.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';
import '../../../controller/utils/validation.dart';
import '../../widgets/signup_screen_widget/customized_text_field.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email address'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const Text('Main e-mail address'),
            const SizedBox(
              height: 20,
            ),
            CustomizedTextFormField(
              controller: emailController,
              validator: Validation.emailValidated,
              hintText: "Email",
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.black12,
              ),
              keyboardType: TextInputType.text,
            ),
            const Spacer(),
            Center(
              child: CustomButton(
                fontSize: 16,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // TODO: save changes
                  }
                },
                text: 'Save',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
