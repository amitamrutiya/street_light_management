import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/custom_app_bar.dart';
import 'package:street_light_management/constant/image_string.dart';
import 'package:street_light_management/screen/drawer/drawer.dart';
import 'package:street_light_management/screen/user_home_page/custom_grid_tile.dart';
import 'package:street_light_management/screen/user_home_page/light_status_row_text.dart';
import 'package:street_light_management/screen/welcome_screen.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({Key? key}) : super(key: key);

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Scaffold(
                key: _scaffoldKey,
                drawer: const CustomDrawerScreen(),
                body: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomAppBar(
                        title: "Street Light",
                        scaffoldKey: _scaffoldKey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(
                                  width: double.infinity,
                                  height: 25,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: 'Stree Light Status',
                                    ),
                                    const Text(
                                      'View More >',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  height: 25,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFBD89FE),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            15, 10, 20, 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        StatusLightCard(
                                          mainHeading: 'Total Lights',
                                          number: '123',
                                        ),
                                        StatusLightCard(
                                          mainHeading: 'Under Maintenance',
                                          number: '018',
                                        ),
                                        StatusLightCard(
                                          mainHeading: 'Not Working    ',
                                          number: '002',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      1, 0, 10, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text: 'Area Wise Light Status',
                                      ),
                                      const Text(
                                        'View More >',
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  height: 25,
                                ),
                                Expanded(
                                  child: GridView(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    children: const [
                                      CustomGridTile(
                                          imageUrl: street_light1,
                                          activeLight: 30,
                                          deadLight: 2,
                                          addressText: "SG Highway"),
                                      CustomGridTile(
                                          imageUrl: street_light3,
                                          activeLight: 40,
                                          deadLight: 0,
                                          addressText: "Mall Road"),
                                      CustomGridTile(
                                          imageUrl: street_light3,
                                          activeLight: 63,
                                          deadLight: 7,
                                          addressText: "Hirabag"),
                                      CustomGridTile(
                                          imageUrl: street_light4,
                                          activeLight: 15,
                                          deadLight: 1,
                                          addressText: "Varchha"),
                                      CustomGridTile(
                                          imageUrl: street_light3,
                                          activeLight: 30,
                                          deadLight: 2,
                                          addressText: "Utran"),
                                      CustomGridTile(
                                          imageUrl: street_light1,
                                          activeLight: 40,
                                          deadLight: 4,
                                          addressText: "Motivavadi"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const WelcomeScreen();
          }
        });
  }
}
