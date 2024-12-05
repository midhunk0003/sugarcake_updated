import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sugar_cake/Features/signin_screen.dart/Screen/signup/model/send_otp_model.dart';
import 'package:sugar_cake/utils/api_constants.dart';

import 'dart:convert';

import '../../../../../Widgets/snackbar_messeger.dart';

class SignUpRepository {
  final Dio _dio = Dio();

  Future<SendotpModel?> sendOtp(String name, String email) async {
    try {
      final response =
          await _dio.post("${ApiConstant.BASE_URL}userotp/", data: {
        "email": email,
        "name": name,
      });

      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data);

        return sendotpModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<SendotpModel?> forgotPasswordOtp(String email) async {
    try {
      final response =
          await _dio.post("${ApiConstant.BASE_URL}forgotpasswordOtp/", data: {
        "email": email,
        "name": "",
      });

      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data);

        return sendotpModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");

        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
