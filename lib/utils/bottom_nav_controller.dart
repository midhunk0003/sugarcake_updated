import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  // Method to change the current index
  void changePage(int index) {
    currentIndex.value = index;
  }
}