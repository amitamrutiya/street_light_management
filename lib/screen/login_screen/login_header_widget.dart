import 'package:flutter/material.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/constant/dimensions.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/constant/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Hero(
            tag: 'login_img',
            child: Image(
                image: const AssetImage(login_register_image),
                height: size.height * 0.3),
          ),
        ),
        SizedBox(height: Dimensions.height10),
        BigText(
          text: loginLine,
          size: Dimensions.font20 * 2,
        ),
        BigText(
          text: loginSubLine,
          size: Dimensions.font16,
        ),
      ],
    );
  }
}
