import 'package:flutter/material.dart';
import 'package:street_light_management/common_weights/big_text.dart';

class StatusLightCard extends StatelessWidget {
  final String mainHeading;
  Color? mainHeadingFontColor;
  Color? numberFontColor;
  final String number;
  StatusLightCard(
      {Key? key,
      required this.mainHeading,
      required this.number,
      this.mainHeadingFontColor = Colors.white,
      this.numberFontColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BigText(
          text: mainHeading,
          color: mainHeadingFontColor,
        ),
        BigText(
          text: number,
          color: numberFontColor,
        ),
      ],
    );
  }
}