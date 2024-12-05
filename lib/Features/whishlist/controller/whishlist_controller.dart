import 'package:get/get.dart';
import 'package:sugar_cake/Features/explore/controller/explore_controller.dart';
import 'package:sugar_cake/Features/home/controller/popular_viewall_controller.dart';
import '../../../../../Widgets/snackbar_messeger.dart';
import '../../home/controller/feature_viewall_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../success response/response_model.dart';
import '../model/get_whishlist_model.dart';
import '../repo/whishlist_repository.dart';

class WhishListController extends GetxController {
  var isLoading = true.obs;
  final WhishlistRepository _whishlistRepository = WhishlistRepository();
  Rx<GetWhislistModel> getWhislistModel = GetWhislistModel().obs;
  RxList<WishlistList> wishlistList =
      List<WishlistList>.of([]).obs;

  // final String pid;
  RxBool refreshPage = false.obs;
  RxBool searchBool = false.obs;

  Rx<ResponseModel> responseModel = ResponseModel().obs;





  addtoWishlist(String productId) async {
    try {
      isLoading(true);
      responseModel.value =
          (await _whishlistRepository.addToWhishlist(productId))!;
      HomeController myController = Get.find<HomeController>();
      ExploreController controller = Get.find<ExploreController>();
      FeatureProductController fController = Get.put(FeatureProductController());
      PopularProductController pController = Get.put(PopularProductController());
      // CategoryListController cController = Get.find<CategoryListController>();
      //  myController.fetchFeatureProduct();
      //  myController.fetchPopularProduct();
       myController.fetchLimitFeatureProduct();
       myController.fetchLimitPopularProduct();
        fController.fetchFeatureProduct();
      pController.fetchPopularProduct();
      // cController.fetchCategoryById();
       await getWishList();
        controller.getExploreList();
      // refreshPage(true); // Trigger UI refresh
      if (responseModel.value.response.toString() == "Success") {
        SnackbarManager.showSuccessSnackbar(
            Get.context!, 'Success!', responseModel.value.message.toString());
        // Show success message or handle accordingly
      }
    } catch (e) {
      // Handle error
    } finally {
    }
  }

   getWishList() async {
    try {
      isLoading(true);
      getWhislistModel.value = (await _whishlistRepository.getWhislist())!;
      print( getWhislistModel.value );
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false);
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
     getWishList();
    super.onInit();
  }

  @override
  void onClose() {}
  filterSearch(String value) {
    List<WishlistList> reslutList =
        List<WishlistList>.of([]).obs;
    if (value.isEmpty) {
      searchBool.value=false;
      reslutList = getWhislistModel.value.wishlistList!;
    } else {
      searchBool.value=true;
      reslutList = getWhislistModel.value.wishlistList!
          .where((element) => element.productname
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase()))
          .toList();
    }
    wishlistList.value=reslutList;
  }
}
