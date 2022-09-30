import 'package:flutter/material.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/constant/dimensions.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    this.imageColor,
    this.heightBetween,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageHeight,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  //Variables -- Declared in Constructor
  final Color? imageColor;
  final double? imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Center(
          child: Hero(
            tag: 'login_img',
            child: Image(
                image: AssetImage(image),
                color: imageColor,
                height: size.height * 0.2),
          ),
        ),
        SizedBox(height: Dimensions.height10),
        BigText(
          text: title,
          size: Dimensions.font20 * 2,
        ),
        Hero(
          tag: 'login_subline',
          child: BigText(
            text: subTitle,
            size: Dimensions.font16,
          ),
        ),
      ],
    );
  }
}
