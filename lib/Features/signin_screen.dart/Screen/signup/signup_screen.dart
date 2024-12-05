import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:sugar_cake/Widgets/textFormField_widget.dart';
import 'package:sugar_cake/Widgets/add_button.dart';
import 'package:sugar_cake/Widgets/richtext_widget.dart';
import 'package:sugar_cake/utils/app_constant.dart';
import 'package:sugar_cake/utils/text_constant.dart';
import 'package:url_launcher/url_launcher.dart';
import '../signIn/signin_screen.dart';
import 'controller/signup_controller.dart';

// import 'package:url_launcher/url_launcher.dart';


class SignUpScreen extends StatefulWidget {
  static String routeName = "/signUpScreen";

  const SignUpScreen({super.key});



  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  // final bool isChecked = false;
  late final SignUpController _controller = Get.put(SignUpController());

  void _launchURL() async {
    const url = 'https://sugarcakesweets.com/terms-conditions.html'; // Replace with your actual link
    if (await canLaunch(url)) {
      await launch(url);  // Opens the link in a browser
    } else {
      throw 'Could not launch $url';
    }
  }

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
                child: IconButton(
                  onPressed: () {
                    Get.offAll(SignInScreen());
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: kPrimaryColor,
                  ),
                )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: TextWidget(
                  text: 'Create Account',
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
                              'Register to explore our cake menu and customize your orders for any occasion.',
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
                      text: 'Name',
                      size: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    TextFormFieldWidget(
                      controller: _nameController,
                      hinttext: 'Enter your name',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    const TextWidget(
                      text: 'Phone',
                      size: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    TextFormFieldWidget(
                      controller: _phoneNumberController,
                      hinttext: '+00 0000000',
                      keyboardType: TextInputType.phone,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your phone number';
                      //   }
                      //   // You can add additional validation logic for phone number
                      //   return null;
                      // },
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
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
                      hinttext: 'example@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // You can add additional validation logic for email
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
                ),),
                    Obx(
                      () => Row(
                        children: [
                          Checkbox(
                            value: _controller.isChecked.value,
                            onChanged: (value) {
                              _controller.toggleCheckbox(value ?? false);
                            },
                          ),
                          // RichTextWidget(
                          //   text1: 'Agree with ',
                          //   text2: 'Terms & Conditions',
                          //   fct: () {},
                          // ),
                          // RichText with clickable "Terms & Conditions"
                          Expanded(
                            child: Row(
                              children: [
                                Text('Agree with '), // Normal text

                                InkWell(
                                  onTap: _launchURL, // Trigger URL launch when tapped
                                  child: Text(
                                    'Terms & Conditions', // Clickable text
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline, // Underline to show it's clickable
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() => _controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : AddButton(
                      fct: () {
                        if (_formKey.currentState!.validate()) {
                          if (_controller.isChecked.value) {
                            _controller.fetchSendOtp(
                              _nameController.text,
                              _emailController.text,
                              _phoneNumberController.text,
                              _passwordController.text,
                            );
                          } else {
                            // Show a snackbar or handle the case when the checkbox is not checked
                            // For example:
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please agree to the Terms & Conditions.'),
                              ),

                            );
                          }}
                      },
                      text: 'Sign Up',
                    ),),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Center(
                      child: RichTextWidget(
                        text1: 'Already have an account ? ',
                        text2: 'Sign In',
                        fct: () {
                          Get.offAll(SignInScreen());
                        },
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
