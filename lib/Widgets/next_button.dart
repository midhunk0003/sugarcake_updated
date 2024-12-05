import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.fct, required this.text});
  final Function fct;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        fct();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff09BBB5),
          foregroundColor: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          )),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
