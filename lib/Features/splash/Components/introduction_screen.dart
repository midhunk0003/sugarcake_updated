import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/signIn/signin_screen.dart';
import 'package:sugar_cake/Features/splash/Components/intro_components.dart';
import 'package:sugar_cake/Features/splash/onboards_screen.dart';
import 'package:sugar_cake/Widgets/add_button.dart';
import 'package:sugar_cake/utils/app_colors.dart';
import 'package:sugar_cake/utils/app_constant.dart';

class IntroductionScreen extends StatelessWidget {
  static String routeName = "/introductionScreen";

  IntroductionScreen({super.key});

  final List<Map<String, dynamic>> splashData = [
    {
      "textSegments": [
        {"text": "Welcome to ", "color": Colors.black},
        {"text": "Our Sweet Bakery ", "color": kSecondaryColor},
        {"text": "Haven!", "color": Colors.black}
      ],
      "image": "Assets/images/intro.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntroContent(
              textSegments: splashData[0]["textSegments"],
              image: splashData[0]["image"],
              subtext:
                  'Where every slice is a celebration! Bringing sweetness to your special moments!',
            ),
            Padding(
              padding: EdgeInsets.all(3.h),
              child: AddButton(
                fct: () {
                  Navigator.pushNamed(context, OnboardScreen.routeName);
                },
                text: "Let's get started",
              ),
            ),
            InkWell(
                onTap: (){
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },

                child: _buildRichtext()),
            const SizedBox(
                height:
                    40), // Add some spacing between the RichText and the bottom of the screen
          ],
        ),
      ),
    );
  }

  Widget _buildRichtext() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 16.0, // Adjust font size as needed
          color: Colors.black, // Default color for the text
        ),
        children: const [
          TextSpan(
            text: 'Already have an account? ', // First part of the text
            style: TextStyle(
              color: Colors.black, // Color for the first part of the text
            ),
          ),
          TextSpan(
            text: 'Sign In', // Second part of the text
            style: TextStyle(
              color: kSecondaryColor, // Color for the second part of the text
            ),
          ),
        ],
      ),
    );
  }
}
