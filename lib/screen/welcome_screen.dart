import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/fade_in_animation/animation_design.dart';
import 'package:street_light_management/common_weights/fade_in_animation/fade_in_animation_controller.dart';
import 'package:street_light_management/common_weights/fade_in_animation/fade_in_animation_model.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/constant/text_strings.dart';

import 'package:street_light_management/screen/verify_email_screen.dart';
import 'package:street_light_management/routing/route_helper.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.animationIn();

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.secondryColor : AppColors.primaryLightColor,
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
              return VerifyEmailScreen();
            } else {
              return Stack(
                children: [
                  FadeInAnimation(
                    durationInMs: 1200,
                    animate: AnimatePosition(
                        bottomAfter: 0,
                        bottomBefore: -100,
                        leftAfter: 0,
                        leftBefore: 0,
                        rightAfter: 0,
                        rightBefore: 0,
                        topAfter: 0,
                        topBefore: 0),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                              image: const AssetImage(welcome_image),
                              height: height * 0.6),
                          Column(
                            children: [
                              BigText(
                                text: welcomeLine,
                                color: AppColors.primaryDarkColor,
                                size: 40,
                              ),
                              const Text(welcomeSubLine,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Get.toNamed(RouteHelper.getLoginScreen());
                                  },
                                  child: const Text("LOGIN"),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(RouteHelper.getSignUpScreen());
                                  },
                                  child: const Text("REGISTER"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
