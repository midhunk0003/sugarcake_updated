import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sugar_cake/Features/explore/screens/explore_screen.dart';
import 'package:sugar_cake/Features/whishlist/screen/fav_screen.dart';
import 'package:sugar_cake/Features/home/screen/home_screen.dart';
import 'package:sugar_cake/Features/profile/screen/profile_screen.dart';
import 'package:sugar_cake/utils/app_constant.dart';

import '../Features/explore/controller/explore_controller.dart';
import '../Features/home/controller/home_controller.dart';
import '../Features/profile/controller/profile_controller.dart';
import '../Features/whishlist/controller/whishlist_controller.dart';

const Color inActiveIconColor = Color(0xFF9A9A9A);

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  static String routeName = "/initScreen";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  @override
  void initState()  {
    final HomeController _controller = Get.find<HomeController>();
    final ProfileController controller = Get.find<ProfileController>();
    final ExploreController excnotroller = Get.find<ExploreController>();
    final WhishListController whishController = Get.find<WhishListController>();
     controller.getProfile();
     _controller.fetchLimitFeatureProduct();
    _controller.fetchLimitPopularProduct();
     excnotroller.getExploreList();
     whishController.getWishList();
  }

  final pages = [
    HomeScreen(),
    // CartScreen(),
    ExploreScreen(),
    WhishListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: pages[currentSelectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500]!,
              blurRadius: 15.0,
              spreadRadius: 0.5,
              offset: const Offset(
                3.0,
                3.0,
              ),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: SizedBox(
            // height: 8.h,
            child: BottomNavigationBar(
              onTap: updateCurrentIndex,
              currentIndex: currentSelectedIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedLabelStyle: const TextStyle(color: inActiveIconColor),
              selectedLabelStyle: const TextStyle(color: kPrimaryColor),
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: kPrimaryColor,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "Assets/icons/Home Icon.svg",
                    colorFilter: const ColorFilter.mode(
                      inActiveIconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "Assets/icons/HomeSelect Icon.svg",
                    colorFilter: const ColorFilter.mode(
                      kPrimaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "Home",
                ),
                // BottomNavigationBarItem(
                //   icon: SvgPicture.asset(
                //     "Assets/icons/Cart Icon.svg",
                //     colorFilter: const ColorFilter.mode(
                //       inActiveIconColor,
                //       BlendMode.srcIn,
                //     ),
                //   ),
                //   activeIcon: SvgPicture.asset(
                //     "Assets/icons/ShopSelect Icon.svg",
                //     colorFilter: const ColorFilter.mode(
                //       kPrimaryColor,
                //       BlendMode.srcIn,
                //     ),
                //   ),
                //   label: "Cart",
                // ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "Assets/icons/Explore Icon.svg",
                    colorFilter: const ColorFilter.mode(
                      inActiveIconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "Assets/icons/ExploreSelect Icon.svg",
                    // colorFilter: const ColorFilter.mode(
                    //   kPrimaryColor,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                  label: "Explore",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "Assets/icons/Fav Icon.svg",
                    colorFilter: const ColorFilter.mode(
                      inActiveIconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "Assets/icons/FavSelect Icon.svg",
                    colorFilter: const ColorFilter.mode(
                      kPrimaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "Whishlist",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "Assets/icons/Profile Icon.svg",
                    colorFilter: const ColorFilter.mode(
                      inActiveIconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "Assets/icons/ProfileSelect Icon.svg",
                    colorFilter: const ColorFilter.mode(
                      kPrimaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
