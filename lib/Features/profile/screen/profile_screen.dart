import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/profile/screen/Components/profile_icon.dart';
import 'package:sugar_cake/utils/app_constant.dart';

import '../controller/profile_controller.dart';
import 'edit_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  // Function to launch the URL
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "Could not launch the URL: $url",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Function to load token, userId, and accountType from SharedPreferences
  Future<Map<String, String?>> _loadDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString('token'),
      'userId': prefs.getString('userId'),
      'accountType': prefs.getString('type') ?? 'guest',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6FAFF),
      body: FutureBuilder<Map<String, String?>>(
        future: _loadDataFromPrefs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error loading data"),
            );
          } else {
            // Data from SharedPreferences
            final token = snapshot.data?['token'] ?? 'No token found';
            final userId = snapshot.data?['userId'] ?? 'No userId found';
            final accountType = snapshot.data?['type'] ?? 'Guest';

            return Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 35.h,
                        color: kPrimaryColor,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("Assets/icons/dp.png"),
                              Text(
                                controller.getProfileModel.value.userDetails!.name
                                    .toString(),
                                style: locationText,
                              ),
                              Text(
                                controller
                                    .getProfileModel.value.userDetails!.phoneNumber
                                    .toString(),
                                style: locationText,
                              ),
                              // Display token and userId if needed
                              // Text(
                              //   // 'Token: $token',
                              //   'Token: $accountType',
                              //   style: locationText,
                              // ),
                              // Text(
                              //   // 'User ID: $userId',
                              //   '',
                              //   style: locationText,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.h),
                        child: ProfileIcon(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.h, right: 3.h),
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Account Information",
                                      style: normalText,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(EditProfileScreen());
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                          Text("Edit"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Name",
                                  style: normalText,
                                ),
                                _fieldwidget(
                                  controller.getProfileModel.value.userDetails!.name
                                      .toString(),
                                ),
                                Text(
                                  "Phone",
                                  style: normalText,
                                ),
                                _fieldwidget(
                                  controller.getProfileModel.value.userDetails!
                                      .phoneNumber
                                      .toString(),
                                ),
                                Text(
                                  "Email",
                                  style: normalText,
                                ),
                                _fieldwidget(
                                  controller
                                      .getProfileModel.value.userDetails!.email
                                      .toString(),
                                ),
                                // Conditionally show "Delete Account" button
                                if (accountType != 'Guest')
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: InkWell(
                                      onTap: () {
                                        _launchURL(
                                            'https://sugarcakesweets.com/login.html');
                                      },
                                      child: Text(
                                        "Delete Account",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            });
          }
        },
      ),
    );
  }

  _fieldwidget(String name) {
    return Padding(
      padding: EdgeInsets.all(1.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xf5f5f5e1),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: normalText,
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:sugar_cake/Features/profile/screen/Components/profile_icon.dart';
// import 'package:sugar_cake/utils/app_constant.dart';
//
// import '../controller/profile_controller.dart';
// import 'edit_profile.dart';
//
// import 'package:url_launcher/url_launcher.dart';
//
// class ProfileScreen extends StatelessWidget {
//   ProfileScreen({super.key});
//
//
//
//   final ProfileController controller = Get.put(ProfileController());
//   // Function to launch the URL
//   void _launchURL(String url) async {
//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       // Handle the error (e.g., show a snackbar or alert)
//       Get.snackbar("Error", "Could not launch the URL: $url",
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffD6FAFF),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else {
//           // Show UI when loading is complete
//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   height: 35.h,
//                   color: kPrimaryColor,
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset("Assets/icons/dp.png"),
//                         Text(
//                           controller.getProfileModel.value.userDetails!.name
//                               .toString(),
//                           style: locationText,
//                         ),
//                         Text(
//                           controller
//                               .getProfileModel.value.userDetails!.phoneNumber
//                               .toString(),
//                           style: locationText,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(3.h),
//                   child: ProfileIcon(),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 3.h, right: 3.h),
//                   child: Container(
//                     color: Colors.white,
//                     child: Padding(
//                       padding: EdgeInsets.all(1.h),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Account Information",
//                                 style: normalText,
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   Get.to(EditProfileScreen());
//                                 },
//                                 child: const Row(
//                                   children: [
//                                     Icon(
//                                       Icons.edit,
//                                       size: 20,
//                                     ),
//                                     Text("Edit"),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Text(
//                             "Name",
//                             style: normalText,
//                           ),
//                           _fieldwidget(
//                             controller.getProfileModel.value.userDetails!.name
//                                 .toString(),
//                           ),
//                           Text(
//                             "Phone",
//                             style: normalText,
//                           ),
//                           _fieldwidget(
//                             controller.getProfileModel.value.userDetails!
//                                 .phoneNumber
//                                 .toString(),
//                           ),
//                           Text(
//                             "Email",
//                             style: normalText,
//                           ),
//                           _fieldwidget(
//                             controller
//                                 .getProfileModel.value.userDetails!.email
//                                 .toString(),
//                           ),
//                           // New Text widget for "Delete Account"
//                           SizedBox(height: 2.h), // Add spacing before the text
//                           InkWell(
//                             onTap: () {
//                               _launchURL('https://sugarcakesweets.com/login.html'); // Replace with your URL
//                             },
//                             child: Text(
//                               "Delete Account",
//                               style: TextStyle(
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red,
//                                 letterSpacing: 1.5,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         }
//       }),
//     );
//   }
//
//   _fieldwidget(String name) {
//     return Padding(
//       padding: EdgeInsets.all(1.h),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: const Color(0xf5f5f5e1),
//         ),
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             name,
//             style: normalText,
//           ),
//         ),
//       ),
//     );
//   }
// }
