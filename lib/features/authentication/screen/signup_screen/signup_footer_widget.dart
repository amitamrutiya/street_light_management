import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/dimensions.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/constant/text_strings.dart';
import 'package:street_light_management/features/authentication/screen/google_sign_in/google_sign_in.dart';
import 'package:street_light_management/features/authentication/screen/login_screen/login_screen.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        SizedBox(height: Dimensions.height10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              googleLogin(context);
            },
            icon: const Image(
              image: AssetImage(google_logo_image),
              width: 20.0,
            ),
            label: const Text(
              signInWithGoogle,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.off(() => const LoginScreen(), transition: Transition.fadeIn);
          },
          child: const Text.rich(TextSpan(children: [
            TextSpan(
              text: alreadyHaveAccount,
              style: TextStyle(fontSize: 15, color: AppColors.primaryDarkColor),
            ),
            TextSpan(
              text: " Login",
              style: TextStyle(fontSize: 15),
            )
          ])),
        )
      ],
    );
  }
}
