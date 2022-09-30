import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/features/authentication/model/user_model.dart';
import 'package:street_light_management/main.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final formKey = GlobalKey<FormState>();
  var fullNameController = TextEditingController();
  var emailAddressController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  void dispose() {
    fullNameController.dispose();
    emailAddressController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30 - 10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: fullNameController,
              decoration: const InputDecoration(
                  label: Text("Full Name"),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: ((value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                } else if (value.length < 8) {
                  return 'Please write your full name';
                } else {
                  return null;
                }
              }),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              controller: emailAddressController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("E-Mail"),
                  prefixIcon: Icon(Icons.email_outlined)),
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
            const SizedBox(height: 30 - 20),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Phone Number"),
                  prefixIcon: Icon(Icons.numbers)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter a Phone number';
                } else if (!GetUtils.isPhoneNumber(value)) {
                  return 'Enter a valid phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Password"),
                  prefixIcon: Icon(Icons.fingerprint)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter a Password';
                } else if (value.length < 8) {
                  return 'Minimum 8 characters required';
                }
                return null;
              },
            ),
            const SizedBox(height: 30 - 10),
            Hero(
              tag: 'submit_button',
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      await signUp();
            
                    } else {
                      return;
                    }
                  },
                  child: const Text(
                    " Sign Up",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
        barrierColor: AppColors.primaryLightColor,
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            const Center(child: CircularProgressIndicator())));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddressController.text.trim(),
        password: passwordController.text.trim(),
      ).then((_) =>uploadUserData());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      ShowErrorSnackBar.showSnackBar(text: e.message!);
    }
    navigatorKey.currentState!.pop();
  }

  Future<void> uploadUserData() {

    UserModel newUser = UserModel(
        fullName: fullNameController.text.toString(),
        phoneNumber: phoneNumberController.text.toString(),
        emailAddress: emailAddressController.text.trim().toString(),
        createdTime: DateTime.now().toString());
    return FirebaseFirestore.instance
        .collection("newuser")
        .add(newUser.toJson())
        .then((_) async {
      print("got data");
    }).catchError((error) {
      ShowErrorSnackBar.showSnackBar(text: "An error occured");
    });
  }
}
