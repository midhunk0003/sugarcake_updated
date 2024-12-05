import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/profile/screen/adress_screen.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/signIn/signin_screen.dart';
import 'package:sugar_cake/utils/app_constant.dart';

import '../../../../Widgets/snackbar_messeger.dart';
import '../../../orders/controller/order_controller.dart';
import '../../../orders/screen/orders_screen.dart';
import '../../controller/address_controller.dart';
import '../change_password.dart';

class ProfileIcon extends StatelessWidget {
  ProfileIcon({
    super.key,
  });

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final AddressController controller = Get.put(AddressController());
  final OrderController ocontroller = Get.put(OrderController());

  Future<void> _checkAccountTypeAndNavigate(
      BuildContext context, String destination) async {
    SharedPreferences prefs = await _prefs;
    String accountType = prefs.getString('type') ?? 'guest';

    if (accountType == 'Guest') {
      // Redirect to login if the account type is "Guest"
      Get.to(SignInScreen());
      SnackbarManager.showSuccessSnackbar(
          context, 'Info', 'Please log in to access $destination');
    } else {
      // Perform actions based on the destination
      switch (destination) {
        case 'Orders':
          await ocontroller.fetchOrderList();
          Get.to(MyOrdersScreen());
          break;
        case 'Address':
          await controller.getAddressList();
          Get.to(AddAddressScreen());
          break;
        case 'ChangePassword':
          Get.to(ChangePasswordScreen());
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  _checkAccountTypeAndNavigate(context, 'Orders');
                },
                child: Column(
                  children: [
                    Image.asset("Assets/icons/oerders.png"),
                    Text(
                      'Orders',
                      style: iconText,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  _checkAccountTypeAndNavigate(context, 'Address');
                },
                child: Column(
                  children: [
                    Image.asset("Assets/icons/address.png"),
                    Text(
                      'Address',
                      style: iconText,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  _checkAccountTypeAndNavigate(context, 'ChangePassword');
                },
                child: Column(
                  children: [
                    Image.asset("Assets/icons/changePassword.png"),
                    Text(
                      'Change Password',
                      style: iconText,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () async {
                  final SharedPreferences? prefs = await _prefs;
                  prefs?.clear();
                  Get.offAll(SignInScreen());
                  SnackbarManager.showSuccessSnackbar(
                      Get.context!, 'Success!', 'Logout Successful');
                },
                child: Column(
                  children: [
                    Image.asset("Assets/icons/logout.png"),
                    Text(
                      'Logout',
                      style: iconText,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
// import 'package:sugar_cake/Features/profile/screen/adress_screen.dart';
// import 'package:sugar_cake/Features/signin_screen.dart/Screen/signIn/signin_screen.dart';
// import 'package:sugar_cake/utils/app_constant.dart';
//
// import '../../../../Widgets/snackbar_messeger.dart';
// import '../../../orders/controller/order_controller.dart';
// import '../../../orders/screen/orders_screen.dart';
// import '../../controller/address_controller.dart';
// import '../change_password.dart';
//
//
// class ProfileIcon extends StatelessWidget {
//    ProfileIcon({
//     super.key,
//   });
//
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//    final AddressController controller = Get.put(AddressController());
//    final OrderController ocontroller = Get.put(OrderController());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Padding(
//         padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
//         child: Row(
//           children: [
//             Expanded(
//                 flex: 1,
//                 child: InkWell(
//                   onTap: () async {
//                     await ocontroller.fetchOrderList();
//
//                     Get.to(MyOrdersScreen());
//                   },
//                   child: Column(
//                     children: [
//                       Image.asset("Assets/icons/oerders.png"),
//                       Text(
//                         'Orders',
//                         style: iconText,
//                       )
//                     ],
//                   ),
//                 )),
//             Expanded(
//                 flex: 1,
//               child: InkWell(
//
//                 onTap: () async {
//                   await controller.getAddressList();
//
//                     Get.to(AddAddressScreen());
//                 },
//                 child: Column(
//                   children: [
//                     Image.asset("Assets/icons/address.png"),
//                     Text(
//                       'Address',
//                       style: iconText,
//                     )
//                   ],
//                 ),
//               ),),
//             Expanded(
//                 flex: 2,
//                 child: InkWell(
//                   onTap: (){
//                     Get.to(ChangePasswordScreen());
//
//                   },
//                   child: Column(
//                     children: [
//                       Image.asset("Assets/icons/changePassword.png"),
//                       Text(
//                         'Change Password',
//                         style: iconText,
//                       )
//                     ],
//                   ),
//                 )),
//             Expanded(
//                 flex: 1,
//                 child: InkWell(onTap: ()async{
//                   final SharedPreferences?  Prefs = await _prefs;
//                   Prefs?.clear();Get.offAll(SignInScreen());
//                   SnackbarManager.showSuccessSnackbar(Get.context!, 'Success!', 'Logout Successfull');
//                 },
//                   child: Column(
//                     children: [
//                       Image.asset("Assets/icons/logout.png"),
//                       Text(
//                         'Logout',
//                         style: iconText,
//                       )
//                     ],
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
