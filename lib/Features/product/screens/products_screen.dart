import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/product/screens/Components/product_components.dart';
import 'package:sugar_cake/Features/product/screens/Components/product_price.dart';
import 'package:sugar_cake/Features/product/screens/Components/product_weightFlavour.dart';
import 'package:sugar_cake/Features/whishlist/screen/fav_screen.dart';
import 'package:sugar_cake/utils/app_constant.dart';
import '../../../utils/api_constants.dart';
import '../../cart/screens/cart_screen.dart';
import '../controller/product_byid_controller.dart';

class ProductsScreen extends StatelessWidget {
  static String routeName = "/prductsScreen";
  final String pid;
  RxString selectedWeightPrice = RxString("0.0");
  RxString selectedWeightid = RxString('');
  RxString selectedFlavourId = RxString("0.0");
  RxString notesText = RxString("");

  ProductsScreen({super.key, required this.pid});

  @override
  Widget build(BuildContext context) {
    final ProductByIdController controller =
        Get.put(ProductByIdController(pid: pid.toString()));
    controller.getProductByIdModel();

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Obx(() {
        final getProductByIdModel = controller.getProductByIdModel.value;
        print("jjjjjjjjjjjjjjjjjjj${getProductByIdModel.productDetails}");
        if (getProductByIdModel.productDetails == null ||
            // getProductByIdModel.flavours == null ||
            getProductByIdModel.weights == null ||
            getProductByIdModel.imagelist == null ||
            getProductByIdModel.productDetails!.isEmpty ||
            // getProductByIdModel.flavours!.isEmpty ||
            getProductByIdModel.imagelist!.isEmpty ||
            getProductByIdModel.weights!.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductsComponent(
                  cartFct: () {
                    Get.to(const CartScreen());
                  },
                  favFct: () {
                    Get.to(WhishListScreen());
                  },
                  image: ApiConstant.BASE_imgUrl +
                      controller
                          .getProductByIdModel.value.productDetails![0].imageurl
                          .toString(),
                  categoryName: controller
                      .getProductByIdModel.value.productDetails![0].categoryname
                      .toString(),
                  rating: (controller.getProductByIdModel.value
                              .productDetails![0].rating
                              ?.toString() ??
                          '4')
                      .substring(
                          0,
                          min(
                              4,
                              (controller.getProductByIdModel.value
                                          .productDetails![0].rating
                                          ?.toString() ??
                                      '4')
                                  .length)),
                  productName: controller
                      .getProductByIdModel.value.productDetails![0].productname
                      .toString(),
                  discription: controller
                      .getProductByIdModel.value.productDetails![0].description
                      .toString(),
                  preparationtime: controller.getProductByIdModel.value
                      .productDetails![0].preparationtime
                      .toString(),
                  additionalImages: [
                    for (var imageUrl in [
                      controller
                          .getProductByIdModel.value.imagelist?[0].imageurl1,
                      controller
                          .getProductByIdModel.value.imagelist?[0].imageurl2,
                      controller
                          .getProductByIdModel.value.imagelist?[0].imageurl3,
                      controller
                          .getProductByIdModel.value.imagelist?[0].imageurl4,
                    ])
                      if (imageUrl != null)
                        ApiConstant.BASE_imgUrl + imageUrl.toString(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.h, bottom: 1.h),
                  child: Text(
                    'Select Weight',
                    style: headText,
                  ),
                ),
                ProductWeightFlavour(
                  weightCategories:
                      controller.getProductByIdModel.value.weights != null
                          ? controller.getProductByIdModel.value.weights!
                              .map((weight) => weight.weight.toString())
                              .toList()
                          : [],
                  flavours:
                      controller.getProductByIdModel.value.flavours != null
                          ? controller.getProductByIdModel.value.flavours!
                              .map((flavour) => flavour.flavoursname.toString())
                              .toList()
                          : [],
                  flavourId:
                      controller.getProductByIdModel.value.flavours != null
                          ? controller.getProductByIdModel.value.flavours!
                              .map((flavour) => flavour.id.toString())
                              .toList()
                          : [],
                  onWeightSelected: (selectedWeight) {
                    final selectedWeightIndex = controller
                        .getProductByIdModel.value.weights!
                        .indexWhere((weight) =>
                            weight.weight.toString() == selectedWeight);
                    if (selectedWeightIndex != -1) {
                      final selectedPrice = controller.getProductByIdModel.value
                          .weights![selectedWeightIndex].price;
                      selectedWeightPrice.value = selectedPrice!;
                      final selectid = controller.getProductByIdModel.value
                          .weights![selectedWeightIndex].id;
                      selectedWeightid.value = selectid.toString();
                    }
                  },
                  onFlavorSelected: (selectedFlavourId) {
                    this.selectedFlavourId.value = selectedFlavourId;
                  },
                  onNotesChanged: (text) {
                    // Update the notes text when it changes
                    notesText.value = text;
                  },
                ),
              ],
            ),
          );
        }
      }),
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
        child: Obx(() {
          return Container(
              height: 80.0,
              color: Colors.white,
              child: ProductPrice(
                cartFct: () async {
                  // Check if any value is null
                  if (selectedFlavourId.value.isEmpty ||
                      selectedWeightid.value.isEmpty ||
                      selectedWeightPrice.value.isEmpty ||
                      notesText.value.isEmpty ||
                      selectedFlavourId.value == '0.0') {
                    // Show snackbar if any value is null
                    Get.snackbar(
                      "Error",
                      "Please enter all values",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    print("123");
                    // All values are present, proceed with adding to cart
                    await controller.addToCart(
                      selectedFlavourId.value,
                      '1', // Assuming the quantity is always 1 for now
                      selectedWeightid.value,
                      notesText.value,
                      selectedWeightPrice.value,
                      controller.getProductByIdModel.value.productDetails![0]
                          .categoryid
                          .toString(),
                      controller.getProductByIdModel.value.productDetails![0]
                          .preparationtime
                          .toString(),
                    );
                    // print(selectedFlavourId.value);
                    // Get.to(
                    //   const CartScreen(),
                    // );
                  }
                },
                strikePrice: '',
                price: 'AED $selectedWeightPrice'.toString(),
              ));
        }),
      ),
    );
  }
}
