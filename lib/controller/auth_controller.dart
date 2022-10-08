import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/controller/internet_controller.dart';
import 'package:street_light_management/main.dart';
import 'package:path/path.dart' as Path;

class AuthController extends GetxController {
  RxString? _errorCode;
  RxString? get errorCode => _errorCode;
  final RxBool _hasError = false.obs;
  RxBool? get hasError => _hasError;

  final _photoURL = Rxn<String>();
  Rxn<String> get photoURL => _photoURL;

  final _uid = Rxn<String>();
  Rxn<String> get uid => _uid;
  final _email = Rxn<String>();
  Rxn<String> get email => _email;
  final _name = Rxn<String>();
  Rxn<String> get name => _name;
  final _phone = Rxn<String>();
  Rxn<String> get phone => _phone;
  RxBool sign_in_with_google = false.obs;
  RxBool sign_in_with_mail = false.obs;
  final InternetController internetController = Get.put(InternetController());

  Future checkUserSignIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (sign_in_with_google == true || sign_in_with_mail == true) {}
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    sign_in_with_google(s.getBool("signed_in_google") ?? false);
    sign_in_with_mail(s.getBool("signed_in_mail") ?? false);
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in_google", true);
    sign_in_with_google(true);
  }

  Future signUp(BuildContext context, String email, String password,
      String name, String number) async {
    showDialog(
        barrierColor: AppColors.primaryLightColor,
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            const Center(child: CircularProgressIndicator())));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((_) => uploadUserData(name, number, email));
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      ShowErrorSnackBar.showSnackBar(text: e.message!);
    }
    navigatorKey.currentState!.pop();
  }

  Future uploadUserData(String name, String number, String email) async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection("users").doc(uid.value);
    await r
        .set({
          "_name": name.toString(),
          "_email": email.toString(),
          "_uid": FirebaseAuth.instance.currentUser!.uid.toString(),
          "_photo_url": "",
          "_phone": number.toString(),
          "_createdAt": DateTime.now(),
        })
        .then((value) => print('got data'))
        .catchError((error) {
          ShowErrorSnackBar.showSnackBar(text: "An error occured");
        });
  }

  Future signIn(BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            const Center(child: CircularProgressIndicator())));
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(response);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      ShowErrorSnackBar.showSnackBar(text: e.message!);
    }
    navigatorKey.currentState!.pop();
  }

  Future googleLogin(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    await internetController.checkInternetConnection();
    if (internetController.hasInternet == false) {
      ShowErrorSnackBar.showSnackBar(text: "Check Your Internet Connection");
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            const Center(child: CircularProgressIndicator())));
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
    try {
      googleAuth = await googleUser.authentication;
    } catch (e) {
      print(e.toString());
      ShowErrorSnackBar.showSnackBar(text: e.toString());
    }
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      final User userDetails =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
      _photoURL(userDetails.photoURL);
      _name(userDetails.displayName);
      _email(userDetails.email);
      _phone(userDetails.phoneNumber);
      _uid(userDetails.uid);
      update();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "account-exists-with-different-credential":
          _errorCode!(
              "You already have an account with us. Use correct provider");
          _hasError(true);
          break;
        case "null":
          _errorCode!("Some unexpected error while trying to sign in");
          _hasError(true);

          break;
        default:
          _errorCode!(e.toString());
          _hasError(true);
      }
    }

    navigatorKey.currentState!.pop();
  }

  uploadImage(File image) async {
    String imageUrl = "";
    String fileName = Path.basename(image.path);
    var reference = FirebaseStorage.instance.ref().child('user/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot takeSnapshot = await uploadTask.whenComplete(() => null);
    await takeSnapshot.ref.getDownloadURL().then((value) => imageUrl = value);

    return imageUrl;
  }

  // updateImage(File image) async {
  //   var url = await uploadImage(image);
  //   String _uid = FirebaseAuth.instance.currentUser!._uid;
  //   UserModel userDetails = UserModel(
  //       full_Name: _name,
  //       _phoneNumber: _phone,
  //       emailAddress: _email,
  //       createdTime: DateTime.now(),
  //       profileImage: url);
  //   try {
  //     FirebaseFirestore.instance
  //         .collection('newuser')
  //         .doc(_uid)
  //         .update(userDetails.toJson());
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // ENTRY FOR CLOUDFIRESTORE
  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) => {
              _uid(snapshot['_uid']),
              _name(snapshot['_name']),
              _email(snapshot['_email']),
              _photoURL(snapshot['_photo_url']),
              _phone(snapshot['_phone']),
            })
        .then((value) => print("get User Date From Firestore$_name"));
  }

  Future saveDataToFirestore() async {
    print("method called");
    final DocumentReference r =
        FirebaseFirestore.instance.collection("users").doc(uid.value);
    await r.set({
      "_name": _name.toString(),
      "_email": _email.toString(),
      "_uid": _uid.toString(),
      "_photo_url": _photoURL.toString(),
      "_phone": _phone.toString(),
      "_createdAt": DateTime.now(),
    }).then((value) => print('got data'));
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('_name', _name.value.toString());
    await s.setString('_email', _email.value.toString());
    await s.setString('_uid', _uid.value.toString());
    await s.setString('_photo_url', _photoURL.value.toString());
    await s.setString('_phone', _phone.value.toString());
    print(s.getString(_uid.toString()));
  }

  Future getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name(s.getString('_name'));
    _email(s.getString('_email'));
    _photoURL(s.getString('_photo_url'));
    _uid(s.getString('_uid'));
    _phone(s.getString('_phone'));
    print(_name.toString());
    print(_email.toString());
    print(_photoURL.toString());
    print(_uid.toString());
  }

  // checkUser exists or not in cloudfirestore
  Future<bool> checkUserExists() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid.value)
        .get();
    if (snap.exists) {
      print("EXISTING USER");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  // signout
  Future userSignOut() async {
    await GoogleSignIn().signOut();

    sign_in_with_google(false);

    await FirebaseAuth.instance.signOut();

    // clear all storage information
    clearStoredData();
  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }
}
