import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/signup/signup_screen.dart';
import 'package:sugar_cake/Features/splash/Components/intro_components.dart';
import 'package:sugar_cake/Widgets/next_button.dart';
import 'package:sugar_cake/utils/app_constant.dart';

class OnboardScreen extends StatefulWidget {
  static String routeName = "/onboardScreen";

  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  List<Map<String, dynamic>> splashData = [
    {
      "textSegments": [
        {"text": "Discover Delight: ", "color": Colors.black},
        {"text": "Explore Our Bakery ", "color": kSecondaryColor},
        {"text": "Selection!", "color": Colors.black}
      ],
      "image": "Assets/images/intro_1.png"
    },
    {
      "textSegments": [
        {"text": "Nothing in this ", "color": Colors.black},
        {"text": "world ", "color": kSecondaryColor},
        {"text": "is ", "color": Colors.black},
        {"text": "better ", "color": kSecondaryColor},
        {"text": "than ", "color": Colors.black},
        {"text": "cake ", "color": kSecondaryColor},
      ],
      "image": "Assets/images/intro_2.png"
    },
    {
      "textSegments": [
        {"text": "Keep calm.", "color": kSecondaryColor},
        {"text": "There’s nothing a ", "color": Colors.black},
        {"text": "slice of cake ", "color": kSecondaryColor},
        {"text": " can’t solve!", "color": Colors.black},
      ],
      "image": "Assets/images/intro_3.png"
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: splashData.length,
              itemBuilder: (context, index) {
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    IntroContent(
                      textSegments: splashData[index]["textSegments"],
                      image: splashData[index]["image"],
                      subtext:
                          'Creating sweet memories, one slice at a time! Let your celebrations be as unique as you!',
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                splashData.length,
                                (index) => AnimatedContainer(
                                  duration: kAnimationDuration,
                                  margin: const EdgeInsets.only(right: 5),
                                  height: 17,
                                  width: currentPage == index ? 20 : 20,
                                  decoration: BoxDecoration(
                                    color: currentPage == index
                                        ? kPrimaryColor
                                        : const Color(0xFFD8D8D8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Spacer

                        // ElevatedButton with padding
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: NextButton(
                            fct: () {
                              if (currentPage < splashData.length - 1) {
                                // If not on the last page, go to the next page
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              } else {
                                // If on the last page, navigate to the next screen
                                Navigator.pushNamed(
                                    context, SignUpScreen.routeName);
                              }
                            },
                            text: currentPage == splashData.length - 1
                                ? 'Next'
                                : '',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
