import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/orders/screen/order_byid_screen.dart';

import '../../../utils/app_constant.dart';
import '../controller/order_controller.dart';
import '../model/order_model.dart';
import 'components/orderList_widget.dart';

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});

  final OrderController controller = Get.put(OrderController());

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
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Show UI when loading is complete
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.h, right: 2.h),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
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
                        ],
                      ),
                      const Spacer(),
                      Text(
                        "My Orders",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Obx(() {
                  final List<Orderdetail>? orderList =
                      controller.getOrder.value.orderdetails;

                  return orderList != null && orderList.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(left: 2.h, right: 2.h),
                          child: Column(
                            children: [
                              for (final order in orderList)
                                InkWell(
                                  onTap: () {
                                    Get.to(OrderByIdScreen(
                                        orderid: order.id.toString() ?? '',
                                        orderNo:
                                            order.orderNo.toString() ?? ''));
                                  },
                                  child: OrderListWidget(
                                    orderid: order.orderNo.toString() ?? '',
                                    date: order.deliveryDate.toString() ?? '',
                                    time: order.deliveryTime.toString() ?? '',
                                    status: order.status.toString() ?? '',
                                    rating: order.rating ?? 4,
                                  ),
                                ),
                              SizedBox(
                                height: 2.h,
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
                            const Text("No order list"),
                          ],
                        );
                }),
              ],
            ),
          );
        }
      }),
    )));
  }
}
