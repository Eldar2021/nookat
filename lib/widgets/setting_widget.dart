import 'package:flutter/material.dart';
import 'package:nookat/constants/color.dart';

class MySettingsContainer extends StatelessWidget {
  const MySettingsContainer({
    Key? key,
    required this.child,
    required this.padding,
    required this.onTab,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTab();
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: padding,
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: MyColors.boxShadowColor,
              offset: Offset(3, 1),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
