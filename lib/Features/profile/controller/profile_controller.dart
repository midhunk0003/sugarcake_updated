import 'package:get/get.dart';
import 'package:sugar_cake/Features/profile/model/get_address_list_model.dart';
import '../../../Widgets/snackbar_messeger.dart';
import '../../success response/response_model.dart';
import '../model/get_profile.dart';
import '../repo/profile_repository.dart';

class ProfileController extends GetxController {
  RxBool isLoading = true.obs;
  final ProfileRepository profileRepository = ProfileRepository();
  Rx<GetProfileModel> getProfileModel = GetProfileModel().obs;
  Rx<ResponseModel> responseModel = ResponseModel().obs;
  Rx<GetAddressListModel> getAddressListModel = GetAddressListModel().obs;
  RxBool obscureText = true.obs;




  editProfile(String name, String email, String phoneNumber) async {
    try {
      responseModel.value =
          (await profileRepository.editProfile(name, email, phoneNumber))!;
      if (responseModel.value.response == 'Success') {
        SnackbarManager.showSuccessSnackbar(Get.context!, 'Edit Profile',
            responseModel.value.message.toString());
        await getProfile();
        Get.back();
      } else {
        SnackbarManager.showFailureSnackbar(Get.context!, 'Edit profile',
            responseModel.value.message.toString());
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  changePassword(String oldpwd, String newpwd, String confirmpwd) async {
    try {
      responseModel.value =
          (await profileRepository.changePassword(oldpwd, newpwd, confirmpwd))!;
      if (newpwd.toString() != confirmpwd.toString()) {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Change Password', "new password mismatch");
      } else if (responseModel.value.response == 'Success') {
        SnackbarManager.showSuccessSnackbar(Get.context!, 'Change Password',
            responseModel.value.message.toString());
        Get.back();
      } else {
        SnackbarManager.showFailureSnackbar(Get.context!, 'Change Password',
            responseModel.value.message.toString());
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  getProfile() async {
    try {
      getProfileModel.value = (await profileRepository.getProfile())!;
    } catch (e) {
      // Handle error
    } finally {}
  }

  addAddress(
    String orderedfor,
    String addressas,
    String address,
    String floor,
    String landmark,
    String contact,
    String defaultadrs,
    String zipcode,
    String longitude,
    String latitude,
  ) async {
    try {
      responseModel.value = (await profileRepository.addAddress(
          orderedfor,
          addressas,
          address,
          floor,
          landmark,
          contact,
          defaultadrs,
          zipcode,
          longitude,
          latitude))!;
    } catch (e) {
      // Handle error
    } finally {}
  }

  getAddressList() async {
    try {
      isLoading(true); // Set isLoading to true while fetching data
      getAddressListModel.value = (await profileRepository.getAddressList())!;
    } catch (e) {
      // Handle error
    } finally {
      isLoading(
          false); // Set isLoading to false after data fetching is complete
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getProfile();
    getAddressList();
    super.onInit();
  }
}
