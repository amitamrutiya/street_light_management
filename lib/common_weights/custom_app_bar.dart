import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/dimensions.dart';
import 'package:street_light_management/constant/image_string.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomAppBar({Key? key, required this.title, required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? imageUrl = FirebaseAuth.instance.currentUser!.photoURL;
    return Container(
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
                  Icons.menu,
                  size: 30,
                ),
              ),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          BigText(
            text: title,
            size: Dimensions.font26,
          ),
          GestureDetector(
            onTap: null,
            child: Container(
                width: 55,
                height: 55,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: imageUrl != null
                    ? Image.network(imageUrl)
                    : Image.asset(profile_image)),
          ),
        ],
      ),
    );
  }
}
