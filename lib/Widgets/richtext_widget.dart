import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sugar_cake/utils/app_constant.dart';

class RichTextWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final Function fct;
  const RichTextWidget(
      {super.key, required this.text1, required this.text2, required this.fct});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,

          fontSize: 16.0, // Adjust font size as needed
          color: Colors.black, // Default color for the text
        ),
        children: [
          TextSpan(
            text: text1, // First part of the text
            style: const TextStyle(
              color: Colors.black, // Color for the first part of the text
            ),
          ),
          TextSpan(
            text: text2, // Second part of the text
            style: const TextStyle(
              color: kSecondaryColor, // Color for the second part of the text
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                fct();
              },
          ),
        ],
      ),
    );
  }
}
