import 'package:get/get.dart';
import '../../../../../Widgets/snackbar_messeger.dart';
import '../../signIn/signin_screen.dart';
import '../Repo/user_repo.dart';
import '../model/user_registration_model.dart';
import '../model/verify_otp_model.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var isChecked = false.obs;
  final UserRepository _userRepository = UserRepository();
  final String name;
  final String password;
  final String email;
  final String phoneNumber;

  Rx<VerifyOtpModel> _verifyOtpModel = VerifyOtpModel().obs;
  Rx<UserRegistarionModel> _userRegistarionModel = UserRegistarionModel().obs;

  UserController(
      {required this.name,
      required this.password,
      required this.email,
      required this.phoneNumber});

  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }

  fetchVerifyOtp(String otp, String key,String name, String password, String email, phoneNumber) async {
    try {
      _verifyOtpModel.value =
          (await _userRepository.verifyOtp(otp, email, key))!;
      if (_verifyOtpModel.value.response.toString() == "Success") {
        SnackbarManager.showSuccessSnackbar(
            Get.context!, 'Success!', 'otp verified');
          try {
            _userRegistarionModel.value = (await _userRepository
                .userRegistarion(name, password, email, phoneNumber))!;
            if (_userRegistarionModel.value.response.toString() == "Success") {
              SnackbarManager.showSuccessSnackbar(
                  Get.context!, 'Registration!', _userRegistarionModel.value.message.toString());
              print(name +password+email+phoneNumber);
              Get.to(SignInScreen());
            } else  {
              SnackbarManager.showFailureSnackbar(
                  Get.context!, 'Failed', _userRegistarionModel.value.message.toString());
            }
          } catch (e) {
            // SnackbarManager.showFailureSnackbar(
            //     Get.context!, 'Error', 'An error occurred');
          } finally {
            isLoading(false);
          }

        // Get.to(OtpScreen(name: name, phoneNumber: phoneNumber, password: password, email: email));
      }
      // else {
      //   SnackbarManager.showWarningSnackbar(
      //       Get.context!, 'Failed', _verifyOtpModel.value.message.toString());
      // }
    } catch (e) {
      SnackbarManager.showFailureSnackbar(
          Get.context!, 'Error', 'check your internet');
    } finally {
      isLoading(false);
    }
  }
// void fetchUser(String name, String password, String email , phoneNumber) async {
//   try {
//     _userRegistarionModel.value = (await _userRepository.userRegistarion(name,password,email,phoneNumber))!;
//     if (_userRegistarionModel.value.response.toString() == "Success") {
//       SnackbarManager.showSuccessSnackbar(Get.context!, 'Registration!', 'Registration successsful');
//       Get.to(SignInScreen());
//     }  else if (_userRegistarionModel.value.response.toString() == "Email or phone number already exists"){
//       SnackbarManager.showFailureSnackbar(Get.context!, 'Failed',"otp incorrect");
//     }
//   } catch (e) {
//     SnackbarManager.showFailureSnackbar(Get.context!, 'Error', 'An error occurred');
//   } finally {
//     isLoading(false);
//   }
// }
}
