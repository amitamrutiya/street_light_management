import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/form_header_widget.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/constant/text_strings.dart';
import 'package:street_light_management/screen/signup_screen/signup_footer_widget.dart';
import 'package:street_light_management/screen/signup_screen/signup_form_widget.dart';
import 'package:street_light_management/screen/verify_email_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryLightColor,
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                      backgroundColor: AppColors.primaryDarkColor),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: BigText(
                    text: "Something Went Wrong",
                    size: 30,
                  ),
                );
              }
              if (snapshot.hasData) {
                return  VerifyEmailScreen();
              } else {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: const [
                        FormHeaderWidget(
                          image: login_register_image,
                          title: loginLine,
                          subTitle: loginSubLine,
                          imageHeight: 0.15,
                        ),
                        SignUpFormWidget(),
                        SignUpFooterWidget(),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
