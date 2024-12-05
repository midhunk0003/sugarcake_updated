import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_cake/utils/api_constants.dart';
import 'dart:convert';
import '../../../../../../Widgets/snackbar_messeger.dart';
import '../../success response/response_model.dart';
import '../model/get_product_by_id_model.dart';

class ProductbByIdRepository {
  final Dio _dio = Dio();
  SharedPreferences? _prefs;

  Future<GetProductByIdModel?> getProductbyId(String pid) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      print("ppppppppppppp : ${pid}");
      print("uuuuuuuuuuu : ${userId}");
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post("${ApiConstant.BASE_URL}getproductbyid/",
          data: {"productid": pid, "userid": userId});
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        print('......11111111${data}');
        print(jsonString);
        return getProductByIdFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<ResponseModel?> addToCart(
    String pid,
    String flavoursId,
    String quantity,
    String weightId,
    String note,
    String price,
    String categoryId,
  ) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response =
          await _dio.post("${ApiConstant.BASE_URL}addtoCart/", data: {
        "productid": pid,
        "userid": userId,
        "flavoursid": flavoursId,
        "quantity": quantity,
        "weightid": weightId,
        "note": note,
        "price": price,
        "categoryid": categoryId
      });
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
