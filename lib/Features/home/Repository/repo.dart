import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_cake/utils/api_constants.dart';
import 'dart:convert';
import '../../../../../../Widgets/snackbar_messeger.dart';
import '../model/get_banner_model.dart';
import '../model/get_category_list_model.dart';
import '../model/get_category_model.dart';
import '../model/get_feature_product_model.dart';
import '../model/get_popular_products.dart';
import '../model/limit_feature_product.dart';
import '../model/limit_popular_products.dart';

class HomeRepository {
  Dio _dio = Dio();
  SharedPreferences? _prefs;
  Future<GetBannerModel?> getBanner() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(ApiConstant.BASE_URL + "getBanner/");
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        return getBannerModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {
      SnackbarManager.showFailureSnackbar(
          Get.context!, 'Failed', "something went wrong");
    }
    return null;
  }

  Future<GetCategoryModel?> getCategory() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(ApiConstant.BASE_URL + "getCategory/");
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        return getCategoryModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
      }
    } catch (e) {}
    return null;
  }

  Future<LimitPopularProducts?> limitPopularProduct() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(
          ApiConstant.BASE_URL + "limitpopularproducts/",
          data: {"userid": userId});
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        return limitPopularProductsFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
        // return null;
      }
    } catch (e) {}
    return null;
  }

  Future<LimitFeatureProducts?> limitFeatureProduct() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(
          ApiConstant.BASE_URL + "limitFeaturedProducts/",
          data: {"userid": userId});
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        return limitFeatureProductsFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
        // return null;
      }
    } catch (e) {}
    return null;
  }

  Future<GetPopularProducts?> GetPopularProduct() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(
          ApiConstant.BASE_URL + "getpopularproducts/",
          data: {"userid": userId});
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        return getPopularProductsFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
        // return null;
      }
    } catch (e) {}
    return null;
  }

  Future<GetFeatureProductsModel?> GetFeatureProduct() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(
          ApiConstant.BASE_URL + "getFeaturedProducts/",
          data: {"userid": userId});
      print("response 7777777777777777777 : ${response}");
      if (response.statusCode == 200) {
        var data = response.data;
        var jsonString = jsonEncode(response.data);
        return getFeatureProductsModelFromJson(jsonString);
      } else {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Failed', "something went wrong");
        // return null;
      }
    } catch (e) {}
    return null;
  }

  Future<GetCategoryListModel?> getCategoryById(String cid) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs?.getString('token');
      final userId = _prefs?.getString('userId');
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(
          ApiConstant.BASE_URL + "getproductbycategoryid/",
          data: {"categoryId": cid, "userid": userId});
      if (response.statusCode == 200) {
        var data = response.data;
        print("vvva" + data.toString());
        var jsonString = jsonEncode(response.data);
        return getCategoryListModelFromJson(jsonString);
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
