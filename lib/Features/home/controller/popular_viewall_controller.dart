import 'package:get/get.dart';
import '../Repository/repo.dart';
import '../model/get_popular_products.dart';

class PopularProductController extends GetxController {
  var isLoading = true.obs;
  final HomeRepository _homeRepository = HomeRepository();
  Rx<GetPopularProducts> getPopularProducts = GetPopularProducts().obs;

  // final String pid;
  RxBool refreshPage = false.obs;

  RxList<PopularproductsList> popularList =
      List<PopularproductsList>.of([]).obs;

  // final String pid;

  RxBool searchBool = false.obs;

  fetchPopularProduct() async {
    print("123");
    try {
      getPopularProducts.value = (await _homeRepository.GetPopularProduct())!;
    } catch (e) {
    } finally {
      isLoading(false); // Reset loading state regardless of success or failure
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchPopularProduct();
    super.onInit();
  }

  filterSearch(String value) {
    List<PopularproductsList> reslutList = List<PopularproductsList>.of([]).obs;
    if (value.isEmpty) {
      searchBool.value = false;
      reslutList = getPopularProducts.value.popularproductsList!;
    } else {
      searchBool.value = true;
      reslutList = getPopularProducts.value.popularproductsList!
          .where((element) => element.productname
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }
    popularList.value = reslutList;
  }
}
