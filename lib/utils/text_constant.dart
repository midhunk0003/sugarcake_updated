import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;

  const TextWidget(
      {super.key,
      required this.text,
      required this.size,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: size.sp, // Assuming you want to use width as the font size
        fontWeight: fontWeight,
        color: Colors.black,
      ),
    );
  }
}
