import 'package:get/get.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/otp/otp_screen.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/signIn/signin_screen.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/signup/components/forgot_change_password.dart';
import '../../../../../Widgets/snackbar_messeger.dart';
import '../../../../success response/response_model.dart';
import '../../otp/Repo/user_repo.dart';
import '../../otp/model/verify_otp_model.dart';
import '../components/send_forgot_password_otp.dart';
import '../model/send_otp_model.dart';
import '../repo/signup_repo.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  var isChecked = false.obs;
  final SignUpRepository _signUpRepository = SignUpRepository();
  final Rxn<int> selected = Rxn<int>();
  Rx<VerifyOtpModel> _verifyOtpModel = VerifyOtpModel().obs;
  final UserRepository userRepository = UserRepository();

  Rx<ResponseModel> responseModel = ResponseModel().obs;



  Rx<SendotpModel> _sendotpModel = SendotpModel().obs;
  RxBool obscureText = true.obs;

  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }

  fetchSendOtp(
      String name, String email, String phoneNumber, String password) async {
    try {
      isLoading(true);
      _sendotpModel.value = (await _signUpRepository.sendOtp(name, email))!;
      if (_sendotpModel.value.response.toString() == "Success") {
        var key = _sendotpModel.value.key.toString();
        SnackbarManager.showSuccessSnackbar(
            Get.context!, 'Success!', _sendotpModel.value.message.toString());
        Get.to(OtpScreen(
          name: name,
          phoneNumber: phoneNumber,
          password: password,
          email: email,
          keyUser: key,
        ));
      } else if (_sendotpModel.value.response.toString() == "Error" &&
          _sendotpModel.value.message.toString() ==
              "An account with this email already exist") {
        SnackbarManager.showWarningSnackbar(
          Get.context!,
          _sendotpModel.value.response.toString(),
          _sendotpModel.value.message.toString(),
        );
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', _sendotpModel.value.message.toString());
      }
    } catch (e) {
      // print(e);
      SnackbarManager.showFailureSnackbar(
          Get.context!, 'Error', 'check your internet');
    } finally {
      isLoading(false);
    }
  }

  sendForgotPasswordOtp(String email) async {
    try {
      isLoading(true);
      _sendotpModel.value = (await _signUpRepository.forgotPasswordOtp(email))!;
      if (_sendotpModel.value.response.toString() == "Success") {
        var key = _sendotpModel.value.key.toString();
        SnackbarManager.showSuccessSnackbar(
            Get.context!, 'Success!', _sendotpModel.value.message.toString());
        Get.to(SendForgotPasswordOtp(
          email: email,
          keyUser: key,
        ));
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', _sendotpModel.value.message.toString());
      }
    } catch (e) {
      SnackbarManager.showFailureSnackbar(
          Get.context!, 'Error', 'check your internet');
    } finally {
      isLoading(false);
    }
  }

  fetchVerifyOtp(String otp, String key,email) async {
    try {
      isLoading(true);
      _verifyOtpModel.value =
          (await userRepository.verifyOtp(otp, email, key))!;
      if (_verifyOtpModel.value.response.toString() == "Success") {
        SnackbarManager.showSuccessSnackbar(
            Get.context!, 'Success!', 'otp verified');
        Get.to(ForgotChangePasswordScreen(email: email,));
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed!', _verifyOtpModel.value.message.toString());
      }
    } catch (e) {
      SnackbarManager.showFailureSnackbar(
          Get.context!, 'Error', 'check your internet');
    } finally {
      isLoading(false);
    }
  }

  forgotChangePassword(String email, String pwd) async {
    try {
      responseModel.value =
      (await userRepository.forgotChangePassword(email, pwd))!;
     if (responseModel.value.response == 'Success') {
        SnackbarManager.showSuccessSnackbar(Get.context!, 'Change Password',
            responseModel.value.message.toString());
        Get.offAll(SignInScreen());
      } else {
        SnackbarManager.showFailureSnackbar(Get.context!, 'Change Password',
            responseModel.value.message.toString());
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

}
