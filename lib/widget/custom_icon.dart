import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomIcon extends StatelessWidget {
  final String pathToSvg;
  final double width;
  final double height;

  const CustomIcon({Key key, this.pathToSvg, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      pathToSvg,
      height: height,
      width: width,
    );
  }
}
