import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/explore/controller/explore_controller.dart';
import 'package:sugar_cake/Features/product/screens/products_screen.dart';
import 'package:sugar_cake/Features/whishlist/screen/Components/food_cart.dart';

import '../../../utils/api_constants.dart';
import '../../../utils/app_constant.dart';
import '../model/get_explore_list_model.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({
    super.key,
  });

  final ExploreController controller = Get.put(ExploreController());
  final searchController = TextEditingController();

  Future<void> _refreshData() async {
    await controller.getExploreModel();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Scaffold(body: SafeArea(
        child: Obx(() {
          final List<ProductDetail>? products =
              controller.getExploreModel.value.productDetails;

          if (products == null || products.isEmpty) {
            // Show a message indicating no products found
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: Image.asset(
                      'Assets/images/noData.png',
                      fit: BoxFit.cover,
                      height: 30.h,
                    ),
                  ),
                ),
                const Text("No Whishlist product"),
              ],
            );
          } else {
            // Show products
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 3.5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              controller.filterSearch(value);
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              hintText: "Search here...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 22,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            searchController.clear();
                            controller.searchBool.value = false;
                          },
                          child: Container(
                            width: 48.00,
                            height: 48.00,
                            decoration: const BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Icon(
                              Icons.filter_list,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Obx(() {
                    final List<ProductDetail>? displayedProducts =
                        controller.searchBool.value
                            ? controller.wishlistList
                            : products;

                    return displayedProducts != null &&
                            displayedProducts.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: StaggeredGrid.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              children: [
                                Center(
                                  child: Text(
                                    "Found " +
                                        displayedProducts.length.toString() +
                                        " results",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                for (final product in displayedProducts)
                                  Material(
                                    child: InkWell(
                                      onTap: () {
                                        // print("qwe");
                                        Get.to(
                                          ProductsScreen(
                                            pid: product.id!.toString(),
                                          ),
                                        );
                                      },
                                      child: FoodCard(
                                        image: ApiConstant.BASE_imgUrl +
                                            (product.imageurl ?? ''),
                                        name: product.productname ?? '',
                                        strikePrice:
                                            product.offerprice?.toString() ??
                                                '',
                                        price: product.price?.toString() ?? '',
                                        isFavorite:
                                            product.iswishlist?.toString() ??
                                                '',
                                        pid: product.id?.toString() ?? '',
                                        rating: (product.rating?.toString() ??
                                                '4')
                                            .substring(
                                                0,
                                                min(
                                                    4,
                                                    (product.rating
                                                                ?.toString() ??
                                                            '4')
                                                        .length)),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[200],
                                ),
                                child: Image.asset(
                                  'Assets/images/noData.png',
                                  fit: BoxFit.cover,
                                  height: 30.h,
                                ),
                              ),
                              const Text("No product list"),
                            ],
                          );
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          }
          // }
        }),
      )),
    );
  }
}
