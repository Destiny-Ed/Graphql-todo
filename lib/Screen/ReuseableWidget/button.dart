import 'package:flutter/material.dart';
import 'package:joovlin/Styles/color.dart';

Widget customButton(
    {
    VoidCallback? tap,
    bool? status = false,
    bool? isValid = false,
    BuildContext? context}) {
  return GestureDetector(
    onTap: isValid == false ? null : tap,
    child: Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isValid == false
              ? grey
              : status == false
                  ? primaryColor
                  : grey,
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context!).size.width,
      child: Text(
        status == false ? 'Save' : 'Please wait...',
        style: TextStyle(color: white, fontSize: 18),
      ),
    ),
  );
}
