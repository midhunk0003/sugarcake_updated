

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_constant.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.onPressed, required this.text});

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 5.7.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff09BBB5),
          foregroundColor: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}