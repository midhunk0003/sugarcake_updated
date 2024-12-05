import 'package:get/get.dart';
import '../model/order_byid_model.dart';
import '../repo/order_repository.dart';


class OrderByIdController extends GetxController {
  var isLoading = true.obs;
  final OrderRepository _orderRepository = OrderRepository();
  Rx<GetOrderByIdModel> getOrderById = GetOrderByIdModel().obs;
  RxBool refreshPage = false.obs;
  final String orderid;

  OrderByIdController({required this.orderid});



  fetchOrderList() async {
    try {
      isLoading(true);
      getOrderById.value = (await _orderRepository.getOrderListById(orderid))!;
      print("aspppp");
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      isLoading(false);
    }
  }
  @override
  void onInit() {
    fetchOrderList();
    super.onInit();
  }
}
