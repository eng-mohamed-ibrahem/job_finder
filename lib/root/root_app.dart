import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/navigation_screens_cubit/navigation_screen_cubit.dart';
import 'package:job_finder/controller/cubit/onboarding_screen_cubit/onboard_screen_cubit.dart';
import 'package:job_finder/views/screens/onboarding_screens/splash_screen.dart';
import '../controller/cubit/edit_profile_screens_cubit/file_path_cubit.dart';
import '../controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import '../views/screens/profile_settings_screens/profile_screen.dart';

RouteObserver<ModalRoute> routeObserver = RouteObserver();

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardScreenCubit(),
        ),
        BlocProvider(
          create: (context) => NavigationScreenCubit(),
        ),
        BlocProvider(
          create: (context) => SignupLoginScreenCubit(),
        ),
        BlocProvider(
          create: (context) => AnimateScrollExceedCubit(),
        ),
        BlocProvider(
          create: (context) => FilePathCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true).copyWith(
          textTheme: const TextTheme().apply(
            displayColor: const Color.fromRGBO(17, 24, 39, 1),
            bodyColor: const Color.fromRGBO(17, 24, 39, 1),
          ),
        ),
        home: const Splash(),
        navigatorObservers: [
          routeObserver,
        ],
      ),
    );
  }
}
