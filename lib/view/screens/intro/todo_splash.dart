import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/view/screens/todo_layout.dart'; // Make sure this import is correct
import '../../../core/chah_helper/chach_helper.dart';
import '../../../model_view/task_cubit.dart';
import 'on_boarding.dart'; // Onboarding Screen import

class ToDoSplash extends StatefulWidget {
  const ToDoSplash({super.key});

  @override
  State<ToDoSplash> createState() => _ToDoSplashState();
}

class _ToDoSplashState extends State<ToDoSplash> {

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  // Check if onboarding is completed or not and navigate accordingly
  void _checkOnboardingStatus() async {
    await Future.delayed(Duration(seconds: 2));  // Simulate loading delay for splash screen
    bool? isOnboardingComplete = CacheHelper.getData(key: "onBoarding");

    if (isOnboardingComplete ?? false) {
      // Navigate directly to Noteapp if onboarding is done
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Noteapp()),
      );
    } else {
      // Navigate to OnboardingScreen if onboarding is not completed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is InitDBSucsess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Noteapp()),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 43),
            child: Center(
              child: Lottie.asset("assets/lotties/loading.json"),
            ),
          ),
        ),
      ),
    );
  }
}