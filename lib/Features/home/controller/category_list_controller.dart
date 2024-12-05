import 'package:get/get.dart';
import '../../../Widgets/snackbar_messeger.dart';
import '../../success response/response_model.dart';
import '../../whishlist/repo/whishlist_repository.dart';
import '../Repository/repo.dart';
import '../model/get_category_list_model.dart';

class CategoryListController extends GetxController {
  var isLoading = true.obs;
  final HomeRepository _homeRepository = HomeRepository();
  Rx<GetCategoryListModel> getCategoryListModel = GetCategoryListModel().obs;

  final WhishlistRepository _whishlistRepository = WhishlistRepository();
  Rx<ResponseModel> responseModel = ResponseModel().obs;

  final String cid;

  // final String pid;
  RxBool refreshPage = false.obs;

  RxList<Productlist> categoryList = List<Productlist>.of([]).obs;

  // final String pid;

  RxBool searchBool = false.obs;

  CategoryListController({required this.cid});


  addtoWishlist(String productId) async {
    try {
      isLoading(true);
      responseModel.value =
      (await _whishlistRepository.addToWhishlist(productId))!;
      await fetchCategoryById();
      // cController.fetchCategoryById();
      // refreshPage(true); // Trigger UI refresh
      if (responseModel.value.response.toString() == "Success") {
        SnackbarManager.showSuccessSnackbar(
            Get.context!, 'Success!', responseModel.value.message.toString());
        // Show success message or handle accordingly
      }
    } catch (e) {
      // Handle error
    } finally {}
  }


  fetchCategoryById() async {
    try {
      isLoading(true);
      getCategoryListModel.value =
          (await _homeRepository.getCategoryById(cid))!;
    } catch (e) {
    } finally {
      isLoading(false); // Reset loading state regardless of success or failure
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    fetchCategoryById();
    super.onInit();
  }

  filterSearch(String value) {
    List<Productlist> reslutList = List<Productlist>.of([]).obs;
    if (value.isEmpty) {
      searchBool.value = false;
      reslutList = getCategoryListModel.value.productlist!;
    } else {
      searchBool.value = true;
      reslutList = getCategoryListModel.value.productlist!
          .where((element) => element.productname
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }
    categoryList.value = reslutList;
  }
}
