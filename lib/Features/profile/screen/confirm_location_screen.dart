import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/add_button.dart';
import '../../../Widgets/richText_widget.dart';
import '../../../Widgets/textFormField_widget.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/text_constant.dart';
import '../controller/address_controller.dart';
import '../controller/profile_controller.dart';

import 'Components/google_map.dart';
import 'Components/orderfor_widget.dart';
import 'adress_screen.dart';

class ConfirmLocationScreen extends StatelessWidget {
  ConfirmLocationScreen({super.key});

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
                          elevation: 3,
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
                        "Confirm Location",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 3.h, right: 3.h, top: 2.5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderWidgetForWidget(
                                addresscategory: weightCategories,
                                orderfor: '',
                                onRadioButtonSelected: (data) {
                                  selectedRadioButtonData = data;
                                },
                                onRawChipSelected: (data) {
                                  selectedRawChipData = data;
                                  // Store selected raw chip data
                                },
                              ),
                              SizedBox(height: 2.h),
                              SizedBox(
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
                                readonly: true,
                                controller: _completeAddressController,
                                hinttext: 'Select address from map',
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select a address from map';
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
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your number';
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
                                    if (selectedRadioButtonData == '' ||
                                        selectedRawChipData == '') {
                                      // Show custom snackbar if selectedRadioButtonData and selectedRawChipData are null
                                      Get.snackbar(
                                        "Choose Address",
                                        "Please choose an address type",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.transparent,
                                        colorText: Colors.black,
                                        duration: const Duration(seconds: 3),
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
                                      Get.offAll(AddAddressScreen());
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
