import 'package:get/get.dart';
import '../model/order_model.dart';
import '../repo/order_repository.dart';


class OrderController extends GetxController {
  var isLoading = true.obs;
  final OrderRepository _orderRepository = OrderRepository();
  Rx<GetOrder> getOrder = GetOrder().obs;
  RxBool refreshPage = false.obs;



  fetchOrderList() async {
    try {
      isLoading(true);
      getOrder.value = (await _orderRepository.getOrderList())!;
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false);
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchOrderList();
    super.onInit();
  }
}
