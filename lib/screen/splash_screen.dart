import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/fade_in_animation/animation_design.dart';
import 'package:street_light_management/common_weights/fade_in_animation/fade_in_animation_controller.dart';
import 'package:street_light_management/common_weights/fade_in_animation/fade_in_animation_model.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/constant/text_strings.dart';
import 'package:street_light_management/controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: Stack(
        children: [
          FadeInAnimation(
            durationInMs: 2400,
            animate: AnimatePosition(
              topAfter: 30,
              topBefore: -30,
              leftBefore: -30,
              leftAfter: 10,
            ),
            child: const Image(image: AssetImage(top_splash_image)),
          ),
          FadeInAnimation(
            durationInMs: 2400,
            animate: AnimatePosition(
                topBefore: 170, topAfter: 170, leftAfter: 20, leftBefore: -80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appName, style: Theme.of(context).textTheme.headline4),
                Text(tagLine, style: Theme.of(context).textTheme.headline6)
              ],
            ),
          ),
          FadeInAnimation(
            durationInMs: 2400,
            animate: AnimatePosition(bottomBefore: 0, bottomAfter: 70),
            child: const Image(image: AssetImage(splash_image)),
          ),
          FadeInAnimation(
            durationInMs: 2400,
            animate: AnimatePosition(
                bottomBefore: 0,
                bottomAfter: 50,
                rightBefore: 30,
                rightAfter: 30),
            child: const Image(
              image: AssetImage(bottom_splash_image),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
