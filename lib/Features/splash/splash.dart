import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_cake/Features/splash/Components/introduction_screen.dart';
import 'package:sugar_cake/Features/splash/controller/splash_controller.dart';
import 'package:sugar_cake/utils/init_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splashScreen";
   SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.put(SplashController());
  SharedPreferences? _prefs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          // ignore: unnecessary_string_escapes
          "Assets/images/splash_4.png",
          // height: 120.h,
          width: MediaQuery.of(context).size.width * 0.8,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void initState() {
    checkPrefUser();
    super.initState();
  }

  Future<void> checkPrefUser() async {
    // Simulate delay for splash screen
    await Future.delayed(const Duration(seconds: 3));

    // Get SharedPreferences instance
    _prefs = await SharedPreferences.getInstance();

    // Check if token exists
    final token = _prefs?.getString('token');
    print(token);
    final type = _prefs?.getString('type');
    print('#####');
    print(type);
    // if (type == 'Guest')
    //   {
    //     Navigator.pushReplacementNamed(context, IntroductionScreen.routeName);
    //   }
    // else {
      if (controller.limitFeatureProductsModel.value.response.toString() ==
          "Success") {
        // Token exists, navigate to home screen
        Navigator.pushReplacementNamed(context, InitScreen.routeName);
      } else {
        // Token doesn't exist, navigate to introduction screen
        Navigator.pushReplacementNamed(context, IntroductionScreen.routeName);
      }
    // }
  }
}
