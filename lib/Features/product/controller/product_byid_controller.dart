import 'package:get/get.dart';
import '../../../Widgets/snackbar_messeger.dart';
import '../../cart/screens/cart_screen.dart';
import '../../success response/response_model.dart';
import '../model/get_product_by_id_model.dart';
import '../repo/product_screen.dart';

class ProductByIdController extends GetxController {
  var isLoading = true.obs;
  final ProductbByIdRepository _productbByIdRepository =
      ProductbByIdRepository();
  Rx<GetProductByIdModel> getProductByIdModel = GetProductByIdModel().obs;
  Rx<ResponseModel> responseModel = ResponseModel().obs;
  RxList<String> weightChips = (List<String>.of([])).obs;
  final String pid;

  ProductByIdController({required this.pid});

  // final String pid;

  getProductByid() async {
    try {
      print('sssssssssssss : ${pid}');
      isLoading(true);
      print("99999999999");
      getProductByIdModel.value =
          (await _productbByIdRepository.getProductbyId(pid))!;
      if (getProductByIdModel.value.response.toString() == 'Success') {}
    } catch (e) {
      // Handle error
      print('qqqqqqqqqqq :${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  addToCart(
    String flavoursId,
    String quantity,
    String weightId,
    String note,
    String price,
    String categoryId,
    String preprationTime,
  ) async {
    try {
      isLoading(true);
      print("qweqweqwqe : ${preprationTime}");
      String input = preprationTime;
      // Split the string based on space
      List<String> parts = input.split(' ');

      // Access the parts
      String number = parts[0]; // "30"
      String unit = parts[1]; // "minutes"
      print('Number: $number');
      print('Unit: $unit');
      print(
          '!!!!!!!!!!!!!!!!!!!! : ${getProductByIdModel.value.productDetails!.toList()}');

      final List<ProductDetail> prodddd =
          getProductByIdModel.value.productDetails!.toList();
      print("nooooooooooooooooo : ${prodddd}");
      responseModel.value = (await _productbByIdRepository.addToCart(
          pid, flavoursId, quantity, weightId, note, price, categoryId))!;
      if (getProductByIdModel.value.response.toString() == 'Success') {
        SnackbarManager.showSuccessSnackbar(
            Get.context!, 'Success!', responseModel.value.message.toString());
        Get.to(const CartScreen());
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    await getProductByid();
    super.onInit();
  }
}
