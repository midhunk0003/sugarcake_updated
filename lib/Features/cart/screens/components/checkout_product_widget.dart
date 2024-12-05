import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';

class CheckoutItem extends StatelessWidget {
  final String image;
  final String name;
  final String weight;
  final String price;
  final String flavour;
  final String addNote;
  final String category;
  final String quantity;

  const CheckoutItem({
    super.key,
    required this.image,
    required this.name,
    required this.weight,
    required this.price,
    required this.flavour,
    required this.addNote, required this.category, required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          height: 10.h,
                          width: 10.h,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: normalText),
                      Text(
                        category,
                        style: smallText,
                      ),
                      Row(
                        children: [

                          Text(
                            ( 'AED $price'),
                            style: normalText,
                          ),
                        ],
                      ),


                      SizedBox(
                        height: .5.h,
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  color: kPrimaryColor,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 1.h, right: 1.h),
                                    child:  Text(
                                      "$weight g",
                                      style: whiteText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Qty: ",style: normalText,),
                                Container(
                                  color: kPrimaryColor,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 1.h, right: 1.h),
                                    child:  Text(
                                      quantity,
                                      style: whiteText,
                                    ),
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
