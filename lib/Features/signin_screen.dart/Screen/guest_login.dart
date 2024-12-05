import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Widgets/add_button.dart';
import 'package:sugar_cake/Widgets/textFormField_widget.dart';
import 'package:sugar_cake/utils/app_constant.dart';
import 'package:sugar_cake/utils/text_constant.dart';

class GuestLoginScreen extends StatelessWidget {
  static String routeName = "/guestLoginScreen";
  GuestLoginScreen({super.key});
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: EdgeInsets.only(left: 2.h, top: 0.h, bottom: 1.h),
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
        body: SingleChildScrollView(
            child: Column(children: [
          const Center(
              child: TextWidget(
            text: 'Guest Login',
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
                          'Log in to access a variety of delicious cakes, manage your orders, and schedule deliveries Enjoy a seamless experience with just a few taps',
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
                    text: 'Name', size: 12, fontWeight: FontWeight.bold),
                SizedBox(
                  height: 1.h,
                ),
                TextFormFieldWidget(
                  controller: _nameController,
                  hinttext: 'Enter your name',
                  keyboardType: TextInputType.name,
                ),
                SizedBox(
                  height: 1.3.h,
                ),
                const TextWidget(
                    text: 'Password', size: 12, fontWeight: FontWeight.bold),
                SizedBox(
                  height: 1.h,
                ),
                TextFormFieldWidget(
                  controller: _nameController,
                  hinttext: '**********',
                  keyboardType: TextInputType.name,
                ),
                SizedBox(
                  height: 1.3.h,
                ),
                const TextWidget(
                    text: 'Email', size: 12, fontWeight: FontWeight.bold),
                SizedBox(
                  height: 1.h,
                ),
                TextFormFieldWidget(
                  controller: _nameController,
                  hinttext: 'example@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 2.h,
                ),
                AddButton(
                  fct: () {},
                  text: 'Sign In',
                ),
              ],
            ),
          ),
        ])));
  }
}
