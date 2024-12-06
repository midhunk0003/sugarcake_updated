import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/cart/controller/cart_controller.dart';
import 'package:sugar_cake/Features/cart/screens/components/address_widget.dart';

import '../../../utils/api_constants.dart';
import '../../../utils/app_constant.dart';
import '../controller/checkout_controller.dart';
import '../model/GetCartModel.dart';
import 'cart_screen.dart';
import 'components/address_select.dart';
import 'components/checkout_product_widget.dart';
import 'components/grand_total_screen.dart';

class CheckOutScreen extends StatelessWidget {
  final String? addressas;
  final String? address;
  final String? id;
  final String? landmark;
  final String? floor;
  final String time;
  final String date;
  final String? phoneNumber;

  CheckOutScreen({
    Key? key,
    this.addressas,
    this.address,
    this.id,
    this.landmark,
    this.floor,
    required this.time,
    required this.date,
    this.phoneNumber,
  }) : super(key: key);

  final CartController controller = Get.find<CartController>();
  final ChekOutController myController = Get.put(ChekOutController());
  final RxBool selfPickup = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isButtonDisabled = false.obs;

  double _calculateDeliveryCharge(double offerPrice) {
    if (selfPickup.value) {
      return 0.0;
    } else if (offerPrice < 100) {
      return 20.0;
    } else {
      return 30.0;
    }
  }

  Future<void> _placeOrder() async {
    if (!isButtonDisabled.value) {
      if (address == null && !selfPickup.value) {
        Get.snackbar(
          'Validation Error',
          'Please select a delivery address or choose self-pickup.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isButtonDisabled.value = true; // Disable button
      isLoading.value = true; // Start loading

      try {
        print("qqqqqqqqqqqqqqqq");
        final cartDetails = controller.getCartModel.value!.cartDetails!;
        print("$cartDetails");
        final productarraylist = cartDetails.map((product) {
          return {
            "productname": product.productname ?? '',
            // "preparationtime": product.preparationtime ?? '',
            "productid": product.productid?.toString() ?? '',
            "categoryname": product.categoryName ?? '',
            "categoryid": product.categoryid?.toString() ?? '',
            "quantity": product.quantity?.toString() ?? '',
            "weightid": product.weightid?.toString() ?? '',
            "weight": product.weight ?? '',
            "flavoursid": product.flavoursid?.toString() ?? '',
            "flavoursname": product.flavoursname ?? '',
            "amount": product.price?.toString() ?? '',
            "status": "cod",
            "note": product.note ?? '',
          };
        }).toList();

        final double offerPrice = double.parse(
            controller.getCartModel.value!.offerPrice?.toString() ?? '0');
        final double deliveryCharge = _calculateDeliveryCharge(offerPrice);

        await myController.addOrder(
          deliveryCharge.toString(), // delivery charge
          controller.getCartModel.value!.totalPrice?.toString() ?? '',
          cartDetails.length.toString(),
          id.toString(),
          date.toString(),
          time.toString(),
          address == null ? 'Yes' : 'No',
          productarraylist,
        );

        // Navigate to success screen
      } catch (e) {
        // Handle error
        print('Error placing order: $e');
        // Optionally show an error message
        Get.snackbar(
          'Error',
          'Failed to place order. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false; // Stop loading
        isButtonDisabled.value = false; // Re-enable button
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 1.5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.h),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.offAll(const CartScreen());
                              },
                              child: Material(
                                elevation: 2,
                                shape: const CircleBorder(),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  color: Colors.transparent,
                                  child: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    size: 3.h,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Checkout",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 4.h, bottom: .6.h, top: 2.h),
                        child: InkWell(
                          onTap: () {
                            Get.to(AddressWidget(date: date, time: time));
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: kSecondaryColor,
                              ),
                              Text(
                                address != null
                                    ? "  Change delivery address"
                                    : "  Add delivery address",
                                style: secondaryBoldText,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (address != null)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AddressSelectWidget(
                                addressas: addressas.toString(),
                                address: address.toString(),
                                floor: floor.toString(),
                                landmark: landmark.toString(),
                                id: id.toString(),
                                phoneNumber: phoneNumber.toString(),
                                date: date,
                                time: time,
                              ),
                            ),
                          ],
                        ),
                      if (address == null)
                        Padding(
                          padding: EdgeInsets.only(left: 3.h),
                          child: Row(
                            children: [
                              Obx(() {
                                return Radio(
                                  value: true,
                                  groupValue: selfPickup.value,
                                  onChanged: (value) {
                                    selfPickup.value = value as bool;
                                  },
                                );
                              }),
                              Text('Self Pickup'),
                            ],
                          ),
                        ),
                      // Render cart items
                      Obx(() {
                        List<CartDetail>? products =
                            controller.getCartModel.value.cartDetails;

                        return products != null && products.isNotEmpty
                            ? Column(
                                children: [
                                  for (final product in products)
                                    CheckoutItem(
                                      image: ApiConstant.BASE_imgUrl +
                                          (product.imageurl ?? ''),
                                      name: product.productname ?? '',
                                      weight: product.weight.toString() ?? '',
                                      price: product.price.toString() ?? '',
                                      flavour: product.flavoursname ?? '',
                                      addNote: product.note ?? '',
                                      category:
                                          product.categoryName.toString() ?? '',
                                      quantity: product.quantity.toString(),
                                    ),
                                  SizedBox(height: 2.h),
                                  // Render BottomBar widget
                                  Obx(() {
                                    final double offerPrice = double.parse(
                                        controller.getCartModel.value.offerPrice
                                                ?.toString() ??
                                            '0');
                                    final double deliveryCharge =
                                        _calculateDeliveryCharge(offerPrice);

                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Delivery charge"),
                                              Text(address == null
                                                  ? "0"
                                                  : deliveryCharge.toString()),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("total"),
                                              Text(controller
                                                  .getCartModel.value.totalPrice
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: GrandTotalScreen(
                                            cartFct: _placeOrder,
                                            strikePrice: controller.getCartModel
                                                    .value.offerPrice
                                                    ?.toString() ??
                                                '',
                                            price: (address == null
                                                    ? controller.getCartModel
                                                        .value.totalPrice
                                                        ?.toString()
                                                    : double.parse(controller
                                                                .getCartModel
                                                                .value
                                                                .totalPrice
                                                                ?.toString() ??
                                                            '0') +
                                                        deliveryCharge)
                                                .toString(),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                  SizedBox(height: 3.h),
                                ],
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
                                  const Text("No cart Product"),
                                ],
                              );
                      }),
                    ],
                  ),
                );
              }
            }),
            Obx(() {
              if (isLoading.value) {
                return Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Container(); // Return an empty container when not loading
              }
            }),
          ],
        ),
      ),
    );
  }
}
