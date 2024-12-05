import 'package:flutter/material.dart';
import 'package:sugar_cake/utils/app_constant.dart';

class Filter extends StatelessWidget {
  Function(String)? filterFn;
  TextEditingController? controller;
  Function? iconFn;

  Filter({super.key, required controller, required filterFn, required iconFn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: filterFn,
              // _getSubscriberListControllerFr!
              //     .filterSearch(value);
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                hintText: "Search here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle: const TextStyle(
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 22,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              iconFn;
            },
            child: Container(
              width: 48.00,
              height: 48.00,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: const Icon(
                Icons.filter_list,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
