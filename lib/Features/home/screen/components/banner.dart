import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_cake/Features/home/controller/home_controller.dart';
import 'package:sugar_cake/utils/app_constant.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';

import '../../../../utils/api_constants.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget>
    with TickerProviderStateMixin {
  late final HomeController _controller = Get.put(HomeController());

  late PageController _pageController;
  int activePage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    // Start the timer for automatic page scrolling
    startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        if (activePage <
            _controller.getBannerModel.value.bannerList!.length - 1) {
          // Move to the next page
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        } else {
          // Go back to the first page
          _pageController.animateToPage(0,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.only(left: 2.h),
          child: Text(
            'Special Offers',
            style: headText,
          ),
        ),
        SizedBox(height: 1.h),
        Obx(() {
          return _controller.isLoading.value
              ? Center(
              child:
              CircularProgressIndicator()) // Show loading indicator
              : Container(
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: 160,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              itemCount: _controller.getBannerModel.value.bannerList
                  ?.length ?? 0,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                if (_controller.getBannerModel.value.bannerList !=
                    null &&
                    pagePosition <
                        _controller.getBannerModel.value
                            .bannerList!.length &&
                    _controller.getBannerModel.value.bannerList![
                    pagePosition]
                        .imageurl !=
                        null) {
                  return Container(
                    margin: EdgeInsets.all(1.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: ApiConstant.BASE_imgUrl +
                          _controller.getBannerModel.value
                              .bannerList![pagePosition].imageurl!
                              .toString(),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              color: kSecondaryColor,
                              value: downloadProgress.progress)),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                  );
                } else {
                  // Handle case where bannerList is null or pagePosition is out of bounds
                  return Container(); // Or any other placeholder widget
                }
              },
            ),
          );
        }),
        // Show indicators only when not loading
        if (!_controller.isLoading.value) SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(
            _controller.getBannerModel.value.bannerList?.length ?? 0,
            activePage,
          ),
        ),
      ],
    );
  }

  List<Widget> indicators(int imagesLength, int currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 2.h,
        height: 2.h,
        decoration: BoxDecoration(
          color: currentIndex == index ? kPrimaryColor : Colors.black26,
          shape: BoxShape.circle,
        ),
      );
    });
  }
}
