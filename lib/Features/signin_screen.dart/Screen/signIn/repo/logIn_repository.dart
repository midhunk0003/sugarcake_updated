import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:sugar_cake/utils/api_constants.dart';

import 'dart:convert';

import '../../../../../Widgets/snackbar_messeger.dart';
import '../model/login_model.dart';

class LogInRepository {
  Dio _dio = Dio();

  Future<LoginModel?> login(String email, String password) async {
    try {
      final response =
          await _dio.post(ApiConstant.BASE_URL + "userLogin/", data: {
        "email": email,
        "password": password,
      });
      print("respon repo signin ssssssssssss: ${response}");
      if (response.statusCode == 200) {
        // OTP sent successfully
        var data = response.data;

        var jsonString = jsonEncode(response.data);
        print(data.toString());
        return loginModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");

        // return null;
      }
    } catch (e) {
      print("Error loginn: $e");
      //
      // return null;
    }
    return null;
  }

  Future<LoginModel?> guestLogin() async {
    try {
      final response =
          await _dio.post(ApiConstant.BASE_URL + "guestlogin/", data: {});

      if (response.statusCode == 200) {
        // OTP sent successfully
        var data = response.data;

        var jsonString = jsonEncode(response.data);
        print(data.toString());
        return loginModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");

        // return null;
      }
    } catch (e) {
      print("Error loginn: $e");
      //
      // return null;
    }
    return null;
  }
}
