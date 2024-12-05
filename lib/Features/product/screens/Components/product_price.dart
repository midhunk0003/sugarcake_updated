import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';

import '../../../signin_screen.dart/Screen/signIn/signin_screen.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice(
      {super.key,
        required this.cartFct,
        required this.price,
        required this.strikePrice});

  final Function cartFct;
  final String price;
  final String strikePrice;

  Future<void> _checkAccountType(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountType = prefs.getString('type') ?? 'guest';

    if (accountType == 'Guest') {
      // Show popup asking the guest to log in
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Login Required"),
          content: Text("Please log in to add items to your cart."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Close popup
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Clear all session data
                await prefs.clear();

                // Close the popup and navigate to the login screen
                Navigator.of(ctx).pop();
                Navigator.pushReplacementNamed(context, SignInScreen.routeName); // Use your login route here
              },
              child: Text("Login"),
            ),
          ],
        ),
      );
    } else {
      // Proceed with adding to cart
      cartFct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 3.h,
        top: 1.h,
        right: 3.h,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total',
              style: discText,
            ),
            Row(
              children: [
                Text(
                  strikePrice,
                  style: lightText,
                ),
                SizedBox(
                  width: 1.h,
                ),
                Text(
                  price,
                  style: normalText,
                ),
              ],
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            _checkAccountType(context); // Check account type on button press
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff09BBB5),
            foregroundColor: kSecondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.h),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.shopping_cart_checkout_outlined,
                color: Colors.white,
              ),
              Text(
                'Add to cart',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:sugar_cake/utils/app_constant.dart';
//
// class ProductPrice extends StatelessWidget {
//   const ProductPrice(
//       {super.key,
//       required this.cartFct,
//       required this.price,
//       required this.strikePrice});
//   final Function cartFct;
//   final String price;
//   final String strikePrice;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 3.h,
//         top: 1.h,
//         right: 3.h,
//       ),
//       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Total',
//               style: discText,
//             ),
//             Row(
//               children: [
//                 Text(
//                   strikePrice,
//                   style: lightText,
//                 ),
//                 SizedBox(
//                   width: 1.h,
//                 ),
//                 Text(
//                   price,
//                   style: normalText,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         ElevatedButton(
//           onPressed: () {
//             cartFct();
//           },
//           style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xff09BBB5),
//               foregroundColor: kSecondaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5.h),
//               )),
//           child: Row(
//             children: [
//               const Icon(
//                 Icons.shopping_cart_checkout_outlined,
//                 color: Colors.white,
//               ),
//               Text(
//                 'Add to cart',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         )
//       ]),
//     );
//   }
// }
