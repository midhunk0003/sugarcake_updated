import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/add_button.dart';
import '../../../Widgets/textFormField_widget.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/text_constant.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

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
          key:_formKey ,
          child: Column(children: [
            SizedBox(
              height: 3.h,
            ),
            const Center(
                child: TextWidget(
              text: 'Edit Profile',
              size: 24,
              fontWeight: FontWeight.bold,
            )),
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
                    Column(
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
                          height: 4.h,
                        ),
                        AddButton(
                          fct: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate() ) {
                              _controller.editProfile(_nameController.text, _emailController.text, _phoneNumberController.text);
                            }
                          },
                          text: 'Submit',
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
