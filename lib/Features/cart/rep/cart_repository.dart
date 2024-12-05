import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_cake/utils/api_constants.dart';
import 'dart:convert';
import '../../../../../../Widgets/snackbar_messeger.dart';
import '../../success response/response_model.dart';
import '../model/GetCartModel.dart';
import '../model/add_product_model.dart';

class CartRepository {
  Dio _dio = Dio();
  SharedPreferences? _prefs;

  Future<GetCartModel?> getCartList() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      print(userId);
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(ApiConstant.BASE_URL + "getcartproduct/",
          data: {"userid": userId});
      print(" response repo in cart 1111111111:   $response");
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        return getCartModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<AddProductModel?> addOrder(
    String deliverycharge,
    String totalamount,
    String itemcount,
    String addressid,
    String deliveryDate,
    String deliveryTime,
    String selfPickup,
    List<Map<String, dynamic>> productarraylist,
  ) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";

      final response =
          await _dio.post(ApiConstant.BASE_URL + "addOrders/", data: {
        "userid": userId,
        "deliverycharge": deliverycharge,
        "totalamount": totalamount,
        "itemcount": itemcount,
        "addressid": addressid,
        "deliverydate": deliveryDate,
        "deliverytime": deliveryTime,
        "self_pickup": selfPickup,
        "productarraylist": jsonEncode(productarraylist),
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = response.data;
        print(response.data);
        var jsonString = jsonEncode(response.data);
        return addProductModelFromJson(
            jsonString); // Parse JSON string to ResponseModel object
      } else {
        // Handle failure
        return null;
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');

      return null;
    }
  }

  Future<ResponseModel?> updateQuantity(String pid, String type) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(ApiConstant.BASE_URL + "getQuantity/",
          data: {"id": pid, "type": type});
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        return responseModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {}
    return null;
  }
}
