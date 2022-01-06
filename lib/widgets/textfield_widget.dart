import 'package:flutter/material.dart';
import 'package:technical_test_didinamarudin/configs/app_constants.dart';

class TextFieldAuth extends StatelessWidget {
  final String hint;
  final bool isObcsure;
  final TextEditingController controller;
  const TextFieldAuth({Key? key, required this.hint,required this.controller, this.isObcsure =false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin / 3),
      decoration: BoxDecoration(
        color: bgTextfieldAuth,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        maxLines: 1,
        obscureText: isObcsure,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hint),
      ),
    );
  }
}
