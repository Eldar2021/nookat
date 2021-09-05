import 'package:flutter/material.dart';
import 'package:nookat/widgets/home_screen_widgets.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyNewsStreamBuilder(),
    );
  }
}
