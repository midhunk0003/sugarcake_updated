import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/app_constant.dart';

class OrderListWidget extends StatelessWidget {
  final String orderid;
  final String date;
  final String time;
  final String status;
  final double rating;

  const OrderListWidget(
      {super.key,
      required this.orderid,
      required this.date,
      required this.status,
      required this.rating,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "Assets/images/order.png",
                    height: 8.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "OrderID : $orderid",
                        style: normalText,
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Text(
                        "$date $time",
                        style: smallText,
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Row(
                        children: [
                          Text("Rating  "),
                          RatingBar.builder(
                            initialRating: rating,
                            minRating: 0,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 14.sp,
                            itemPadding: EdgeInsets.symmetric(horizontal: .4.h),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                            ),
                            onRatingUpdate: (index) {},
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        )
      ],
    );
  }
}
