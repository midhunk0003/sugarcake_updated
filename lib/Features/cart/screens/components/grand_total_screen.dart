import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';

class GrandTotalScreen extends StatelessWidget {
  const GrandTotalScreen(
      {super.key,
      required this.cartFct,
      required this.price,
      required this.strikePrice});
  final Function cartFct;
  final String price;
  final String strikePrice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 3.h,
        top: 1.h,
        right: 3.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Grand Total',
                style: discText,
              ),
              Row(
                children: [
                  // Text(
                  //   strikePrice,
                  //   style: lightText,
                  // ),
                  // SizedBox(
                  //   width: 1.h,
                  // ),
                  Text(
                    price,
                    style: normalText,
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              const CircularProgressIndicator();
              await cartFct();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff09BBB5),
                foregroundColor: kSecondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.h),
                )),
            child: const Text(
              'Proceed to checkout',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
