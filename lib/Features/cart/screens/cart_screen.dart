import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/cart/controller/cart_controller.dart';
import 'package:sugar_cake/Features/cart/screens/checkout_screen.dart';
import 'package:sugar_cake/Features/cart/screens/components/bottombar.dart';
import 'package:sugar_cake/Features/cart/screens/components/cartlist_components.dart';
import 'package:sugar_cake/utils/app_constant.dart';
import 'package:sugar_cake/utils/init_screen.dart';

import '../../../utils/api_constants.dart';
import '../model/GetCartModel.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cartScreen";

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          // Check if loading
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: InkWell(
                            onTap: () {
                              Get.offAll(const InitScreen());
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_sharp,
                              size: 3.5.h,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "My Cart",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // Render cart items

                  Obx(() {
                    int? preLargTime;
                    List<CartDetail>? products =
                        controller.getCartModel.value.cartDetails;
                    List<String?>? preparationTimes = products
                            ?.map((cartDetail) => cartDetail.preparationtime)
                            .toList() ??
                        [];
                    print("ddddddddddddddddddd : ${preparationTimes!}");

                    List<int?> preparationNumbers =
                        preparationTimes.map((time) {
                      if (time != null) {
                        // Split the string by space and parse the first part as an integer
                        final parts = time.split(' ');
                        return int.tryParse(
                            parts[0]); // Convert the numeric part to int
                      }
                      return null;
                    }).toList();

                    print("Converted numbers: $preparationNumbers");
                    if (preparationNumbers.isNotEmpty) {
                      // Filter out null values and find the maximum
                      int? largestNumber = preparationNumbers
                          .where((number) => number != null)
                          .cast<int>()
                          .reduce((a, b) => a > b ? a : b);

                      print("The largest number is: $largestNumber");
                      preLargTime = largestNumber;
                    } else {
                      print("The list is empty or contains no valid numbers.");
                    }

                    // final prestringtime = ["30", "60", "25"];
                    // final largestNumber = prestringtime
                    //     .map(int.parse)
                    //     .reduce((a, b) => a > b ? a : b);

                    // print("The largest number is: $largestNumber");
                    return products != null && products.isNotEmpty
                        ? Column(
                            children: [
                              for (final product in products)
                                CartItem(
                                  image: ApiConstant.BASE_imgUrl +
                                      (product.imageurl ?? ''),
                                  name: product.productname ?? '',
                                  weight: product.weight.toString() ?? '',
                                  price: product.price.toString() ?? '',
                                  flavour: product.flavoursname ?? '',
                                  addNote: product.note ?? '',
                                  offerPrize:
                                      product.offerprice.toString() ?? '',
                                  id: product.productid.toString() ?? '',
                                  quatity: product.quantity.toString() ?? '',
                                  addfct: () async {
                                    await controller.updateProduct(
                                        product.id.toString(), "-");
                                    // controller.getCartList();
                                  },
                                  removefct: () async {
                                    await controller.updateProduct(
                                        product.id.toString(), "+");
                                    // controller.getCartList();
                                  },
                                  preprationTime:
                                      product.preparationtime.toString() ?? '',
                                ),
                              SizedBox(height: 2.h),

                              Text("Choose delivery date and time",
                                  style: normalText),

                              Padding(
                                padding: EdgeInsets.only(left: 3.h, top: 1.h),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.chooseDate();
                                      },
                                      child: Container(
                                        color: const Color(0xffEEF6FF),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.calendar_month),
                                                  SizedBox(
                                                    width: 2.h,
                                                  ),
                                                  Obx(() => Text(
                                                        controller.selectedDate
                                                                    .value !=
                                                                DateTime.now()
                                                            ? DateFormat(
                                                                    "dd/MM/yyyy")
                                                                .format(controller
                                                                    .selectedDate
                                                                    .value)
                                                                .toString()
                                                            : "Select Date", // Show "Select Date" if selectedDate is DateTime.now()
                                                      )),
                                                  SizedBox(width: .8.h),
                                                ],
                                              ),
                                              const Text(
                                                'select change date',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // print("123");
                                        controller.chooseTime();
                                        print(controller.selectedTime);
                                      },
                                      child: Container(
                                        color: const Color(0xffEEF6FF),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.access_time),
                                              SizedBox(
                                                width: .6.h,
                                              ),
                                              Obx(() => Text(
                                                    controller.selectedTime !=
                                                            TimeOfDay.now()
                                                        ? controller.formatTime(
                                                            controller
                                                                .selectedTime
                                                                .value)
                                                        : "Select Time", // Show "Select Time" if selectedTime is now
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 2.h),
                              // Render BottomBar widget
                              Container(
                                // height: 8.h,
                                color: Colors.white,
                                child: BottomBar(
                                  cartFct: () {
                                    // print("rrrrrrrrrrrrrrr : $}");
                                    final now = DateTime.now();
                                    final currentTimeInMinutes =
                                        now.hour * 60 + now.minute;

                                    // Get selected date and time
                                    final selectedDate =
                                        controller.selectedDate.value;
                                    final selectedTime =
                                        controller.selectedTime.value;
                                    final selectedTimeInMinutes =
                                        selectedTime.hour * 60 +
                                            selectedTime.minute;

                                    // Check if selected date is today
                                    final isToday = DateFormat("dd/MM/yyyy")
                                            .format(selectedDate) ==
                                        DateFormat("dd/MM/yyyy").format(now);

                                    // Validation logic
                                    if (controller.selectedTime.value ==
                                        TimeOfDay.now()) {
                                      Get.snackbar(
                                        'Alert',
                                        'Please select a time.',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    } else if (isToday &&
                                        selectedTimeInMinutes <
                                            currentTimeInMinutes +
                                                preLargTime!.toInt()) {
                                      Get.snackbar(
                                        'Alert',
                                        'Please select a time at least ${preLargTime} minutes from now.',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    } else {
                                      // If the date and time are valid, navigate to the checkout screen
                                      print(
                                          "Selected Time: ${controller.formatTime(controller.selectedTime.value)}");
                                      print(
                                          "Selected Date: ${DateFormat("dd/MM/yyyy").format(controller.selectedDate.value)}");

                                      Get.to(
                                        CheckOutScreen(
                                          addressas: '',
                                          time: controller.formatTime(
                                              controller.selectedTime.value),
                                          date: DateFormat("dd/MM/yyyy")
                                              .format(
                                                  controller.selectedDate.value)
                                              .toString(),
                                        ),
                                      );
                                    }
                                  },

                                  // Check if controller.getCartModel is not null before accessing its properties

                                  strikePrice: controller
                                          .getCartModel.value.offerPrice
                                          ?.toString() ??
                                      '',
                                  price: controller
                                          .getCartModel.value.totalPrice
                                          ?.toString() ??
                                      '',
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              )
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
      ),
    );
  }
}
