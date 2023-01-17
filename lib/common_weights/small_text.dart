import 'package:flutter/material.dart';
import 'package:street_light_management/constant/app_colors.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  TextOverflow? overFlow;
  SmallText({
    Key? key,
    this.color = AppColors.darkgreyColor,
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Lora',
        height: height,
      ),
      overflow: overFlow,
      softWrap: false,
      maxLines: 1,
    );
  }
}
