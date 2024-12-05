import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/product/screens/products_screen.dart';
import 'package:sugar_cake/Features/whishlist/screen/Components/food_cart.dart';

import '../../../../utils/api_constants.dart';
import '../../model/limit_popular_products.dart';

class PopularProduct extends StatelessWidget {
  final List<PopularproductList>? products;

  PopularProduct({Key? key, this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h, right: 2.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500]!,
              blurRadius: 10.0,
              spreadRadius: 0.3,
              offset: const Offset(
                3.0,
                3.0,
              ),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: [
              if (products != null && products!.isNotEmpty)
                for (final products in products!)
                  Material(
                      child: InkWell(
                    onTap: () {
                      Get.to(
                        ProductsScreen(
                          pid: products.productId!.toString(),
                        ),
                      );
                    },
                    child: FoodCard(
                      image: ApiConstant.BASE_imgUrl +
                          products.imageurl.toString(),
                      name: products.productname.toString(),
                      strikePrice: products.offerprice.toString(),
                      price: products.price.toString(),
                      isFavorite: products.iswishlist.toString(),
                      pid: products.productId.toString(),
                      rating: (products.rating?.toString() ?? '4').substring(0,
                          min(4, (products.rating?.toString() ?? '4').length)),
                    ),
                  )),
              if (products == null || products!.isEmpty)
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      child: Image.asset(
                        'Assets/images/noData.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text("No Featured Product"),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
