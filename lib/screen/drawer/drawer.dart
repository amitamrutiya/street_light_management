import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/small_text.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/controller/auth_controller.dart';
import 'package:street_light_management/screen/forgot_password_screen.dart';
import 'package:street_light_management/routing/route_helper.dart';

class CustomDrawerScreen extends StatefulWidget {
  const CustomDrawerScreen({Key? key}) : super(key: key);

  @override
  _CustomDrawerScreenState createState() => _CustomDrawerScreenState();
}

class _CustomDrawerScreenState extends State<CustomDrawerScreen> {
  final AuthController authController = Get.find<AuthController>();
  String? imageUrl;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    imageUrl = FirebaseAuth.instance.currentUser!.photoURL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryLightColor,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 35, 10, 50),
        child: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
              // color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
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
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              profile_image,
                              fit: BoxFit.cover,
                            )),
                  Container(
                    width: 10,
                    height: 100,
                    decoration: const BoxDecoration(
                        // color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: authController.name.value.toString(),
                      ),
                      SmallText(
                        text: authController.email.value.toString(),
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
                leadingIcon: Icons.person_outline_outlined,
                lable: "Profile",
                onTapEvent: () => Get.toNamed(RouteHelper.getProfileScreen()),
              ),
              CustomDrawerListTile(
                leadingIcon: Icons.edit_note,
                lable: "Edit Password",
                onTapEvent: () {
                  Get.back();
                  Get.to(() => ForgotPasswordScreen(
                      ));
                },
              ),
              CustomDrawerListTile(
                leadingIcon: Icons.light,
                lable: "Controll Light",
                onTapEvent: () =>
                    Get.toNamed(RouteHelper.getControllLightScreen()),
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
                onTapEvent: () => FirebaseAuth.instance.signOut().then(
                    (value) => Get.toNamed(RouteHelper.getWelcomeScreen())),
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
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                    // color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
              ),
              Text(
                lable,
                // style: FlutterFlowTheme.of(context).bodyText1,
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
