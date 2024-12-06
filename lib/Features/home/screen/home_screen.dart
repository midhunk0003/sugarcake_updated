import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/home/controller/home_controller.dart';
import 'package:sugar_cake/Features/home/screen/components/appbar.dart';
import 'package:sugar_cake/Features/home/screen/components/banner.dart';
import 'package:sugar_cake/Features/home/screen/components/category_widget.dart';
import 'package:sugar_cake/Features/home/screen/components/feature_products.dart';
import 'package:sugar_cake/Features/home/screen/components/popular_product.dart';
import 'package:sugar_cake/Features/home/screen/components/popular_viewall.dart';
import 'package:sugar_cake/utils/app_constant.dart';

import 'components/Feature_view_all.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});

  final HomeController _controller = Get.put(HomeController());

  Future<void> _refreshData() async {
    await _controller.fetchBanner();
    await _controller.fetchCategory();
    await _controller.fetchLimitPopularProduct();
    await _controller.fetchLimitFeatureProduct();
    // await _controller.fetchPopularProduct();
    // await _controller.fetchFeatureProduct();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.width * 0.35,
          ),
          child: const CustomAppBar(),
        ),
        body: SingleChildScrollView(
          child: Obx(() {
            if (_controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BannerWidget(),
                  SizedBox(height: 2.h),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 2.h, right: 2.h, bottom: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Categories', style: headText),
                        // Text("See All", style: secondaryBoldText)
                      ],
                    ),
                  ),
                  if (_controller.getCategoryModel.value.categoryList != null)
                    CatagoriesWidget(
                      categories:
                          _controller.getCategoryModel.value.categoryList!,
                    ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 2.h, right: 2.h, bottom: 1.h),
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Featured Products', style: headText),
                          GestureDetector(
                            onTap: () async {
                              if (!_controller.isLoading.value) {
                                _controller.isLoading(
                                    true); // Set loading state to true
                                // await _controller.fetchFeatureProduct();
                                // Set loading state to false after fetching
                                Get.to(FeatureViewAllScreen());
                                print("22222222222");
                              }
                            },
                            child: _controller.isLoading.value
                                ? Container() // Show loading indicator if loading
                                : Text(
                                    'See All',
                                    style: secondaryBoldText,
                                  ),
                          ),
                        ],
                      );
                    }),
                  ),
                  FeatureProducts(
                    products: _controller.limitFeatureProductsModel.value
                            .limitfeaturedProductsList ??
                        [],
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 2.h, right: 2.h, bottom: 1.h, top: 1.h),
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Popular Products', style: headText),
                          GestureDetector(
                            onTap: () async {
                              if (!_controller.isLoading.value) {
                                _controller.isLoading(
                                    true); // Set loading state to true
                                // await _controller.fetchFeatureProduct();
                                // Set loading state to false after fetching
                                Get.to(PopularViewAllScreen());
                              }
                            },
                            child: _controller.isLoading.value
                                ? Container() // Show loading indicator if loading
                                : Text(
                                    'See All',
                                    style: secondaryBoldText,
                                  ),
                          ),
                        ],
                      );
                    }),
                  ),

                  PopularProduct(
                    products: _controller
                            .limitPopularProducts.value.popularproductList ??
                        [],
                  ),
                  // SizedBox(height: 2.h),
                  // Padding(
                  //   padding:
                  //   EdgeInsets.only(left: 2.h, right: 2.h, bottom: 1.h),
                  //   child: Obx(() {
                  //     return Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text('All Products', style: headText),
                  //         GestureDetector(
                  //           onTap: () async {
                  //             if (!_controller.isLoading.value) {
                  //               _controller.isLoading(
                  //                   true); // Set loading state to true
                  //               // await _controller.fetchFeatureProduct();
                  //               // Set loading state to false after fetching
                  //               Get.to(FeatureViewAllScreen());
                  //             }
                  //           },
                  //           child: _controller.isLoading.value
                  //               ? Container()// Show loading indicator if loading
                  //               : Text(
                  //             'See All',
                  //             style: secondaryBoldText,
                  //           ),
                  //         ),
                  //       ],
                  //     );
                  //   }),
                  // ),
                  SizedBox(height: 2.h),
                  SizedBox(height: 4.h),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
