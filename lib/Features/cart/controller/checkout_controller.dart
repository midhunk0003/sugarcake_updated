import 'package:get/get.dart';

import '../../../Widgets/snackbar_messeger.dart';

import '../model/add_product_model.dart';
import '../rep/cart_repository.dart';
import '../screens/components/checkout_success_screen.dart';

class ChekOutController extends GetxController {
  var isLoading = true.obs;
  final CartRepository _cartRepository = CartRepository();
  Rx<AddProductModel> getResponseModel = AddProductModel().obs;

  // final String pid;
  RxBool refreshUI = false.obs;

  addOrder(
    String deliverycharge,
    String totalamount,
    String itemcount,
    String addressid,
    String deliveryDate,
    String deliveryTime,
    String selfPickup,
    List<Map<String, dynamic>> productarraylist,
  ) async {
    try {
      print('inside add');
      isLoading(true);
      getResponseModel.value = (await _cartRepository.addOrder(
          deliverycharge,
          totalamount,
          itemcount,
          addressid,
          deliveryDate,
          deliveryTime,
          selfPickup,
          productarraylist))!;
      if (getResponseModel.value.response == 'Success') {
        SnackbarManager.showSuccessSnackbar(Get.context!, 'Success',
            getResponseModel.value.response.toString());
        await Get.to(SuccessScreen());
      } else {
        print(
          getResponseModel.value.message.toString(),
        );
        SnackbarManager.showWarningSnackbar(
            Get.context!, 'failed', getResponseModel.value.message.toString());
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

    super.onInit();
  }
}
