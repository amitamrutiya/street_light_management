import 'package:flutter/material.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/custom_app_bar.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/common_weights/small_text.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/screen/controll_light/three_bulb_in_row.dart';
import 'package:street_light_management/screen/drawer/drawer.dart';

class ControllLightScreen extends StatefulWidget {
  const ControllLightScreen({Key? key}) : super(key: key);

  @override
  _ControllLightScreenState createState() => _ControllLightScreenState();
}

class _ControllLightScreenState extends State<ControllLightScreen> {
  bool switchListTileValue = false;
  bool checkBoxListTileValue = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryLightColor,
        drawer: const CustomDrawerScreen(),
        key: _scaffoldKey,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(title: "Controll Light", scaffoldKey: _scaffoldKey),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 25, 25, 25),
                  child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                        BigText(
                          text: 'Select Light',
                        ),
                        const ThreeBulbInRow(),
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Center(
                            child: SwitchListTile(
                              value: switchListTileValue,
                              onChanged: (newValue) {
                                if (onTap == false) {
                                  ShowErrorSnackBar.showSnackBar(
                                      text: "Please First Select Light");
                                } else {
                                  setState(
                                      () => switchListTileValue = newValue);
                                }
                              },
                              title: BigText(
                                size: 17,
                                text: 'Controll Light',
                              ),
                              subtitle: switchListTileValue
                                  ? const Text(
                                      'On',
                                    )
                                  : SmallText(text: 'Off'),
                              controlAffinity: ListTileControlAffinity.trailing,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: CheckboxListTile(
                            value: checkBoxListTileValue,
                            onChanged: (newValue) {
                              if (onTap == false) {
                                ShowErrorSnackBar.showSnackBar(
                                    text: "Please First Select Light");
                              } else {
                                setState(
                                    () => checkBoxListTileValue = newValue!);
                              }
                            },
                            title: BigText(
                              text: "Put It Into Maintenance",
                              size: 17,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {}, child: const Text("Submit")),
                        Container(
                          height: 250,
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
  }
}
