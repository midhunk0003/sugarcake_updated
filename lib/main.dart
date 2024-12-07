import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/splash/splash.dart';
import 'package:sugar_cake/utils/app_colors.dart';
import 'package:sugar_cake/utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sugar cake',
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            primaryColor: AppColors.primaryColor,
            scaffoldBackgroundColor: AppColors.backgroundColor),
        // theme: AppTheme.lightTheme(context),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      );
    });
  }
}
