import 'package:get/get.dart';
import 'package:street_light_management/screen/complaint/complaint_screen.dart';
import 'package:street_light_management/screen/controll_light/controll_light_screen.dart';
import 'package:street_light_management/screen/drawer/drawer.dart';
import 'package:street_light_management/screen/login_screen/login_screen.dart';
import 'package:street_light_management/screen/profile_screen/profile_screen.dart';
import 'package:street_light_management/screen/signup_screen/signup_screen.dart';
import 'package:street_light_management/screen/splash_screen.dart';
import 'package:street_light_management/screen/task_assign/task_assign_screen.dart';
import 'package:street_light_management/screen/user_home_page/user_main_screen.dart';
import 'package:street_light_management/screen/user_home_page/view_more_screen.dart';
import 'package:street_light_management/screen/verify_email_screen.dart';
import 'package:street_light_management/screen/welcome_screen.dart';

class RouteHelper {
  static const String splashScreen = '/splash-page';
  static const String welcomeScreen = '/welcome-page';
  static const String loginScreen = '/login-screen';
  static const String signUpScreen = '/sign-up-screen';
  static const String forgotPasswordScreen = '/forgot-password-screen';
  static const String verifyEmailScreen = '/verify-email-screen';
  static const String userMainScrenen = '/user-main-screen';
  static const String controllLightScreen = '/controll-light-screen';
  static const String customeDrawerScreen = '/custom-drawer';
  static const String complaintScreen = '/complaint-screen';
  static const String taskAssignScreen = '/task-assign-screen';
  static const String profileScreen = '/profile-screen';
  static const String viewMoreScreen = '/view-more-screen';

  static String getSplashScreen() => splashScreen;
  static String getWelcomeScreen() => welcomeScreen;
  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getForgotPasswordScreen() => forgotPasswordScreen;
  static String getVerifyEmailScreen() => verifyEmailScreen;
  static String getUserMainScreen() => userMainScrenen;
  static String getControllLightScreen() => controllLightScreen;
  static String getCustomeDrawerScreen() => customeDrawerScreen;
  static String getComplaintScreen() => complaintScreen;
  static String getTaskAssignScreen() => taskAssignScreen;
  static String getProfileScreen() => profileScreen;
  static String getViewMoreScreen() => viewMoreScreen;

  static List<GetPage> routes = [
    GetPage(
        name: splashScreen,
        page: () => SplashScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: welcomeScreen,
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
      name: userMainScrenen,
      page: () => const UserMainScreen(),
    ),
    GetPage(
      name: controllLightScreen,
      page: () => const ControllLightScreen(),
    ),
    GetPage(
      name: complaintScreen,
      page: () => const ComplaintScreen(),
    ),
    GetPage(
      name: customeDrawerScreen,
      transition: Transition.leftToRight,
      page: () => CustomDrawerScreen(),
    ),
    GetPage(
      name: taskAssignScreen,
      page: () => TaskAssignScreen(),
    ),
    GetPage(
      name: profileScreen,
      page: () => ProfileScreen(),
    ),
    GetPage(
        name: viewMoreScreen,
        page: () => ViewMoreScreen(),
        transition: Transition.rightToLeft)
  ];
}
