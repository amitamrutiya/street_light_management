import 'package:get/get.dart';
import 'package:street_light_management/routing/route_helper.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    Get.toNamed(RouteHelper.getWelcomeScreen());
  }
}
