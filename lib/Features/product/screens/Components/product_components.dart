import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';

class ProductsComponent extends StatefulWidget {
  final String image;
  final Function cartFct;
  final Function favFct;
  final List<String> additionalImages; // List of additional image URLs
  final String categoryName;
  final String productName;
  final String rating;
  final String discription;
  final String preparationtime;

  const ProductsComponent(
      {Key? key,
      required this.cartFct,
      required this.favFct,
      required this.image,
      required this.additionalImages,
      required this.productName,
      required this.rating,
      required this.categoryName,
      required this.discription,
      required this.preparationtime})
      : super(key: key);

  @override
  _ProductsComponentState createState() => _ProductsComponentState();
}

class _ProductsComponentState extends State<ProductsComponent> {
  late String currentBackgroundImage;

  @override
  void initState() {
    super.initState();
    currentBackgroundImage = widget.image;
  }

  void handleCakeImageTap(String cakeImage) {
    setState(() {
      int tappedIndex = widget.additionalImages.indexOf(cakeImage);
      if (tappedIndex != -1) {
        String temp = widget.additionalImages[tappedIndex];
        widget.additionalImages[tappedIndex] = currentBackgroundImage;
        currentBackgroundImage = temp;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ClipRect(
                child: Container(
                  color: Colors.white,
                  child: Image.network(
                    currentBackgroundImage,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                left: 2.h,
                top: 7.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Material(
                        elevation: 2,
                        shape: const CircleBorder(),
                        child: Container(
                          width: 35,
                          height: 35,
                          color: Colors.transparent,
                          child: Icon(
                            Icons.arrow_back_ios_new_sharp,
                            size: 22,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 2.h,
                top: 7.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.favFct();
                      },
                      child: Material(
                        elevation: 2,
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: .7.h, right: .5.h, left: .5.h, bottom: .2.h),
                          child: Container(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.favorite,
                              size: 3.3.h,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.cartFct();
                      },
                      child: Material(
                        elevation: 2,
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: .7.h, right: .5.h, left: .5.h, bottom: .2.h),
                          child: Container(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.shopping_cart,
                              size: 3.3.h,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: MediaQuery.of(context).size.width * 0.15,
                right: MediaQuery.of(context).size.width * 0.10,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        elevation: 2,
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              for (var imageUrl in widget.additionalImages)
                                GestureDetector(
                                  onTap: () => handleCakeImageTap(imageUrl),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: Colors.white,
                                        height: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.14,
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.13,
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.h, right: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.categoryName,
                      style: discText,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xffF6C958),
                        ),
                        Text(
                          widget.rating,
                          style: discText,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: .5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.productName,
                      style: headText,
                    ),
                    const Icon(
                      Icons.radio_button_checked,
                      color: Colors.green,
                    )
                  ],
                ),
                SizedBox(
                  height: .3.h,
                ),
                widget.preparationtime.isNotEmpty
                    ? Text(
                        'Preparation Time : ' + widget.preparationtime,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0x804B4B4B),
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: .10.h,
                ),
                Text(
                  'Description',
                  style: headText,
                ),
                SizedBox(
                  height: .9.h,
                ),
                ExpandableText(widget.discription,
                    expandText: 'See More',
                    collapseText: 'See Less',
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                    linkColor: kSecondaryColor, // Optional
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: kLightcolor,
                    ) // Optional

                    ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
