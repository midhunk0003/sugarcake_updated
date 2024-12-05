import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/product/screens/products_screen.dart';
import '../../../utils/api_constants.dart';
import '../../../utils/app_constant.dart';
import '../controller/whishlist_controller.dart';
import '../model/get_whishlist_model.dart';
import 'Components/food_cart_whishlist.dart';

class WhishListScreen extends StatelessWidget {
  WhishListScreen({
    super.key,
  });

  final WhishListController controller = Get.put(WhishListController());
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(body: SafeArea(
      child: Obx(() {
        // if (controller.isLoading.value) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // } else {
          final List<WishlistList>? products =
              controller.getWhislistModel.value.wishlistList;

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
                    final List<WishlistList>? displayedProducts =
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
                                // Center(
                                //   child: Text(
                                //     "Found " +
                                //         displayedProducts.length.toString() +
                                //         " results",
                                //     style: TextStyle(
                                //         fontSize: 20.sp, fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                for (final product in displayedProducts)
                                  Material(
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(
                                          ProductsScreen(
                                            pid: product.id!.toString(),
                                          ),
                                        );
                                      },
                                      child: FoodCardWhishlist(
                                        image: ApiConstant.BASE_imgUrl +
                                            product.imageurl.toString(),
                                        name: product.productname.toString(),
                                        strikePrice:
                                            product.offerprice.toString(),
                                        price: product.price.toString(),
                                        pid: product.id.toString(),
                                        rating: (product.rating?.toString() ??
                                                '')
                                            .substring(
                                                0,
                                                min(
                                                    4,
                                                    (product.rating
                                                                ?.toString() ??
                                                            '')
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
    ));
  }
}
