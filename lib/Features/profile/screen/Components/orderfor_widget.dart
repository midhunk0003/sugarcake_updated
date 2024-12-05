import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';
class OrderWidgetForWidget extends StatefulWidget {
  final List<String> addresscategory;
  final String orderfor;
  final Function(String) onRadioButtonSelected;
  final Function(String) onRawChipSelected;

  const OrderWidgetForWidget({
    Key? key,
    required this.addresscategory,
    required this.orderfor,
    required this.onRadioButtonSelected,
    required this.onRawChipSelected,
  });

  @override
  State<OrderWidgetForWidget> createState() => _OrderWidgetForWidgetState();
}

class _OrderWidgetForWidgetState extends State<OrderWidgetForWidget> {
  int _selectedRadioValue = -1;
  String _selectedAddressCategory = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2.h, top: 2.h, bottom: 1.h),
          child: Text(
            'Who are you ordering for?',
            style: normalText,
          ),
        ),
        Container(
          color: Colors.grey[100],
          child: Column(
            children: <Widget>[
              _myRadioButton(
                title: "myself",
                value: 0,
              ),
              _myRadioButton(
                title: "someone else",
                value: 1,
              ),
            ],
          ),
        ),
         Padding(
           padding:  EdgeInsets.only(left: 2.h,bottom: 2.h,top: 2.5.h),
           child: Text(
            'save address as*',
            style: normalText,
        ),
         ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Row(
              children: [
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: _buildCategoryDuration(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCategoryDuration() {
    return widget.addresscategory.map((address) {
      final isSelected = address == _selectedAddressCategory;

      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedAddressCategory = address;
          });
          widget.onRawChipSelected(address); // Callback
        },
        child: Material(
          elevation: 4,
          color: isSelected ? kPrimaryColor : Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 4.h,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  address,
                  style: GoogleFonts.titilliumWeb(
                    fontSize: 12.sp,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _myRadioButton({required String title, required int value}) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: normalText),
      leading: Radio<int>(
        value: value,
        groupValue: _selectedRadioValue,
        activeColor: Colors.black,
        onChanged: (int? newValue) {
          setState(() {
            _selectedRadioValue = newValue ?? 0;
          });
          // Pass the title to the callback function
          widget.onRadioButtonSelected(title);


        },
      ),
    );
  }
}
