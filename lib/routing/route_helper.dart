import 'package:get/get.dart';
import 'package:street_light_management/features/authentication/screen/forgot_password_screen.dart';
import 'package:street_light_management/features/authentication/screen/login_screen/login_screen.dart';
import 'package:street_light_management/features/authentication/screen/roughwork.dart';
import 'package:street_light_management/features/authentication/screen/signup_screen/signup_screen.dart';
import 'package:street_light_management/features/authentication/screen/splash_screen.dart';
import 'package:street_light_management/features/authentication/screen/verify_email_screen.dart';
import 'package:street_light_management/features/authentication/screen/welcome_screen.dart';

class RouteHelper {
  static const String splashScreen = '/splash-page';
  static const String initialScreen = '/';
  static const String loginScreen = '/login-screen';
  static const String signUpScreen = '/sign-up-screen';
  static const String forgotPasswordScreen = '/forgot-password-screen';
  static const String verifyEmailScreen = '/verify-email-screen';
  static const String roughwork = '/roughwork';

  static String getSplashScreen() => splashScreen;
  static String getInitialScreen() => initialScreen;
  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getForgotPasswordScreen() => forgotPasswordScreen;
  static String getVerifyEmailScreen() => verifyEmailScreen;
  static String getRoughworkScreen() => roughwork;

  static List<GetPage> routes = [
    GetPage(
        name: splashScreen,
        page: () => SplashScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: initialScreen,
        page: () => const WelcomeScreen(),
        transition: Transition.fadeIn),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: verifyEmailScreen,
      page: () => const VerifyEmailScreen(),
    ),
    GetPage(
      name: roughwork,
      page: () => const MyHomePage(
        title: 'My App',
      ),
    ),
  ];
}
