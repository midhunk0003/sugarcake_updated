import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Widgets/snackbar_messeger.dart';
import '../../../../../utils/init_screen.dart';
import '../../../../success response/response_model.dart';
import '../model/login_model.dart';
import '../repo/logIn_repository.dart';

class LoginInController extends GetxController {
  var isLoading = false.obs;
  final LogInRepository _logInRepository = LogInRepository();

  // TextEditingController _emailcontroller =TextEditingController();

  Rx<LoginModel> _loginModel = LoginModel().obs;
  Rx<ResponseModel> responseModel = ResponseModel().obs;
  RxBool obscureText = true.obs;

  void fetchLogin(String email, String password) async {
    isLoading(true);
    try {
      _loginModel.value = (await _logInRepository.login(email, password))!;
      if (_loginModel.value.response == "Success" && _loginModel.value.logindetails != null) {
        SharedPreferences _prefs = await SharedPreferences.getInstance();

        final loginDetails = _loginModel.value.logindetails;
        _prefs.setString('token', loginDetails!.token.toString());
        _prefs.setString('userId', loginDetails.id.toString());
        _prefs.setString('type', 'User');


        SnackbarManager.showSuccessSnackbar(
            Get.context!, 'Success!', 'Login Successful');

        Get.to(const InitScreen());
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Error', _loginModel.value.message ?? 'Unknown error');
      }
    } catch (e) {
      SnackbarManager.showWarningSnackbar(
          Get.context!, 'Error','check your internet');
    } finally {
      isLoading(false);
    }
  }
  void guestLogin() async {
    isLoading(true);
    try {
      _loginModel.value = (await _logInRepository.guestLogin())!;
      if (_loginModel.value.response == "Success" && _loginModel.value.logindetails != null) {
        SharedPreferences _prefs = await SharedPreferences.getInstance();

        final loginDetails = _loginModel.value.logindetails;
        _prefs.setString('token', loginDetails!.token.toString());
        _prefs.setString('userId', loginDetails.id.toString());
        _prefs.setString('type', loginDetails.type.toString());

        SnackbarManager.showSuccessSnackbar(
            Get.context!, 'Success!', 'Login Successful');

        Get.to(const InitScreen());
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Error', _loginModel.value.message ?? 'Unknown error');
      }
    } catch (e) {
      SnackbarManager.showWarningSnackbar(
          Get.context!, 'Error', 'check your internet');
    } finally {
      isLoading(false);
    }
  }

}
