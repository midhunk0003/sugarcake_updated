
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';




class CustomSnackbar{
  NoInernetSnackBar(){
    Get.snackbar('Network', 'No Internet Connection',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        duration: Duration(days: 1),
        mainButton: TextButton(onPressed: (){
          Get.back();
        }, child: Text('Okay',style: TextStyle(
            color: Colors.white
        ),)),
        colorText: Colors.white);
  }

  InfoSnackBar(String title,String message){
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:  Colors.redAccent,
        colorText: Colors.white);
  }

  LoadingBottomSheet(){
    Get.bottomSheet(
        Container(
          height: 20.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'Assets/Splash.svg',
                  height: 4.h,
                  width: 0,
                ),
                SizedBox(height: 10,),
                Text('Loading')
              ],
            ),
          ),
        ),
        persistent: false,
        isDismissible: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )
    );
  }
}