import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_constant.dart';

class ProductWeightFlavour extends StatefulWidget {
  final List<String> weightCategories;
  final List<String> flavours;
  final List<String> flavourId;
  final Function(String) onWeightSelected;
  final Function(String) onFlavorSelected;
  final Function(String) onNotesChanged;

  const ProductWeightFlavour({
    Key? key,
    required this.weightCategories,
    required this.flavours,
    required this.flavourId,
    required this.onWeightSelected,
    required this.onFlavorSelected, required this.onNotesChanged,
  }) : super(key: key);

  @override
  State<ProductWeightFlavour> createState() => _ProductWeightFlavourState();
}

class _ProductWeightFlavourState extends State<ProductWeightFlavour> {
  int _selectIndex = -1;
  int _groupValue = -1;
  int _selectedWeightIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Row(
              children: [
                Wrap(
                  spacing: 10.0,
                  runSpacing: 8.0,
                  children: _buildweight(),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.h, top: 2.h, bottom: 0.h),
          child: Text(
            'Choose Flavours',
            style: headText,
          ),
        ),
        Column(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.flavours.length,
              itemBuilder: (context, index) {
                return _myRadioButton(
                  title: widget.flavours[index],
                  value: widget.flavourId[index],
                );
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 3.h, right: 3.h),
          child: addNotes(),
        ),
      ],
    );
  }

  List<Widget> _buildweight() {
    return List<Widget>.generate(
      widget.weightCategories.length,
          (index) => Material(
        elevation: 4,
        color: Color(0xffF0F0F0),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 4.h,
          child: RawChip(
            showCheckmark: false,
            backgroundColor: Color(0xffF0F0F0),
            selectedColor: kPrimaryColor,
            side: BorderSide(
              color: _selectIndex == index ? Colors.transparent : Colors.transparent,
              width: 1.0,
            ),
            label: Text(
              widget.weightCategories[index],
              style: TextStyle(
                fontSize: 12.sp,
                color: _selectIndex == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            selected: _selectIndex == index,
            onSelected: (selected) {
              setState(() {
                _selectIndex = selected ? index : 0;
                _selectedWeightIndex = index;
                widget.onWeightSelected(widget.weightCategories[_selectedWeightIndex]);
              });
            },
          ),
        ),
      ),
    ).toList();
  }

  Widget _myRadioButton({required String title, required String value}) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      leading: Radio<String>(
        value: value,
        groupValue: _groupValue.toString(),
        activeColor: Colors.black,
        onChanged: (newValue) {
          setState(() {
            _groupValue = int.parse(newValue!);
          });
          widget.onFlavorSelected(newValue.toString());
        },
      ),
      onTap: () {
        setState(() {
          _groupValue = int.parse(value);
        });
        widget.onFlavorSelected(value);
      },
    );
  }

  Widget addNotes() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.fromLTRB(1.h, 2.h, 1.h, 1.h),
      child: TextFormField(
        onChanged: (text) {
          // Call the callback function to update the notes text
          widget.onNotesChanged(text);
        },
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.multiline,
        maxLength: 30,
        maxLines: 3,
        validator: (value) {
          if (value!.isEmpty) {
            return "Review";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Add notes here...',
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(.5),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.8.h),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white, width: .2.h),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.white,
              width: 0.9,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
