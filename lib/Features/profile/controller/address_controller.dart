

import 'package:get/get.dart';
import 'package:sugar_cake/Features/profile/model/get_address_list_model.dart';

import '../../../utils/init_screen.dart';
import '../../success response/response_model.dart';

import '../repo/profile_repository.dart';

class AddressController extends GetxController {
  RxBool isLoading = true.obs;
  final ProfileRepository profileRepository = ProfileRepository();
  var isChecked = false.obs;
  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }




  Rx<ResponseModel>responseModel = ResponseModel().obs;
  Rx<GetAddressListModel>getAddressListModel = GetAddressListModel().obs;


  getAddressList() async {
    try {
      isLoading(true); // Set isLoading to true while fetching data
      getAddressListModel.value = (await profileRepository.getAddressList())!;
      print("listtt");
      print(getAddressListModel.value.addressList!.length);
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false); // Set isLoading to false after data fetching is complete
    }
  }
  deleteAddress(int addressId) async {
    try {

      isLoading(true); // Set isLoading to true while fetching data
      responseModel.value = (await profileRepository.deleteAddress(addressId))!;
      getAddressListModel.value = (await profileRepository.getAddressList())!;
      Get.delete<AddressController>();
      Get.forceAppUpdate();
      if(getAddressListModel.value.addressList!.isEmpty){
        getAddressList();
      }
    } catch (e) {
      print(e);

      // Handle error
    } finally {
      isLoading(false); // Set isLoading to false after data fetching is complete
    }
  }



  @override
  void onInit()async {
    // TODO: implement onInit

   await getAddressList();
    super.onInit();
  }
}
