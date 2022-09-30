import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/features/authentication/model/user_model.dart';
import 'package:street_light_management/main.dart';

final googleSignIn = GoogleSignIn();
bool userstatus = false;
GoogleSignInAccount? _user;
GoogleSignInAccount get user => _user!;

Future googleLogin(BuildContext context) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) => const Center(child: CircularProgressIndicator())));
  GoogleSignInAccount? googleUser;
  GoogleSignInAuthentication? googleAuth;
  try {
    googleUser = await googleSignIn.signIn();
  } catch (e) {
    print(e.toString());
    ShowErrorSnackBar.showSnackBar(text: e.toString());
  }
  if (googleUser == null) {
    Get.back();
    return;
  }

  _user = googleUser; 
  try {
    googleAuth = await googleUser.authentication;
  } catch (e) {
    print(e.toString());
    ShowErrorSnackBar.showSnackBar(text: e.toString());
  }
  await uploadUserData();
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth!.accessToken,
    idToken: googleAuth.idToken,
  );
  try {
    await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    print(e.toString());
    ShowErrorSnackBar.showSnackBar(text: e.toString());
  }

  navigatorKey.currentState!.pop();
}

Future<void> uploadUserData() {
  UserModel newUser = UserModel(
      fullName: user.displayName.toString(),
      phoneNumber: "",
      emailAddress: user.email.toString(),
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
