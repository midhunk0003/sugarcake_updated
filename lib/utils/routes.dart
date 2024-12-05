import 'package:flutter/material.dart';
import 'package:sugar_cake/Features/product/screens/products_screen.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/forgot_password.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/otp/otp_screen.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/signup/signup_screen.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/guest_login.dart';
import 'package:sugar_cake/Features/splash/onboards_screen.dart';
import 'package:sugar_cake/utils/init_screen.dart';
import '../Features/signin_screen.dart/Screen/signIn/signin_screen.dart';
import '../Features/splash/Components/introduction_screen.dart';
import '../Features/splash/splash.dart';

final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  SplashScreen.routeName: (context) =>  SplashScreen(),
  IntroductionScreen.routeName: (context) => IntroductionScreen(),
  OnboardScreen.routeName: (context) => const OnboardScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  GuestLoginScreen.routeName: (context) => GuestLoginScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  ProductsScreen.routeName: (context) => ProductsScreen(pid: '',),
  // CartScreen.routeName: (context) => CartScreen(),
  // LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),

  // CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(
        name: '',
        phoneNumber: '',
        password: '',
        email: '', keyUser: '',
      ),
  // HomeScreen.routeName: (context) => const HomeScreen(),

  // DetailsScreen.routeName: (context) => const DetailsScreen(),

  // ProfileScreen.routeName: (context) => const ProfileScreen(),utes = {
};
