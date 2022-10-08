import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/small_text.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/controller/auth_controller.dart';
import 'package:street_light_management/screen/forgot_password_screen.dart';
import 'package:street_light_management/routing/route_helper.dart';

class CustomDrawerScreen extends StatelessWidget {
  CustomDrawerScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find<AuthController>();
  String? imageUrl;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryLightColor,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 35, 10, 50),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    splashRadius: 25,
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: AppColors.primaryDarkColor,
                      size: 25,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: FirebaseAuth.instance.currentUser!.photoURL != null
                        ? Image.network(
                            authController.photoURL.value.toString(),
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: AppColors.primaryColor,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 100,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text:FirebaseAuth.instance.currentUser!.displayName.toString(),
                      ),
                      SmallText(
                        text:FirebaseAuth.instance.currentUser!.email.toString(),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: AppColors.primaryDarkColor,
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              CustomDrawerListTile(
                leadingIcon: Icons.home_outlined,
                lable: "Home",
                onTapEvent: () => Get.toNamed(RouteHelper.getUserMainScreen()),
              ),
              CustomDrawerListTile(
                leadingIcon: Icons.person_outline_outlined,
                lable: "Profile",
                onTapEvent: () => Get.toNamed(RouteHelper.getProfileScreen()),
              ),
              CustomDrawerListTile(
                leadingIcon: Icons.edit_note,
                lable: "Edit Password",
                onTapEvent: () {
                  Get.back();
                  Get.to(() => ForgotPasswordScreen());
                },
              ),
              CustomDrawerListTile(
                leadingIcon: Icons.message_outlined,
                lable: "Complaint Damage Light",
                onTapEvent: () => Get.toNamed(RouteHelper.getComplaintScreen()),
              ),
              CustomDrawerListTile(
                  leadingIcon: Icons.task_outlined,
                  lable: "Assign Task",
                  onTapEvent: () =>
                      Get.toNamed(RouteHelper.getTaskAssignScreen())),
              const CustomDrawerListTile(
                leadingIcon: Icons.info_outline,
                lable: "About Us",
              ),
              CustomDrawerListTile(
                leadingIcon: Icons.logout,
                lable: "Logout",
                onTapEvent: () => authController.userSignOut()
                    .then(
                        (value) => Get.offAll(RouteHelper.getWelcomeScreen()))
                    
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDrawerListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String lable;
  final onTapEvent;
  const CustomDrawerListTile({
    Key? key,
    required this.leadingIcon,
    required this.lable,
    this.onTapEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          splashColor: AppColors.lightgreyColor,
          onTap: onTapEvent,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                leadingIcon,
                color: Colors.black,
                size: 27,
              ),
              const SizedBox(
                width: 20,
                height: 20,
              ),
              Text(
                lable,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 5,
          decoration: const BoxDecoration(
              // color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
        ),
      ],
    );
  }
}
