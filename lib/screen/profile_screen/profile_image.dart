import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/controller/auth_controller.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();
  Future<void> pickImage(ImageSource source) async {
    try {
      _pickedFile = await _picker.getImage(source: source);
      if (_pickedFile == null) return;

      setState(() {
        image = File(_pickedFile!.path);
      });
    } on PlatformException catch (e) {
      print(e.toString());
      ShowErrorSnackBar.showSnackBar(text: 'Failed to pickup Image');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return GestureDetector(
      onTap: () => showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.camera_alt_outlined),
                      title: const Text('From Camera'),
                      onTap: () => pickImage(ImageSource.camera)
                          .then((value) => Get.back())),
                  ListTile(
                      leading: const Icon(Icons.image_outlined),
                      title: const Text('From Gallery'),
                      onTap: () => pickImage(ImageSource.gallery)
                          .then((value) => Get.back())),
                ],
              ),
            );
          }),
      child: _pickedFile == null
          ? authController.photoURL.value == null
              ? Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5),
                    shape: BoxShape.circle,
                    color: AppColors.primaryLightColor,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              : Obx(
                  () => Container(
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(
                            authController.photoURL.value.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
          : Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: FileImage(image!))),
            ),
    );
  }
}
