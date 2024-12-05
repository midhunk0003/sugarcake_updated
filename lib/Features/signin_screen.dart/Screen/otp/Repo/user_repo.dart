import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:sugar_cake/utils/api_constants.dart';

import 'dart:convert';

import '../../../../../Widgets/snackbar_messeger.dart';
import '../../../../success response/response_model.dart';
import '../model/user_registration_model.dart';
import '../model/verify_otp_model.dart';

class UserRepository {
  final Dio _dio = Dio();

  Future<VerifyOtpModel?> verifyOtp(
      String otp, String email, String key) async {
    try {
      final response =
          await _dio.post("${ApiConstant.BASE_URL}verifyOtp/", data: {
        "otp": otp,
        "email": email,
        "key": key,
      });

      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data);
        return verifyOtpModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserRegistarionModel?> userRegistarion(
      String name, String password, String email, String phoneNumber) async {
    try {
      final response =
          await _dio.post("${ApiConstant.BASE_URL}userRegister/", data: {
        "name": name,
        "password": password,
        "email": email,
        "phoneNumber": phoneNumber,
        "isSocial": 0,
      });

      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data);

        return userRegistarionModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ResponseModel?> forgotChangePassword(
       String email, String pwd) async {
    try {
      final response = await _dio
          .post("${ApiConstant.BASE_URL}forgotchangepassword/", data: {
        "email": email,
        "pwd": pwd,
      });

      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data);
        return responseModelFromJson(jsonString);
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
