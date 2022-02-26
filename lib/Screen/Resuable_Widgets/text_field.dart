import 'package:flutter/material.dart';
import 'package:joovlin/Styles/color.dart';

Widget customTextField(
    {String? title,
    String? hint,
    Function(String)? onChanged,
    TextEditingController? controller,
    int? maxLines = 1}) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          title!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: lightGrey,
        ),
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          
          onChanged: (value) => onChanged!(value),
          decoration: InputDecoration(hintText: hint, border: InputBorder.none),
        ),
      )
    ],
  );
}
