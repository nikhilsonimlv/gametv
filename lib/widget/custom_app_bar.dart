import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leftWidget;
  final Widget rightWidget;

  @override
  final Size preferredSize;

  CustomAppBar({Key key, this.title = "", this.leftWidget, this.rightWidget})
      : preferredSize = Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 0, 0), child: leftWidget),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 25, 0), child: rightWidget),
            ),
          ],
        ),
      ),
    );
  }
}
