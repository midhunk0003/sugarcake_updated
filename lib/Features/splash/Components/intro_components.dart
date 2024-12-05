import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class IntroContent extends StatelessWidget {
  final String image;
  final String subtext;
  final List<Map<String, dynamic>> textSegments;

  const IntroContent({
    super.key,
    required this.image,
    required this.textSegments,
    required this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.only(
            left: 1.5.h,
            right: 1.5.h,
          ),
          child: _buildRichText(),
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.only(left: 3.h, right: 3.h),
          child: Text(
            subtext,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _buildRichText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontSize: 24.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold), // Default style
        children: textSegments.map((segment) {
          return TextSpan(
            text: segment['text'],
            style: TextStyle(
                color: segment['color']), // Apply color from the segment
          );
        }).toList(),
      ),
    );
  }
}
