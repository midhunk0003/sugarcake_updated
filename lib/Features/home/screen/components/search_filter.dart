import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sugar_cake/utils/app_colors.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          cursorColor: AppColors.greyElementColor,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Search here....',
              prefixIcon: Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'Assets/icons/Search Icon.png',
                  width: 2.h,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none)),
        )),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 5.h,
            height: 5.h,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Image.asset(
              'Assets/icons/Filter Icon.png',
              width: 20,
              height: 20,
            ),
          ),
        )
      ],
    );
  }
}
