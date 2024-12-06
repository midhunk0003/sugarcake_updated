import 'package:get/get.dart';
import 'package:sugar_cake/Features/home/model/limit_feature_product.dart';
import 'package:sugar_cake/Features/home/model/limit_popular_products.dart';
import '../../../../../Widgets/snackbar_messeger.dart';
import '../model/get_banner_model.dart';
import '../Repository/repo.dart';
import '../model/get_category_model.dart';
import '../model/get_feature_product_model.dart';
import '../model/get_popular_products.dart';

class HomeController extends GetxController {
  var isLoading = true.obs; // Initialize as true
  final HomeRepository _homeRepository = HomeRepository();
  Rx<GetBannerModel> getBannerModel = GetBannerModel().obs;
  Rx<GetCategoryModel> getCategoryModel = GetCategoryModel().obs;
  Rx<GetPopularProducts> getPopularProducts = GetPopularProducts().obs;
  Rx<LimitPopularProducts> limitPopularProducts = LimitPopularProducts().obs;
  Rx<LimitFeatureProducts> limitFeatureProductsModel =
      LimitFeatureProducts().obs;
  Rx<GetFeatureProductsModel> getFeatureProductsModel =
      GetFeatureProductsModel().obs;

  RxList<FeaturedproductsList> wishlistList =
      List<FeaturedproductsList>.of([]).obs;

  // final String pid;

  RxBool searchBool = false.obs;

  void toggleFavoriteStatus(String isFavorite) {}

  fetchBanner() async {
    try {
      getBannerModel.value = (await _homeRepository.getBanner())!;
      if (getBannerModel.value.response.toString() == "Success" &&
          getBannerModel.value.bannerList != null) {
      } else {
        SnackbarManager.showWarningSnackbar(
            Get.context!, 'failed', getBannerModel.value.response.toString());
      }
    } catch (e) {
      SnackbarManager.showFailureSnackbar(
          Get.context!, 'Error', 'check your internet');
    } finally {
      // Reset loading state regardless of success or failure
    }
  }

  fetchCategory() async {
    try {
      getCategoryModel.value = (await _homeRepository.getCategory())!;
      if (getCategoryModel.value.response.toString() == "Success") {
      } else {
        SnackbarManager.showWarningSnackbar(
            Get.context!, 'failed', getCategoryModel.value.response.toString());
      }
    } catch (e) {
      if ("$e" == "Null check operator used on a null value") {
        SnackbarManager.showFailureSnackbar(
            Get.context!, 'Error', 'something wrong..');
      }
    } finally {}
  }

  fetchLimitPopularProduct() async {
    print('wwwwwwwwwwwwww : ${limitPopularProducts}');
    try {
      print('jjjjjjjjjjjjjj : ${limitPopularProducts}');
      limitPopularProducts.value =
          (await _homeRepository.limitPopularProduct())!;
      print('ppppppppppppppppp : ${limitPopularProducts}');
    } finally {}
  }

  fetchLimitFeatureProduct() async {
    try {
      limitFeatureProductsModel.value =
          (await _homeRepository.limitFeatureProduct())!;
      print('ooooooooooooo : ${limitFeatureProductsModel}');
    } finally {
      isLoading(false); // Reset loading state regardless of success or failure
    }
  }

  fetchPopularProduct() async {
    try {
      getPopularProducts.value = (await _homeRepository.GetPopularProduct())!;
    } finally {}
  }

  fetchFeatureProduct() async {
    try {
      getFeatureProductsModel.value =
          (await _homeRepository.GetFeatureProduct())!;
    } finally {
      isLoading(false); // Reset loading state regardless of success or failure
    }
  }

  @override
  void onInit() {
    // Initialize here
    fetchBanner(); // Start fetching data immediately
    fetchCategory();
    fetchLimitPopularProduct();
    fetchLimitFeatureProduct();
    fetchPopularProduct();
    fetchFeatureProduct();
    super.onInit();
  }

  filterSearch(String value) {
    List<FeaturedproductsList> reslutList =
        List<FeaturedproductsList>.of([]).obs;
    if (value.isEmpty) {
      searchBool.value = false;
      reslutList = getFeatureProductsModel.value.featuredproductsList!;
    } else {
      searchBool.value = true;
      reslutList = getFeatureProductsModel.value.featuredproductsList!
          .where((element) => element.productname
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }
    wishlistList.value = reslutList;
  }
}
