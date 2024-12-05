import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const kPrimaryColor = Color(0xFF09BBB5);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFFB48D2D);
const kTextColor = Colors.black;
const kLightcolor = Color(0xFF9A9A9A);
const kAnimationDuration = Duration(milliseconds: 400);
const scaffoldBackgroundColor = Color.fromARGB(255, 241, 241, 241);
TextStyle normalSecondaryText = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w300,
  color: kSecondaryColor,
  // height: 1.5,
);
TextStyle normalText = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  overflow: TextOverflow.ellipsis,
  // height: 1.5,
);
TextStyle offerText = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w300,
    color: kLightcolor,
    decoration: TextDecoration.lineThrough
    // height: 1.5,
    );
TextStyle locationText = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xffF3F3F3).withOpacity(.7),
    overflow: TextOverflow.ellipsis
    // height: 1.5,
    );
TextStyle lightText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
    color: kLightcolor,
    decoration: TextDecoration.lineThrough
    // height: 1.5,
    );
TextStyle discText = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w300,
  color: kLightcolor,

  // height: 1.5,
);
TextStyle headText = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
  color: Colors.black,

  // height: 1.5,
);
TextStyle headPrimaryText = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,

  // height: 1.5,
);
TextStyle secondaryBoldText = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.bold,
  color: kSecondaryColor,
  // height: 1.5,
);
TextStyle smallText = TextStyle(
    fontSize: 9.sp,
    fontWeight: FontWeight.w300,
    color: kLightcolor,
    overflow: TextOverflow.ellipsis

    // height: 1.5,
    );
TextStyle whiteText = TextStyle(
  fontSize: 11.sp,
  fontWeight: FontWeight.bold,
  color: Colors.white,

  // height: 1.5,
);
TextStyle iconText = TextStyle(
  fontSize: 8.sp,
  fontWeight: FontWeight.bold,
  color: Colors.black,

  // height: 1.5,
);
const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kTextColor),
  );
}
