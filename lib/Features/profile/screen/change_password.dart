import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/profile/controller/profile_controller.dart';

import '../../../Widgets/add_button.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/text_constant.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final TextEditingController oldPwdController = TextEditingController();
  final TextEditingController newPwdController = TextEditingController();
  final TextEditingController cnfPwdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final ProfileController _controller = Get.find<ProfileController>();

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
                  height: 40,
                  width: 40,
                  color: Colors.transparent,
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 3.h,
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
          child: Column(children: [
            SizedBox(
              height: 3.h,
            ),
            const Center(
                child: TextWidget(
              text: 'Change Password',
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
                        text: '',
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
                  SizedBox(
                    height: 1.h,
                  ),
                  Obx(() => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                            text: 'Password',
                            size: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color(0xFFF4F4F4),
                            ),
                          ),
                          TextFormField(
                            controller: oldPwdController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: const Color(0xFFF4F4F4),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                              hintText: 'Enter old password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your old password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          const TextWidget(
                            text: 'New Password',
                            size: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          TextFormField(
                            controller: newPwdController,
                            obscureText: _controller.obscureText.value,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: const Color(0xFFF4F4F4),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                              hintText: 'Enter new password',
                              // suffixIcon: IconButton(
                              //   icon: Icon(
                              //     _controller.obscureText.value
                              //         ? Icons.visibility_off
                              //         : Icons.visibility,
                              //     color: Colors.grey,
                              //   ),
                              //   onPressed: () {
                              //     _controller.obscureText.toggle();
                              //   },
                              // ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your new password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          const TextWidget(
                            text: 'confirm Password',
                            size: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          TextFormField(
                            controller: cnfPwdController,
                            obscureText: _controller.obscureText.value,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: const Color(0xFFF4F4F4),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                              hintText: "Enter confirm password",
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
                                return ' Enter confirm password';
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  AddButton(
                    fct: () {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        _controller.changePassword(oldPwdController.text,
                            newPwdController.text, cnfPwdController.text);
                      }
                    },
                    text: 'Submit',
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ]),
        )));
  }
}
