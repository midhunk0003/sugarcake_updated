import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/orders/model/order_byid_model.dart';
import 'package:sugar_cake/utils/app_constant.dart';
import '../controller/orderbyid_controller.dart';

import 'components/order_byid_fields.dart';

class OrderByIdScreen extends StatelessWidget {
  final String orderid;
  final String orderNo;

  OrderByIdScreen({super.key, required this.orderid, required this.orderNo});

  late final OrderByIdController controller =
      Get.put(OrderByIdController(orderid: orderid));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Show UI when loading is complete
            final List<Orderdetail>? products =
                controller.getOrderById.value.orderdetails;

            if (products == null || products.isEmpty) {
              // Show a message indicating no products found
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 3.h, top: 3.h),
                    child: InkWell(
                      onTap: () async {
                        Get.back();
                      },
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
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 3.h, right: 3.h, top: 3.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                            "Order Details",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Id: $orderNo",
                            style: normalText,
                          ),
                          const Spacer(),
                          Container(
                            color: Colors.grey[200],
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.event_note_outlined),
                                  Text("Download invoice"),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey[200],
                      ),
                      Text(
                        controller.getOrderById.value.orderdetails![0].status
                            .toString(),
                        style: headPrimaryText,
                      ),
                      Divider(
                        color: Colors.grey[200],
                      ),
                      Text(
                        "Your order",
                        style: normalText,
                      ),
                      Obx(() {
                        final List<Itemlist>? orderList =
                            controller.getOrderById.value.itemlist;

                        return orderList != null && orderList.isNotEmpty
                            ? Column(
                                children: [
                                  for (final order in orderList)
                                    OrderByIdComponents(
                                        orderid: orderNo,
                                        date: order.deliveryDate.toString(),
                                        status: order.status.toString(),
                                        weight: order.weight.toString(),
                                        name: order.productName.toString(),
                                        quantity: order.quantity.toString(),
                                        price: order.price.toString(),
                                        flavoursename:
                                            order.flavoursName.toString(),
                                        note: order.note.toString()),
                                  SizedBox(
                                    height: 2.h,
                                  ),
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
                                  const Text("No order list"),
                                ],
                              );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Tax",
                              //   style: smallText,
                              // ),
                              SizedBox(
                                height: .8.h,
                              ),
                              Text(
                                "Delivery charge",
                                style: smallText,
                              ),
                              Text(
                                "Grand total",
                                style: normalText,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Text(
                              //   "AED 10",
                              //   style: smallText,
                              // ),
                              Text(
                                "AED ${controller.getOrderById.value.orderdetails![0].deliveryCharge.toString()}",
                                style: smallText,
                              ),
                              Text(
                                "AED ${controller.getOrderById.value.orderdetails![0].total.toString()}",
                                style: normalText,
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey[200],
                      ),
                      Text(
                        "Order details",
                        style: normalText,
                      ),
                      Text(
                        "ORDER NUMBER",
                        style: smallText,
                      ),
                      Text(
                        orderNo,
                        style: normalText,
                      ),
                      Text(
                        "PAYMENT",
                        style: smallText,
                      ),
                      Text(
                        controller
                            .getOrderById.value.orderdetails![0].paymentType
                            .toString(),
                        style: normalText,
                      ),
                      Text(
                        "DATE",
                        style: smallText,
                      ),
                      Text(
                        controller
                            .getOrderById.value.orderdetails![0].orderedDate
                            .toString(),
                        style: normalText,
                      ),
                      Text(
                        "PHONE NUMBER",
                        style: smallText,
                      ),
                      Text(
                        controller.getOrderById.value.orderdetails![0].contact
                            .toString(),
                        style: normalText,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Divider(
                        color: Colors.grey[200],
                      ),
                      Text(
                        "Delivery to",
                        style: normalText,
                      ),
                      Text(
                        controller.getOrderById.value.orderdetails![0].address
                            .toString(),
                        style: smallText,
                      )
                    ],
                  ),
                ),
              );
            }
          }
        }),
      ),
    );
  }
}
