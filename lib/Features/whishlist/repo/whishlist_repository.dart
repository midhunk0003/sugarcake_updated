import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_cake/utils/api_constants.dart';
import 'dart:convert';
import '../../../../../../Widgets/snackbar_messeger.dart';
import '../../success response/response_model.dart';
import '../model/get_whishlist_model.dart';

class WhishlistRepository {
  Dio _dio = Dio();
  SharedPreferences? _prefs;

  Future<ResponseModel?> addToWhishlist(String pid) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(ApiConstant.BASE_URL + "addwishlist/",
          data: {"id": pid, "userid": userId});
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        return responseModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {

    }
    return null;
  }
  Future<GetWhislistModel?> getWhislist() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(ApiConstant.BASE_URL + "getWishlist/",
          data: {"userid": userId});
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        return getWhislistModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {

    }
    return null;
  }

}
