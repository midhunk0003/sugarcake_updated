import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/cart/screens/cart_screen.dart';
import 'package:sugar_cake/Features/home/screen/components/search_screen.dart';
import 'package:sugar_cake/utils/app_colors.dart';
import 'package:sugar_cake/utils/app_constant.dart';


class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String currentAddress = 'My location';
  late Position currentposition;
  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress = "${place.street}";
      });
    } catch (e) {}
    return null;
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        color: kPrimaryColor,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 2.h, right: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('  Location', style: locationText),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              _determinePosition();
                            },
                            child: Icon(
                              Icons.location_on,
                              color: const Color(0xffF3F3F3).withOpacity(.7),
                            ),
                          ),
                          Text(
                            currentAddress.length > 30 ? '${currentAddress.substring(0, 30)}...' : currentAddress,
                            style: locationText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(

                    onTap: () {

                      Get.to(const CartScreen());
                    },
                    child: Container(
                      width: 5.h,
                      height: 5.h,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff555555),
                      ),
                      child: Image.asset(
                        'Assets/icons/Cart Icon.png',
                        width: 2.h,
                        height: 2.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1.h,
                  ),
                  // Cart icon
//Notification
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     width: 5.h,
                  //     height: 5.h,
                  //     padding: const EdgeInsets.all(2),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: const Color(0xff555555),
                  //     ),
                  //     child: Image.asset(
                  //       'Assets/icons/Notif Icon.png',
                  //       width: 2.h,
                  //       height: 2.h,
                  //     ),
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(SearchScreen());
                        },
                        child: TextField(
                    cursorColor: AppColors.greyElementColor,
                    decoration: InputDecoration(
                          fillColor: Colors.white,
                          enabled: false,
                          filled: true,
                          hintText: 'Search here....',
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'Assets/icons/Search Icon.png',
                              width: 2.h,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          hintStyle:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none)),
                  ),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 5.h,
                      height: 5.h,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        'Assets/icons/Filter Icon.png',
                        width: 2.h,
                        height: 2.h,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
