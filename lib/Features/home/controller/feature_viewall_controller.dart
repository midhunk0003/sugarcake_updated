import 'package:get/get.dart';
import '../Repository/repo.dart';
import '../model/get_feature_product_model.dart';




class FeatureProductController extends GetxController {
  var isLoading = true.obs;
  final HomeRepository _homeRepository = HomeRepository();
  Rx<GetFeatureProductsModel> getFeatureProductsModel =
      GetFeatureProductsModel().obs;

  // final String pid;
  RxBool refreshPage = false.obs;

  RxList<FeaturedproductsList> wishlistList =
      List<FeaturedproductsList>.of([]).obs;

  // final String pid;

  RxBool searchBool = false.obs;



  fetchFeatureProduct() async {
    try {
      getFeatureProductsModel.value =
      (await _homeRepository.GetFeatureProduct())!;
    } catch (e) {
    } finally {
      isLoading(false); // Reset loading state regardless of success or failure
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchFeatureProduct();
    super.onInit();
  }

  filterSearch(String value) {
    List<FeaturedproductsList> reslutList =
        List<FeaturedproductsList>.of([]).obs;
    if (value.isEmpty) {
      searchBool.value=false;
      reslutList = getFeatureProductsModel.value.featuredproductsList!;
    } else {
      searchBool.value=true;
      reslutList = getFeatureProductsModel.value.featuredproductsList!
          .where((element) => element.productname
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase()))
          .toList();
    }
    wishlistList.value=reslutList;
  }

}
