import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Widgets/add_button.dart';
import 'package:sugar_cake/Widgets/textFormField_widget.dart';
import 'package:sugar_cake/utils/app_constant.dart';
import 'package:sugar_cake/utils/text_constant.dart';

import 'signup/controller/signup_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgotPasswordScreen";

  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  late final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: EdgeInsets.only(left: 2.h, top: 0.h, bottom: 1.h),
            child: InkWell(
              onTap: () {
                Get.back();
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
            child: Column(children: [
          SizedBox(
            height: 3.h,
          ),
          const Center(
              child: TextWidget(
            text: 'Forgot Password',
            size: 24,
            fontWeight: FontWeight.bold,
          )),
          Padding(
            padding: EdgeInsets.only(left: 4.h, right: 4.h),
            child: const Column(
              children: [
                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextWidget(
                      text:
                          'Lost your way? Dont worry, we will help you reset it!Just enter your email, and let’s get you back on track!',
                      size: 10,
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
                    text: 'phone', size: 12, fontWeight: FontWeight.bold),
                SizedBox(
                  height: 1.h,
                ),
                TextFormFieldWidget(
                  controller: emailController,
                  hinttext: 'example@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : AddButton(
                          fct: () {
                            controller
                                .sendForgotPasswordOtp(emailController.text);
                          },
                          text: 'Submit',
                        ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ])));
  }
}
