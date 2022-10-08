import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/dimensions.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/controller/auth_controller.dart';
import 'package:street_light_management/routing/route_helper.dart';
import 'package:street_light_management/screen/controll_light/controll_light_screen.dart';
import 'package:street_light_management/screen/user_home_page/light_status_row_text.dart';

class ArewWiseLightStatusScreen extends StatelessWidget {
  final String areaName;
  final int activeLight;
  final int deadLight;
  final String image;
  const ArewWiseLightStatusScreen(
      {Key? key,
      required this.areaName,
      required this.activeLight,
      required this.deadLight,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryLightColor,
        body: SizedBox(
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
                      text: areaName,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                image,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 15,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 36,
                                    width: 120,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft:
                                                    Radius.circular(20)),
                                          ),
                                          width: 60,
                                          child: Center(
                                              child: BigText(
                                                  size: 20,
                                                  color: Colors.white,
                                                  text: "$activeLight")),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                          ),
                                          width: 60,
                                          child: Center(
                                              child: BigText(
                                                  size: 20,
                                                  color: Colors.white,
                                                  text: "$deadLight")),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        BigText(
                          size: 16,
                          text: areaName,
                        ),
                        const SizedBox(height: 10),
                        const Divider(thickness: 1),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              text: 'Stree Light Status',
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 25,
                        ),
                        Container(
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFBD89FE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 10, 20, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StatusLightCard(
                                  mainHeading: 'Total Lights',
                                  number: activeLight.toString(),
                                ),
                                StatusLightCard(
                                  mainHeading: 'Under Maintenance',
                                  number: deadLight.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BigText(
                              // size: 17,
                              text: 'Controll Light',
                            ),
                          ],
                        ),
                        const ControllLightScreen()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
