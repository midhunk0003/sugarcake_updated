import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';

import '../../controller/whishlist_controller.dart';

class FoodCardWhishlist extends StatelessWidget {
  FoodCardWhishlist({
    Key? key,
    required this.image,
    required this.name,
    required this.strikePrice,
    required this.price,
    required this.pid, required this.rating,
  }) : super(key: key);

  final String image;
  final String name;
  final String strikePrice;
  final String price;
  final String rating;
  final String pid;


  @override
  Widget build(BuildContext context) {
    final WhishListController controller = Get.put(WhishListController());
    // bool favorite = isFavorite == "True";

    final ScrollController _scrollController = ScrollController();

    // Store the scroll position
    final double _scrollPosition =
    _scrollController.hasClients ? _scrollController.position.pixels : 0.0;
    return Obx(
          () {
        if (controller.refreshPage.value) {
          // Defer the rebuild until after the current build phase is complete
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.refreshPage(
                false); // Reset refreshPage to false after triggering page refresh
            Get.forceAppUpdate(); // Force rebuild of the entire app
          });
          return Container(); // Return an empty container during the current build phase
        } else {

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 15.0,
                  spreadRadius: 0.5,
                  offset: const Offset(
                    3.0,
                    3.0,
                  ),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(1.2.h),
              child: SingleChildScrollView(
                controller: _scrollController, // Use the scroll controller
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            image,
                            height: 100.0,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: .4.h,
                          right: 0,
                          child: Obx(
                                () {
                              if (controller.refreshPage.value) {
                                // Defer the rebuild until after the current build phase is complete
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  controller.refreshPage(
                                      false); // Reset refreshPage to false after triggering page refresh
                                  Get.forceAppUpdate(); // Force rebuild of the entire app
                                });
                                return Container(); // Return an empty container during the current build phase
                              } else {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  height: 4.3.h,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    iconSize: 2.9.h,
                                    onPressed: () async{
                                     await controller.addtoWishlist(pid.toString());
                                    },
                                  ),
                                );
                              }
                            },
                          ),

                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(name, style: normalText),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xffF6C958),
                              size: 2.h,
                            ),
                            Text(rating, style: normalText),
                            Text(
                              " (1k+ Review)",
                              style: TextStyle(
                                color: Color(0xFF9A9A9A),
                                fontSize: 8.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("AED $strikePrice", style: offerText),
                            SizedBox(width: 1.h),
                            Text(price, style: normalText),
                          ],
                        ),
                        SizedBox(height: 1.h),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );

        }
      },
    );


    // Your existing widget code here
  }
}


