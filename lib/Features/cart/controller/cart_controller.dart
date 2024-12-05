import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_cake/Features/cart/screens/cart_screen.dart';

import 'package:sugar_cake/Features/success%20response/response_model.dart';
import 'package:sugar_cake/utils/init_screen.dart';

import '../../../Widgets/snackbar_messeger.dart';
import '../model/GetCartModel.dart';
import '../rep/cart_repository.dart';

class CartController extends GetxController {
  var isLoading = true.obs;
  final CartRepository _cartRepository = CartRepository();
  Rx<GetCartModel> getCartModel = GetCartModel().obs;
  Rx<ResponseModel> responseModel = ResponseModel().obs;

  // final String pid;
  RxBool refreshPage = false.obs;

  var selectedTime = TimeOfDay.now().obs;
  var selectedDate = DateTime.now().obs;

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2028),
      helpText: 'Select delivery date',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'Select delivery date',
      fieldHintText: 'Month/Date/Year',
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

  chooseTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: const TimeOfDay(hour: 00, minute: 00),
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        },
        initialEntryMode: TimePickerEntryMode.input,
        helpText: 'Select Departure Time',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorInvalidText: 'Provide valid time',
        hourLabelText: 'Select Hour',
        minuteLabelText: 'Select Minute');

    if (pickedTime != null && pickedTime != selectedTime.value) {
      selectedTime.value = pickedTime;
    }
  }

  String formatTime(TimeOfDay time) {
    final hours = time.hourOfPeriod;
    final minutes = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hours:$minutes $period';
  }

  getCartList() async {
    try {
      isLoading(true);
      getCartModel.value = (await _cartRepository.getCartList())!;
      // print("${getCartModel.value}");
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false);
    }
  }

  updateProduct(String pid, String type) async {
    try {
      responseModel.value = (await _cartRepository.updateQuantity(pid, type))!;
      getCartList();
      if (responseModel.value.response == 'Success' &&
          responseModel.value.message == 'Quantity updated successfully') {
        SnackbarManager.showSuccessSnackbar(Get.context!, 'update order',
            responseModel.value.message.toString());
      } else if (responseModel.value.response == 'Success' &&
          responseModel.value.message == 'Deleted from cart') {
        SnackbarManager.showHelpSnackbar(Get.context!, 'update order',
            responseModel.value.message.toString());
        Get.delete<CartController>();
        Get.forceAppUpdate();
        if (getCartModel.value.cartDetails!.isEmpty) {
          getCartList();
        }
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getCartList();
    super.onInit();
  }
}
