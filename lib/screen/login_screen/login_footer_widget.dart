import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/constant/text_strings.dart';
import 'package:street_light_management/controller/auth_controller.dart';
import 'package:street_light_management/screen/signup_screen/signup_screen.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "OR",
          style: TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 30 - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon:
                const Image(image: AssetImage(google_logo_image), width: 20.0),
            onPressed: () async {
              authController.sign_in_with_google(true);
              authController.googleLogin(context);
            },
            label: const Text(
              signInWithGoogle,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 30 - 20),
        TextButton(
          onPressed: () {
            Get.off(() => const SignUpScreen(), transition: Transition.fadeIn);
          },
          child: const Text.rich(
            TextSpan(
                text: dontHaveAnAccount,
                style:
                    TextStyle(fontSize: 15, color: AppColors.primaryDarkColor),
                children: [
                  TextSpan(
                      text: signUp,
                      style: TextStyle(color: Colors.deepPurple, fontSize: 15))
                ]),
          ),
        ),
      ],
    );
  }
}
