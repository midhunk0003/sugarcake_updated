import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

import '../../../../../Widgets/custom_button.dart';
import '../../../../../utils/app_constant.dart';
import '../../../../../utils/text_constant.dart';
import '../controller/signup_controller.dart';

class SendForgotPasswordOtp extends StatelessWidget {
  final String email;
  final String keyUser;

  SendForgotPasswordOtp(
      {super.key, required this.email, required this.keyUser});

  OtpFieldController otpFieldController = OtpFieldController();
  late final SignUpController controller = Get.find<SignUpController>();
  String? otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 1.h, left: 2.h, right: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                elevation: 2,
                shape: const CircleBorder(),
                child: Container(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    color: Colors.black,
                    iconSize: 4.h,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.h, left: 2.h),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: TextWidget(
                        text: 'Verify OTP',
                        size: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("We sent your code to "),
                    Text(email),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("This code will expired in "),
                        TweenAnimationBuilder(
                          tween: Tween(begin: 900.0, end: 0.0),
                          duration: const Duration(seconds: 900),
                          builder: (_, dynamic value, child) {
                            int totalSeconds = value.toInt();
                            int minutes = (totalSeconds ~/ 60);
                            int seconds = (totalSeconds % 60);

                            // Format minutes and seconds to ensure two digits
                            String formattedTime = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

                            return Text(
                              formattedTime,
                              style: const TextStyle(color: kPrimaryColor),
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2.h),
                      child: OTPTextField(
                        controller: otpFieldController,
                        length: 4,
                        width: double.infinity,
                        fieldWidth: 5.h,
                        spaceBetween: 0,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        outlineBorderRadius: 1.h,
                        otpFieldStyle: OtpFieldStyle(
                          backgroundColor: const Color(0xffE8E8E8),
                          focusBorderColor: kPrimaryColor,
                          enabledBorderColor: kSecondaryColor,
                          disabledBorderColor: const Color(0xffE8E8E8),
                        ),
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.box,
                        onCompleted: (pin) {},
                        onChanged: (pin) {
                          // print("onchange PIN IS: $pin");

                          otp = pin.toString();
                        },
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn’t receive OTP ?",
                          style: GoogleFonts.titilliumWeb(
                            fontSize: 13.sp,
                            color: Colors.black.withOpacity(1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // InkWell(
                        //   onTap: ()async{
                        //
                        //     await _ccontroller.fetchSendOtp(
                        //       name.toString(),
                        //       email.toString(),
                        //       phoneNumber.toString(),
                        //       password.toString(),
                        //     );
                        //
                        //   },
                        //   child: Text(
                        //     "Resend code",
                        //     style: normalSecondaryText,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              onPressed: () async {
                                await controller.fetchVerifyOtp(
                                    otp.toString(), keyUser, email);
                              },
                              text: 'Verify',
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
}
