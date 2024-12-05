import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_cake/utils/api_constants.dart';
import 'dart:convert';
import '../../../../../../Widgets/snackbar_messeger.dart';
import '../model/get_explore_list_model.dart';

class ExploreRepository {
  Dio _dio = Dio();
  SharedPreferences? _prefs;

  Future<GetExploreModel?> getexplorelist() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(ApiConstant.BASE_URL + "getproducts/",
          data: {"userid": userId});
      print(userId);
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        print("aaaaaaaaaaaaaaaaaa : ${data.toString()}");
        return getExploreModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {}
    return null;
  }
}
