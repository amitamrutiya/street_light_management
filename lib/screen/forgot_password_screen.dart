import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/dimensions.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/controller/auth_controller.dart';
import 'package:street_light_management/screen/signup_screen/signup_form_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  ForgotPasswordScreen({Key? key})
      : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryLightColor,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
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
                                image: const AssetImage(forget_password),
                                height: size.height * 0.4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Center(
                            child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_sharp,
                                  // size: 40,
                                ),
                                color: AppColors.primaryLightColor,
                                onPressed: () => Get.back()),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: Dimensions.height30),
                Center(
                  child: BigText(
                    text: "Receive an email to",
                    size: 24,
                  ),
                ),
                Center(
                  child: BigText(
                    text: "reset your password.",
                    size: 24,
                  ),
                ),
                SizedBox(height: Dimensions.height30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: TextFormField(
                    
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("E-Mail"),
                      hintText: authController.email.value.toString()
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!(GetUtils.isEmail(value))) {
                        return 'Please enter your valid email address';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: SizedBox(
                    height: Dimensions.height10 * 5,
                    child: ElevatedButton(
                      onPressed: () => resetPassword(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.mail),
                          SizedBox(
                            width: Dimensions.height10,
                          ),
                          Text(
                            "Reset Password",
                            style: TextStyle(fontSize: Dimensions.font16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword(BuildContext context) async {
    showDialog(
        barrierColor: AppColors.primaryLightColor,
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            const Center(child: CircularProgressIndicator())));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: authController.email.value.toString());

      ShowErrorSnackBar.showSnackBar(
          text: 'Password Reset Email Sent',
          backgroundcolor: AppColors.primaryDarkColor);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      ShowErrorSnackBar.showSnackBar(text: e.message!);
      Navigator.of(context).pop();
    }
  }
}
