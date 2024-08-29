import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:recipe_app/bloc/auth/auth_bloc.dart';
import 'package:recipe_app/bloc/auth/auth_events.dart';
import 'package:recipe_app/bloc/auth/auth_state.dart';
import 'package:recipe_app/ui/screens/home_screen.dart';
import 'package:recipe_app/ui/screens/splash/onboarding_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AppStartedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        Future.delayed(const Duration(seconds: 1), () {
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is AuthUnauthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            );
          }
        });
      },
      child: Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: 860,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(63, 180, 177, 1),
              image: DecorationImage(
                image: AssetImage('assets/images/background_welcome.png'),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(240),
                Image.asset(
                  'assets/images/logo.png',
                  color: Colors.white,
                  width: 234,
                  height: 234,
                ),
                const Text(
                  'Meals On\n Demand',
                  style: TextStyle(
                      height: 1,
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return const OnboardingScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: 209,
                    height: 60,
                    child: const Center(
                      child: Text(
                        'Let’s start',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
