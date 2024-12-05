import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/Features/profile/controller/address_controller.dart';
import 'package:sugar_cake/utils/init_screen.dart';
import '../../../utils/app_constant.dart';
import '../model/get_address_list_model.dart';
import 'Components/address_list_widget.dart';
import 'confirm_location_screen.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  final AddressController controller = Get.put(AddressController());

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
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.h, right: 2.h, top: 2.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAll(InitScreen());
                          },
                          child: Material(
                            elevation: 2,
                            shape: const CircleBorder(),
                           child: Container(
                            width: 35,
                            height: 35,
                            color: Colors.transparent,
                            child: Icon(
                              Icons.arrow_back_ios_new_sharp,
                              size: 22,
                              color: kPrimaryColor,
                            ),
                          ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Address",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
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
                              Get.to(ConfirmLocationScreen());
                            },
                            child: Row(
                              children: [
                                const Icon(
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
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: AddressListWidget(
                                              addressas:
                                                  address.addressas ?? '',
                                              address: address.address ?? '',
                                              floor: address.floor ?? '',
                                              landmark: address.landmark ?? '',
                                              phoneNumber:
                                                  address.contact ?? '',
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                  onTap: () {
                                                    Get.dialog(
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        40),
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          20),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        20.0),
                                                                child: Material(
                                                                  child: Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      const Text(
                                                                        "Delete",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              15),
                                                                      const Text(
                                                                        "Are you sure want to delete",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      //Buttons
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                ElevatedButton(
                                                                              child: const Text(
                                                                                'NO',
                                                                              ),
                                                                              style: ElevatedButton.styleFrom(
                                                                                foregroundColor: const Color(0xFFFFFFFF),
                                                                                minimumSize: const Size(0, 45),
                                                                                backgroundColor: Colors.amber,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                              ),
                                                                              onPressed: () {
                                                                                Get.back();
                                                                              },
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                          Expanded(
                                                                            child:
                                                                                ElevatedButton(
                                                                              child: const Text(
                                                                                'YES',
                                                                              ),
                                                                              style: ElevatedButton.styleFrom(
                                                                                foregroundColor: const Color(0xFFFFFFFF),
                                                                                backgroundColor: Colors.amber,
                                                                                minimumSize: const Size(0, 45),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                              ),
                                                                              onPressed: () async {
                                                                                await controller.deleteAddress(address.addressid ?? 0);
                                                                                controller.getAddressList();
                                                                                Get.forceAppUpdate();
                                                                                Get.back();
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ))),
                                        ],
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
