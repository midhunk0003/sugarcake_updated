import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/app_constant.dart';

class AddressListWidget extends StatelessWidget {
  final String addressas;
  final String address;
  final String floor;
  final String landmark;
  final String phoneNumber;

  const AddressListWidget(
      {super.key,
      required this.addressas,
      required this.address,
      required this.floor,
      required this.landmark,
      required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color colorData;

    // Determine icon based on address type
    if (addressas == "home") {
      colorData = Color(0xffE42168);
      iconData = Icons.home_outlined;
    } else if (addressas == "work") {
      colorData = Color(0xff0F77F1);
      iconData = Icons.work_outline;
    } else if (addressas == "hotel") {
      colorData = Color(0xff22B3BC);
      iconData = Icons.hotel_outlined;
    } else {
      // Default icon
      colorData = Color(0xffD32E28);
      iconData = Icons.place_outlined;
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: colorData,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addressas,
                        style: whiteText,
                      ),
                      SizedBox(
                        height: .6.h,
                      ),
                      Text(
                        "$address \n$floor $landmark , $phoneNumber",
                        style: locationText,
                        // maxLines: 1,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
