
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_cake/utils/api_constants.dart';
import 'dart:convert';
import '../../../../../../Widgets/snackbar_messeger.dart';
import '../../success response/response_model.dart';
import '../model/get_address_list_model.dart';
import '../model/get_profile.dart';

class ProfileRepository {
  final Dio _dio = Dio();
  SharedPreferences? _prefs;

  Future<GetProfileModel?> getProfile() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post("${ApiConstant.BASE_URL}getProfileByid/",
          data: {"userid": userId});
      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data);

        return getProfileModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {}
    return null;
  }

  Future<ResponseModel?> addAddress(
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
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response =
          await _dio.post("${ApiConstant.BASE_URL}addAddress/", data: {
        "userid": userId,
        "orderedfor": orderedfor,
        "addressas": addressas,
        "address": address,
        "floor": floor,
        "landmark": landmark,
        "contact": contact,
        "defaultadrs": defaultadrs,
        "pincode": zipcode,
        "longitude": longitude,
        "latitude": latitude
      });
      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data);
        return responseModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {}
    return null;
  }

  Future<GetAddressListModel?> getAddressList() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post("${ApiConstant.BASE_URL}viewAddress/",
          data: {"userid": userId});
      if (response.statusCode == 200) {
        print('########');
        print(jsonEncode(response.data));
        var jsonString = jsonEncode(response.data);
        return getAddressListModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {}
    return null;
  }

  Future<ResponseModel?> deleteAddress(int addressId) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post("${ApiConstant.BASE_URL}deleteAddress/",
          data: {"addressid": addressId});
      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data);
        return responseModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {}
    return null;
  }

  Future<ResponseModel?> changePassword(
      String oldpwd, String newpwd, String confirmpwd) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response =
          await _dio.post("${ApiConstant.BASE_URL}changePassword/", data: {
        "userid": userId,
        "oldpwd": oldpwd,
        "newpwd": newpwd,
        "confirmpwd": confirmpwd,
      });
      if (response.statusCode == 200) {
        var jsonString = jsonEncode(response.data);
        return responseModelFromJson(jsonString);
      } else {}
    } catch (e) {}
    return null;
  }

  Future<ResponseModel?> editProfile(
      String name, String email, String phoneNumber) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response =
          await _dio.post("${ApiConstant.BASE_URL}editProfile/", data: {
        "userid": userId,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
      });
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        print(data.toString());
        return responseModelFromJson(jsonString);
      } else {}
    } catch (e) {}
    return null;
  }
}
