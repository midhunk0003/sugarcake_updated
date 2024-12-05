import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/product/screens/products_screen.dart';
import '../../../../utils/api_constants.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/init_screen.dart';
import '../../controller/category_list_controller.dart';

import '../../model/get_category_list_model.dart';
import 'category_list_food_widget.dart';

class CategoryListScreen extends StatelessWidget {
  final String cid;

  CategoryListScreen({
    super.key,
    required this.cid,
  });

  final searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            // logic
          },
          child: Obx(() {
            final CategoryListController myController =
            Get.put(CategoryListController(cid: cid.toString()));
            if (myController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final List<Productlist>? products =
                  myController.getCategoryListModel.value.productlist;

              if (products == null || products.isEmpty) {
                // Show a message indicating no products found
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 3.h,top: 3.h),
                      child: InkWell(
                        onTap: () async {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 4.h,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
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
                      ),
                    ),
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
                            InkWell(
                              onTap: () async {
                                myController.searchBool.value = false;
                                Get.offAll(const InitScreen());
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 4.h,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: .6.h,
                            ),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onChanged: (value) {
                                  myController.filterSearch(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
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
                                myController.searchBool.value = false;
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
                        final List<Productlist>? displayedProducts =
                            myController.searchBool.value
                                ? myController.categoryList
                                : products;

                        return displayedProducts != null &&
                                displayedProducts.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: StaggeredGrid.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Found " +
                                            displayedProducts.length
                                                .toString() +
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
                                            Get.to(
                                              ProductsScreen(
                                                pid: product.id!.toString(),
                                              ),
                                            );
                                          },
                                          child: CategoryListFoodCard(
                                            image: ApiConstant.BASE_imgUrl +
                                                (product.imageurl ?? ''),
                                            name: product.productname ?? '',
                                            strikePrice: product.offerprice
                                                    ?.toString() ??
                                                '',
                                            price:
                                                product.price?.toString() ?? '',
                                            isFavorite: product.iswishlist
                                                    ?.toString() ??
                                                '',
                                            pid: product.id?.toString() ?? '',
                                            rating:  (product.rating != null && product.rating != '' )
                                                ? (product.rating!.toString().substring(
                                                0,
                                                min(
                                                    4,
                                                    product.rating!.toString().length)))
                                                : '4',
                                            cid:product.categoryId?.toString() ?? '',
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
            }
          }),
        ),
      ),
    );
  }
}