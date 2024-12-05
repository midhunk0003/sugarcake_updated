import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';

class CartItem extends StatelessWidget {
  final String image;
  final String name;
  final String weight;
  final String price;
  final String flavour;
  final String addNote;
  final String offerPrize;
  final String quatity;
  final String id;
  final Function addfct;
  final Function removefct;
  final String preprationTime;

  const CartItem({
    super.key,
    required this.image,
    required this.name,
    required this.weight,
    required this.price,
    required this.flavour,
    required this.addNote,
    required this.offerPrize,
    required this.quatity,
    required this.id,
    required this.addfct,
    required this.removefct,
    required this.preprationTime,
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
                          height: 16.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 2.h),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: normalText),
                      Text(
                        ' prepration Time : $preprationTime',
                        style: smallText,
                      ),
                      Row(
                        children: [
                          Text(
                            ('AED $offerPrize'),
                            style: lightText,
                          ),
                          Text(
                            ('  AED $price'),
                            style: normalText,
                          ),
                        ],
                      ),
                      Text(
                        "$weight",
                        style: normalText,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            flavour,
                            style: smallText,
                          ),
                          Text(
                            addNote,
                            style: smallText,
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
                                InkWell(
                                  onTap: () {
                                    addfct();
                                  },
                                  child: Container(
                                      color: kLightcolor,
                                      child: const Icon(Icons.remove)),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 1.h, right: 1.h),
                                  child: Text(
                                    quatity,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    removefct();
                                  },
                                  child: Container(
                                      color: kPrimaryColor,
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       "edit",
                            //       style: smallText,
                            //     ),
                            //     Icon(
                            //       Icons.edit_outlined,
                            //       color: Colors.red,
                            //       size: 9.sp,
                            //     ),
                            //   ],
                            // ),
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
