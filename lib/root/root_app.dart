import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/navigation_screens_cubit/navigation_screen_cubit.dart';
import 'package:job_finder/controller/cubit/onboarding_screen_cubit/onboard_screen_cubit.dart';
import '../views/onboarding_screens/splash_screen.dart';

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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home: const Splash(),
      ),
    );
  }
}
