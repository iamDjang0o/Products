// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:pruduct_app/components/colors.dart';

class MyTextfield extends StatelessWidget {
  MyTextfield(
      {super.key,
      required this.hint,
      this.controller,
      this.onchanged,
      this.obscure});
  String hint;
  var obscure;
  Function? ontap;
  void Function(String)? onchanged;
  final controller;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      obscureText: obscure,
      onChanged: onchanged,
      controller: controller,
      cursorColor: primaryColor,
      decoration: InputDecoration(
          // enable error only if the field is empty when the user tries to submit

          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          hintText: hint,
          filled: true,
          constraints: BoxConstraints.tight(
              Size(screenWidth < 600 ? screenWidth - 36 : 365, 65)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  strokeAlign: 1,
                  width: 1,
                  color: Color.fromARGB(255, 221, 215, 215))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                  strokeAlign: 1,
                  width: 1,
                  color: Color.fromARGB(255, 221, 215, 215))),
          fillColor: const Color.fromARGB(162, 235, 230, 230),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                  strokeAlign: 1,
                  width: 1,
                  color: Color.fromARGB(55, 243, 234, 234)))),
    );
  }
}
