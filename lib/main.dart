import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/features/authentication/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();
final messengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        home: SplashScreen());
  }
}
