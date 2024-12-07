import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool readonly;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChange;

  // Add validator parameter

  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.hinttext,
    required this.keyboardType,
    this.readonly = false,
    this.validator,
    this.onChange, // Update constructor to accept validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xFFF4F4F4),
      ),
      child: TextFormField(
        readOnly: readonly,
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
        ),
        validator: validator, // Set validator property of TextFormField
      ),
    );
  }
}
