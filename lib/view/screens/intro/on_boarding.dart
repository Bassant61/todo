import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/chah_helper/chach_helper.dart';
import 'todo_splash.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Map<String, dynamic>> onboardList = [
    {
      "title": "Organize Your Tasks",
      "discribtion": "Easily manage your daily to-dos and stay on top of your schedule.",
      "image": "assets/svg/task.svg"
    },
    {
      "title": "Set Reminders",
      "discribtion": "Never miss a deadline or forget an important task with timely reminders.",
      "image": "assets/svg/reminder.svg"
    },
    {
      "title": "Achieve Your Goals",
      "discribtion": "Track your progress and celebrate your accomplishments every day.",
      "image": "assets/svg/goals.svg"
    },
  ];

  final PageController controller = PageController();
  int currentPagenumper = 0;

  @override
  void dispose() async {
    super.dispose();
    // Ensure the onboarding state is cached when the user exits.
    await CacheHelper.setData(key: "onBoarding", value: true);
  }

  void navigateToSplash() {
    CacheHelper.setData(key: "onBoarding", value: true).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ToDoSplash()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff7265E2),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // PageView to display onboarding pages
            PageView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  currentPagenumper = index;
                });
              },
              itemCount: onboardList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    SvgPicture.asset(
                      onboardList[index]["image"],
                      height: 325,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        onboardList[index]["title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        onboardList[index]["discribtion"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => navigateToSplash(),
                    child: Text(
                      'Skip',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: onboardList.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.white.withOpacity(0.2),
                      activeDotColor: Colors.white,
                      dotHeight: 6,
                      dotWidth: 6,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      if (currentPagenumper != onboardList.length - 1) {
                        controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        navigateToSplash();
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}