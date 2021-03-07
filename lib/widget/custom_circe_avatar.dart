import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  String imageUrl;
  double radius;

  CustomCircleAvatar({
    Key key,
    this.imageUrl,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      radius: radius,
    );
  }
}
