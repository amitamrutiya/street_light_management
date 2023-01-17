import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/dimensions.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/controller/auth_controller.dart';
import 'package:street_light_management/routing/route_helper.dart';
import 'package:street_light_management/screen/drawer/drawer.dart';
import 'package:street_light_management/screen/user_home_page/custom_grid_tile.dart';

class ViewMoreScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  ViewMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      drawer: CustomDrawerScreen(),
      key: scaffoldKey,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFBD89FE),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryLightColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: IconButton(
                        icon: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    BigText(
                      text: "Area Wise",
                      size: Dimensions.font26,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(RouteHelper.getProfileScreen()),
                      child: Container(
                          width: 55,
                          height: 55,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: authController.photoURL.value != null
                              ? Image.network(
                                  authController.photoURL.value.toString())
                              : Image.asset(profile_image)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  scrollDirection: Axis.vertical,
                  children: const [
                    CustomGridTile(
                        imageUrl: street_light1,
                        activeLight: 30,
                        deadLight: 2,
                        addressText: "SG Highway"),
                    CustomGridTile(
                        imageUrl: street_light3,
                        activeLight: 40,
                        deadLight: 0,
                        addressText: "Mall Road"),
                    CustomGridTile(
                        imageUrl: street_light3,
                        activeLight: 63,
                        deadLight: 7,
                        addressText: "Hirabag"),
                    CustomGridTile(
                        imageUrl: street_light4,
                        activeLight: 15,
                        deadLight: 1,
                        addressText: "Varchha"),
                    CustomGridTile(
                        imageUrl: street_light3,
                        activeLight: 30,
                        deadLight: 2,
                        addressText: "Utran"),
                    CustomGridTile(
                        imageUrl: street_light1,
                        activeLight: 40,
                        deadLight: 4,
                        addressText: "Motivavadi"),
                    CustomGridTile(
                        imageUrl: street_light1,
                        activeLight: 30,
                        deadLight: 2,
                        addressText: "SG Highway"),
                    CustomGridTile(
                        imageUrl: street_light3,
                        activeLight: 40,
                        deadLight: 0,
                        addressText: "Mall Road"),
                    CustomGridTile(
                        imageUrl: street_light3,
                        activeLight: 63,
                        deadLight: 7,
                        addressText: "Hirabag"),
                    CustomGridTile(
                        imageUrl: street_light4,
                        activeLight: 15,
                        deadLight: 1,
                        addressText: "Varchha"),
                    CustomGridTile(
                        imageUrl: street_light3,
                        activeLight: 30,
                        deadLight: 2,
                        addressText: "Utran"),
                    CustomGridTile(
                        imageUrl: street_light1,
                        activeLight: 40,
                        deadLight: 4,
                        addressText: "Motivavadi"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
