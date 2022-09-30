import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/features/authentication/screen/login_screen/login_footer_widget.dart';
import 'package:street_light_management/features/authentication/screen/login_screen/login_from_widget.dart';
import 'package:street_light_management/features/authentication/screen/login_screen/login_header_widget.dart';
import 'package:street_light_management/features/authentication/screen/roughwork.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                return const MyHomePage(title: "amit's home page");
              }
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      LoginHeaderWidget(),
                      LoginForm(),
                      LoginFooterWidget(),
                    ],
                  ),
                ),
              );
            }));
  }
}
