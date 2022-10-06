import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/dimensions.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/constant/text_strings.dart';
import 'package:street_light_management/controller/auth_controller.dart';
import 'package:street_light_management/screen/login_screen/login_screen.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Column(
      children: [
        const Text("OR"),
        SizedBox(height: Dimensions.height10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              authController.googleLogin(context).then((value) {
                if (authController.hasError == true) {
                  ShowErrorSnackBar.showSnackBar(
                      text: authController.errorCode!.value.toString());
                } else {
                  authController.checkUserExists().then((value) async {
                    if (value == true) {
                      await authController
                          .getUserDataFromFirestore(authController.uid.value.toString())
                          .then((value) => authController
                              .saveDataToSharedPreferences()
                              .then((value) => authController.setSignIn()));
                    } else {
                      authController.saveDataToFirestore().then((value) =>
                          authController
                              .saveDataToSharedPreferences()
                              .then((value) => authController.setSignIn()));
                    }
                  });
                }
              });
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
