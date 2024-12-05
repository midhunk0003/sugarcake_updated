import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_constant.dart';

class AddButton extends StatelessWidget {
  const AddButton(
      {Key? key, required this.fct, required this.text, this.isLoading});

  final Function()? fct;
  final String text;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 5.7.h,
      child: ElevatedButton(
        onPressed: fct,
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
