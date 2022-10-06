import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/dimensions.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/controller/auth_controller.dart';
import 'package:street_light_management/screen/user_home_page/user_main_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final AuthController authController = Get.find();
  bool _isEmailVerified = false;
  bool _canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!_isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    } else {
      getdata();
    }
    super.initState();
  }

  Future<void> getdata() async {
    await authController.getDataFromSharedPreferences();
    await authController
        .getUserDataFromFirestore(FirebaseAuth.instance.currentUser!.uid);
    
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      print("email send");
      setState(() => _canResendEmail = false);
      await Future.delayed(const Duration(seconds: 10));
      setState(() => _canResendEmail = true);
    } catch (e) {
      print(e);
      ShowErrorSnackBar.showSnackBar(text: e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      print(_isEmailVerified);
    });

    if (_isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("verfied email");
    final size = MediaQuery.of(context).size;
    if (_isEmailVerified) {
      return const UserMainScreen();
    } else {
      return Scaffold(
        backgroundColor: AppColors.primaryLightColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Hero(
                    tag: 'login_img',
                    child: Stack(
                      children: [
                        Image(
                          fit: BoxFit.cover,
                          image: const AssetImage(login_register_image),
                          height: size.height * 0.4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20),
              SizedBox(height: Dimensions.height30),
              Center(
                child: BigText(
                  text: "A verification email has been",
                  size: 24,
                ),
              ),
              Center(
                child: BigText(
                  text: "sent to your email.",
                  size: 24,
                ),
              ),
              SizedBox(height: Dimensions.height30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                child: SizedBox(
                  height: Dimensions.height10 * 5,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    label: Text(
                      "Resend Mail",
                      style: TextStyle(fontSize: Dimensions.font20),
                    ),
                    icon: const Icon(Icons.mail),
                    onPressed: _canResendEmail ? sendVerificationEmail : null,
                  ),
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: BigText(
                      text: "Cancel",
                      color: AppColors.primaryDarkColor,
                    )),
              )
            ],
          ),
        ),
      );
    }
  }
}
