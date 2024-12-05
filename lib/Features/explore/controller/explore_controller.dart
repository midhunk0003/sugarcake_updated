import 'package:get/get.dart';
import '../model/get_explore_list_model.dart';
import '../repo/explore_repository.dart';


class ExploreController extends GetxController {
  var isLoading = true.obs;
  final ExploreRepository _exploreRepository = ExploreRepository();
  Rx<GetExploreModel> getExploreModel = GetExploreModel().obs;


  RxList<ProductDetail> wishlistList =
      List<ProductDetail>.of([]).obs;
  // final String pid;
  RxBool refreshPage = false.obs;
  RxBool searchBool = false.obs;



   getExploreList() async {
    try {
      isLoading(true);
      getExploreModel.value = (await _exploreRepository.getexplorelist())!;
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false);
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    getExploreList();
    super.onInit();
  }


  @override
  void onClose() {}
  filterSearch(String value) {
    List<ProductDetail> reslutList =
        List<ProductDetail>.of([]).obs;
    if (value.isEmpty) {
      searchBool.value=false;
      reslutList = getExploreModel.value.productDetails!;
    } else {
      searchBool.value=true;
      reslutList = getExploreModel.value.productDetails!
          .where((element) => element.productname
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase()))
          .toList();
    }
    wishlistList.value=reslutList;
  }
}
