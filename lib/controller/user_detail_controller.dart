import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDatailController extends GetxController {
  // FirebaseAuth user = await FirebaseAuth.instance  ;
  // Rx<String?> name = user.currentUser!.d  isplayName.obs;

  updateName(String name) {
    FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    name = FirebaseAuth.instance.currentUser!.displayName as String;
    update();
  }

  updatePhotoURL() {}
}
