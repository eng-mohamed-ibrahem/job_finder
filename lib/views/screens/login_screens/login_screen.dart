import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/cubit/signup_screens_cubit/signup_screens_cubit.dart';
import '../../../controller/utils/validation.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';
import '../../widgets/signup_screen_widget/customized_text_field.dart';
import '../create_account_screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            'assets/images/logo.png',
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(17, 24, 39, 1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Please login to find your dream job',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(107, 114, 128, 1),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomizedTextFormField(
                controller: usernameController,
                hintText: "Username",
                prefixIcon: const Icon(
                  Icons.person_rounded,
                  color: Colors.black12,
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  if (!BlocProvider.of<SignupLoginScreenCubit>(context)
                      .changed) {
                    BlocProvider.of<SignupLoginScreenCubit>(context)
                        .changeButtonStyle();
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<SignupLoginScreenCubit, SignupCubitState>(
                buildWhen: (previous, current) {
                  if (current is ObscureVisbilityCubitState) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  return CustomizedTextFormField(
                    controller: passwordController,
                    validator: Validation.passwordValidated,
                    hintText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.black12,
                    ),
                    obscureText:
                        !BlocProvider.of<SignupLoginScreenCubit>(context)
                            .visible,
                    suffixIcon: InkWell(
                      onTap: () {
                        BlocProvider.of<SignupLoginScreenCubit>(context)
                            .updateVisibility();
                      },
                      child: BlocProvider.of<SignupLoginScreenCubit>(context)
                              .visible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    onChanged: (value) {
                      if (!BlocProvider.of<SignupLoginScreenCubit>(context)
                          .changed) {
                        BlocProvider.of<SignupLoginScreenCubit>(context)
                            .changeButtonStyle();
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  BlocBuilder<SignupLoginScreenCubit, SignupCubitState>(
                    buildWhen: (previous, current) {
                      if (current is ChangeCheckedCubitState) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                    builder: (context, state) {
                      return Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(
                          const Color.fromRGBO(51, 102, 255, 1),
                        ),
                        value: BlocProvider.of<SignupLoginScreenCubit>(context)
                            .checked,
                        onChanged: (value) {
                          BlocProvider.of<SignupLoginScreenCubit>(context)
                              .updateChecked();
                        },
                      );
                    },
                  ),
                  const Text('Remember me'),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // TODO: Naviage to Forgot Password
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(51, 102, 255, 1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Dont't have an account?",
                    style: TextStyle(
                      color: Color.fromRGBO(156, 163, 175, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(51, 102, 255, 1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<SignupLoginScreenCubit, SignupCubitState>(
                  buildWhen: (previous, current) {
                    if (current is ChangeButtonStyleCubitState) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        fontSize: 16,
                        backgroundColor:
                            !BlocProvider.of<SignupLoginScreenCubit>(context)
                                    .changed
                                ? const MaterialStatePropertyAll(
                                    Color.fromRGBO(209, 213, 219, 1),
                                  )
                                : const MaterialStatePropertyAll(
                                    Color.fromRGBO(51, 102, 255, 1),
                                  ),
                        textColor:
                            !BlocProvider.of<SignupLoginScreenCubit>(context)
                                    .changed
                                ? const Color(0xff6B7280)
                                : Colors.white,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // TODO navigate to  home screen

                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const WorkTypeScreen(),
                            //   ),
                            //   (route) => false,
                            // );
                          }
                        },
                        text: 'Login');
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Color.fromRGBO(209, 213, 219, 1),
                      thickness: 2,
                      height: 10,
                      indent: 5,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    "Or Login With Account",
                    style: TextStyle(
                      color: Color.fromRGBO(107, 114, 128, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color.fromRGBO(209, 213, 219, 1),
                      thickness: 2,
                      height: 10,
                      endIndent: 5,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromRGBO(209, 213, 219, 1),
                            width: 0.5,
                          ),
                        ),
                        child: Image.asset(
                          "assets/icons/google.png",
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromRGBO(209, 213, 219, 1),
                            width: 1,
                          ),
                        ),
                        child: Image.asset(
                          "assets/icons/facebook.png",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
