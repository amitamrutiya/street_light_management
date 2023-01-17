import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:street_light_management/controller/auth_controller.dart';
import 'package:street_light_management/routing/route_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();
final messengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  AuthController authController = Get.put<AuthController>(AuthController());
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      title: 'Smart Light',
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      theme: ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Lora'),
      initialRoute: RouteHelper.getSplashScreen(),
      // home: TaskAssignScreen(),
      getPages: RouteHelper.routes,
    );
  }
}
