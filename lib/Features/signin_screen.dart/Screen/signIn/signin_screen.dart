import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/forgot_password.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/signup/signup_screen.dart';
import 'package:sugar_cake/Widgets/add_button.dart';
import 'package:sugar_cake/Widgets/richText_widget.dart';
import 'package:sugar_cake/Widgets/textFormField_widget.dart';
import 'package:sugar_cake/utils/app_constant.dart';
import 'package:sugar_cake/utils/text_constant.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import '../../../splash/onboards_screen.dart';
import 'controller/login_controller.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/signInScreen";

  SignInScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final LoginInController _controller = Get.put(LoginInController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 2.h, top: 0.h, bottom: 1.h),
          child: InkWell(
            onTap: (){
              Get.offAll(const OnboardScreen());
            },
            child: Material(
              elevation: 2,
              shape: const CircleBorder(),
              child: Container(
                color: Colors.transparent,
                child: const Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                child: TextWidget(
                  text: 'Sign In',
                  size: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.h, right: 4.h),
                child: const Column(
                  children: [
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          text:
                          'Log in to explore a variety of cakes and schedule your delivery.',
                          size: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 3.h,
                  right: 3.h,
                  top: 2.5.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      text: 'Email',
                      size: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    TextFormFieldWidget(
                      controller: _emailController,
                      hinttext: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    const TextWidget(
                      text: 'Password',
                      size: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Obx(() => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color(0xFFF4F4F4),),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _controller.obscureText.value,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                          hintText: '**********',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _controller.obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _controller.obscureText.toggle();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    )),
                    SizedBox(
                      height: 2.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ForgotPasswordScreen.routeName);
                        },
                        child: Text(
                          "Forgot Password ?",
                          style: normalSecondaryText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(() => _controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : AddButton(
                      fct: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          _controller.fetchLogin(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                      text: 'Sign In',
                    )),
                    SizedBox(
                      height: 2.h,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SocalCard(
                    //       icon: "Assets/icons/google-icon.svg",
                    //       press: signIn,
                    //     ),
                    //     SocalCard(
                    //       icon: "Assets/icons/facebook-2.svg",
                    //       press: () {},
                    //     ),
                    //     SocalCard(
                    //       icon: "Assets/icons/twitter.svg",
                    //       press: () {},
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    Center(
                      child: Column(
                        children: [
                          RichTextWidget(
                            text1: 'Don’t have an account ? ',
                            text2: 'Sign Up ',
                            fct: () {
                              // Navigator.pushNamed(
                              //     context, SignUpScreen.routeName);
                              Get.to(SignUpScreen());
                            },
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          InkWell(
                            onTap: () {
                              _controller.guestLogin();
                            },
                            child: Text(
                              "Guest Login",
                              style: normalSecondaryText,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future signIn() async {
  //   GoogleSignIn _googleSignIn = GoogleSignIn();
  //   try {
  //     var result = await _googleSignIn.signIn();
  //     // print(result);
  //   } catch (error) {
  //     // print(error);
  //   }
  // }
}


