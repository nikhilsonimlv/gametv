import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final double width;
  final double height;
  final FontWeight fontWeight;
  final double fontSize;
  final bool upperCase;
  final bool disabled;

  CustomButton(
      {this.text,
      this.onTap,
      this.height = 50,
      this.width = 220,
      this.fontWeight = FontWeight.w700,
      this.fontSize = 20,
      this.upperCase = true,
      this.disabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: disabled ? Colors.grey.shade300 : Colors.indigo.shade900,
      child: OutlineButton(
        onPressed: onTap,
        disabledBorderColor: Colors.grey.shade800,
        disabledTextColor: Colors.red,
        borderSide: BorderSide(
            color: disabled ? Colors.grey.shade800 : Colors.grey,
            width: 2,
            style: BorderStyle.solid),
        highlightColor: Get.theme.primaryColor,
        highlightedBorderColor: Get.theme.accentColor,
        child: Text(
          upperCase ? text.toUpperCase() : text.toLowerCase(),
          maxLines: 1,
          style: TextStyle(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: disabled ? Colors.grey : Colors.white,
          ),
        ),
      ),
    );
  }
}
