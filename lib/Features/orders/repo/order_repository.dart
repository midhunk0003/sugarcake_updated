import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_cake/utils/api_constants.dart';
import 'dart:convert';
import '../../../../../../Widgets/snackbar_messeger.dart';
import '../model/order_byid_model.dart';
import '../model/order_model.dart';

class OrderRepository {
  final Dio _dio = Dio();
  SharedPreferences? _prefs;

  Future<GetOrder?> getOrderList() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio
          .post("${ApiConstant.BASE_URL}getOrders/", data: {"userid": userId});
      if (response.statusCode == 200) {
        // var data = response.data;
        var jsonString = jsonEncode(response.data);
        return getOrderFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {}
    return null;
  }

  Future<GetOrderByIdModel?> getOrderListById(String orderid) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post("${ApiConstant.BASE_URL}getOrderByid/",
          data: {"orderid": orderid, "userid": userId});
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        print(data.toString());
        return getOrderByIdModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
