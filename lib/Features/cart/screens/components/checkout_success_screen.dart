import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/orders/screen/orders_screen.dart';
import 'package:sugar_cake/utils/init_screen.dart';

import '../../../../utils/app_constant.dart';
import '../../../orders/controller/order_controller.dart';

class SuccessScreen extends StatelessWidget {
   SuccessScreen({super.key});
   final OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          // logic
        },
        child: Stack(
          children: [
            IgnorePointer(
              child: Lottie.asset(
                'Assets/json/confetti.json',
                width: MediaQuery.sizeOf(context).height,
                height: MediaQuery.sizeOf(context).height,
                fit: BoxFit.cover,
                repeat: false,
              ),
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.only(left: 3.h, right: 3.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Image.asset(
                    'Assets/images/scss.png',
                    height: 15.h,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'Thanks for your order',
                    style: headText,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 5.7.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.fetchOrderList();
                        Get.to(MyOrdersScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[100],
                        foregroundColor: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.h),
                        ),
                      ),
                      child: Text(
                        'View order',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 5.7.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => const InitScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff09BBB5),
                        foregroundColor: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.h),
                        ),
                      ),
                      child: Text(
                        'Back to homepage',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
