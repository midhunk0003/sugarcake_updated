import 'package:get/get.dart';
import 'package:sugar_cake/Features/home/model/limit_feature_product.dart';
import 'package:sugar_cake/Features/home/model/limit_popular_products.dart';
import '../../../utils/init_screen.dart';
import '../../home/Repository/repo.dart';
import '../Components/introduction_screen.dart';


class SplashController extends GetxController {
  var isLoading = true.obs; // Initialize as true
  final HomeRepository _homeRepository = HomeRepository();

  Rx<LimitPopularProducts> limitPopularProducts = LimitPopularProducts().obs;
  Rx<LimitFeatureProducts> limitFeatureProductsModel =
      LimitFeatureProducts().obs;


  fetchLimitFeatureProduct() async {
    try {
      limitFeatureProductsModel.value =
      (await _homeRepository.limitFeatureProduct())!;
      if (limitFeatureProductsModel.value.response.toString() == "Success") {
        Get.to(InitScreen());
      } else {
        Get.to(IntroductionScreen());
      }
    } catch (e) {
    } finally {
      isLoading(false); // Reset loading state regardless of success or failure
    }
  }

  @override
  void onInit() {
    fetchLimitFeatureProduct();
    super.onInit();
  }
}
