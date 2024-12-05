import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/app_constant.dart';

class OrderByIdComponents extends StatelessWidget {
  final String orderid;
  final String date;
  final String status;
  final String weight;
  final String note;
  final String quantity;
  final String price;
  final String flavoursename;
  final String name;

  const OrderByIdComponents({
    super.key,
    required this.orderid,
    required this.date,
    required this.status,
    required this.weight,
    required this.note,
    required this.quantity,
    required this.price,
    required this.flavoursename,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 3.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                "Assets/icons/orderbyid.png",
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
                    name,
                    style: normalText,
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Text(
                    flavoursename,
                    style: smallText,
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Text(
                    note,
                    style: smallText,
                  ),

                  SizedBox(
                    height: .5.h,
                  ),
                  Text(
                    "$weight kg",
                    style: smallText,
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        )
      ],
    );
  }
}
