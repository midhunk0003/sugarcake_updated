import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/profile/controller/address_controller.dart';

import '../../../../utils/app_constant.dart';
import '../../../profile/model/get_address_list_model.dart';
import 'address_field.dart';
import 'address_select.dart';

class AddressWidget extends StatelessWidget {
  final String date;
  final String time;
  AddressWidget({
    super.key,
    required this.date,
    required this.time,
  });

  final AddressController controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Show UI when loading is complete
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.h, right: 2.h, top: 2.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Material(
                            elevation: 2,
                            shape: CircleBorder(),
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
                        Spacer(),
                        Text(
                          "Address",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3.h, right: 3.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, bottom: 4.h),
                          child: InkWell(
                            onTap: () {
                              Get.to(AddressFieldScreen(
                                date: date,
                                time: time,
                              ));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: kSecondaryColor,
                                ),
                                Text(
                                  "  Add Address",
                                  style: secondaryBoldText,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(() {
                          final List<AddressList>? addressList =
                              controller.getAddressListModel.value.addressList;

                          return addressList != null && addressList.isNotEmpty
                              ? Column(
                                  children: [
                                    for (final address in addressList)
                                      AddressSelectWidget(
                                        addressas: address.addressas ?? '',
                                        address: address.address ?? '',
                                        floor: address.floor ?? '',
                                        landmark: address.landmark ?? '',
                                        phoneNumber: address.contact ?? '',
                                        id: address.addressid.toString() ?? '',
                                        date: date.toString(),
                                        time: time.toString(),
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
                                    const Text("address not found"),
                                  ],
                                );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
