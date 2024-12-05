import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';

import '../../../../Widgets/add_button.dart';
import '../../../../Widgets/richText_widget.dart';
import '../../../../Widgets/textFormField_widget.dart';
import '../../../../utils/text_constant.dart';
import '../../../profile/controller/address_controller.dart';
import '../../../profile/controller/profile_controller.dart';
import '../../../profile/screen/Components/google_map.dart';
import '../../../profile/screen/Components/orderfor_widget.dart';
import 'address_widget.dart';

class AddressFieldScreen extends StatelessWidget {
  final String date;
  final String time;
  AddressFieldScreen({super.key, required this.date, required this.time});

  final ProfileController controller = Get.find<ProfileController>();
  final AddressController addController = Get.find<AddressController>();

  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _completeAddressController =
      TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> weightCategories = ['home', 'work', 'hotel', 'others'];
  String selectedRadioButtonData = '';
  String selectedRawChipData = '';
  late String logitude;
  late String latitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            // logic
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                          "Confirm Location",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 3.h, right: 3.h, top: 2.5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrderWidgetForWidget(
                              addresscategory: weightCategories,
                              orderfor: '',
                              onRadioButtonSelected: (data) {
                                selectedRadioButtonData = data;
                                print(selectedRadioButtonData);
                              },
                              onRawChipSelected: (data) {
                                selectedRawChipData = data;
                                // Store selected raw chip data
                              },
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              height: 400, // Adjust the height as needed
                              child: DeliveryMapView(
                                onLocationSelected:
                                    (isInDeliveryArea, location, address) {
                                  _completeAddressController.text =
                                      address ?? '';
                                  latitude = location != null
                                      ? location.latitude.toString()
                                      : '';
                                  logitude = location != null
                                      ? location.longitude.toString()
                                      : '';
                                },
                              ),
                            ),
                            const TextWidget(
                              text: 'Complete address',
                              size: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 1.h),
                            TextFormFieldWidget(
                              controller: _completeAddressController,
                              hinttext: 'Enter your complete address',
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 1.3.h),
                            const TextWidget(
                              text: 'Floor',
                              size: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 1.h),
                            TextFormFieldWidget(
                              controller: _floorController,
                              hinttext: 'Enter your floor',
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please floor';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 1.3.h),
                            const TextWidget(
                              text: 'landmark',
                              size: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 1.h),
                            TextFormFieldWidget(
                              controller: _landmarkController,
                              hinttext: 'Nearby lanmark(optional)',
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 1.3.h),
                            const TextWidget(
                              text: 'Contact number',
                              size: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 1.h),
                            TextFormFieldWidget(
                              controller: _contactController,
                              hinttext: 'Phone number',
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 1.3.h),
                            const TextWidget(
                              text: 'Apartment No',
                              size: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 1.h),
                            TextFormFieldWidget(
                              controller: _zipcodeController,
                              hinttext: 'Enter apartment no',
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 2.h),
                            Obx(
                              () => Row(
                                children: [
                                  Checkbox(
                                    value: addController.isChecked.value,
                                    onChanged: (value) {
                                      addController
                                          .toggleCheckbox(value ?? false);
                                    },
                                  ),
                                  RichTextWidget(
                                    text1: 'make this is my ',
                                    text2: 'default address',
                                    fct: () {},
                                  ),
                                ],
                              ),
                            ),
                            AddButton(
                              fct: () async {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  print(
                                      "Selected radio button data: $selectedRadioButtonData");
                                  print(
                                      "Selected raw chip data: $selectedRawChipData");

                                  if (selectedRadioButtonData == '' ||
                                      selectedRawChipData == '') {
                                    // Show custom snackbar if selectedRadioButtonData and selectedRawChipData are null
                                    Get.snackbar(
                                      "Choose Address",
                                      "Please choose an address type",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.transparent,
                                      colorText: Colors.black,
                                      duration: Duration(seconds: 3),
                                    );
                                  } else {
                                    // Proceed with adding the address if both are not null
                                    await controller.addAddress(
                                        selectedRadioButtonData.toString(),
                                        selectedRawChipData.toString(),
                                        _completeAddressController.text,
                                        _floorController.text,
                                        _landmarkController.text,
                                        _contactController.text,
                                        addController.isChecked.value
                                            ? "yes"
                                            : "no",
                                        _zipcodeController.text,
                                        logitude,
                                        latitude);

                                    await addController.getAddressList();
                                    Get.to(AddressWidget(
                                      date: date,
                                      time: time,
                                    ));
                                  }
                                }
                              },
                              text: 'Save address',
                            ),
                            SizedBox(height: 2.h),
                          ],
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
    );
  }
}



//
// Get.to(AddressWidget(date: date,time:time ,));