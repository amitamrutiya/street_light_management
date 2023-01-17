import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/model/status_model.dart';
import 'package:street_light_management/screen/controll_light/three_bulb_in_row.dart';
import 'package:http/http.dart' as http;

class ControllLightScreen extends StatefulWidget {
  const ControllLightScreen({Key? key}) : super(key: key);

  @override
  _ControllLightScreenState createState() => _ControllLightScreenState();
}

class _ControllLightScreenState extends State<ControllLightScreen> {
  // List<StatusModel> postList = [];

  // Future<StatusModel> getPostApi() async {
  //   final resposne = await http.get(Uri.parse(
  //       'https://api.thingspeak.com/channels/1885949/feeds.json?results=1'));
  //   Map<String, dynamic> data = json.decode(resposne.body.toString());
  //   if (resposne.statusCode == 200) {
  //     return StatusModel.fromJson(data);
  //   } else {
  //     return StatusModel.fromJson(data);
  //   }
  // }

  bool switchListTileValue = false;

  bool checkBoxListTileValue = false;
  double slidervalue = 5;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _asyncMethod();
  //   });
  // }

  // _asyncMethod() async {
  //   StatusModel statusmodel = await getPostApi();
  //   switchListTileValue = statusmodel.feeds![0].field2 == 0 ||
  //           statusmodel.feeds![0].field2 == null
  //       ? false
  //       : true;
  //   print(switchListTileValue);
  // }

  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? const Center(child: CircularProgressIndicator())
        : Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              const SizedBox(height: 10),
              ThreeBulbInRow(checkBoxListTileValue: checkBoxListTileValue),
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
                    onChanged: (newValue) async {
                      // final respone = await http.get(Uri.parse(
                      //     'https://api.thingspeak.com/channels/1885949/feeds.json?results=2'));
                      if (onTap == false) {
                        ShowErrorSnackBar.showSnackBar(
                            text: "Please First Select Light");
                      } else {
                        setState(() => switchListTileValue = newValue);
                        // BaseClient().post(, payloadObj)
                        setState(() {
                          _isLoading = true;
                        });
                        if (switchListTileValue == true) {
                          var response = await http.post(Uri.parse(
                              'https://api.thingspeak.com/update?api_key=KJ4TJDKRFHTNGG70&field2=1'));
                          Future.delayed(const Duration(seconds: 1));
                          print("${response.statusCode}light on");
                          response = await http.post(Uri.parse(
                              'https://api.thingspeak.com/update?api_key=KJ4TJDKRFHTNGG70&field2=1'));
                          // Future.delayed(const Duration(seconds: 1));
                          print("${response.statusCode}light on");
                          response = await http.post(Uri.parse(
                              'https://api.thingspeak.com/update?api_key=KJ4TJDKRFHTNGG70&field2=1'));
                          // Future.delayed(const Duration(seconds: 1));
                          print("${response.statusCode}light on");
                          response = await http.post(Uri.parse(
                              'https://api.thingspeak.com/update?api_key=KJ4TJDKRFHTNGG70&field2=1'));
                          // Future.delayed(const Duration(seconds: 1));
                          print("${response.statusCode}light on");
                          response = await http.post(Uri.parse(
                              'https://api.thingspeak.com/update?api_key=KJ4TJDKRFHTNGG70&field2=1'));

                          if (response.statusCode == 200) {
                            onTap = true;
                            print("${response.statusCode}light on");
                          } else {
                            print(response.statusCode);
                          }
                          setState(() {
                            _isLoading = false;
                            onTap = true;
                          });
                        } else {
                          var response = await http.post(Uri.parse(
                              'https://api.thingspeak.com/update?api_key=KJ4TJDKRFHTNGG70&field2=0'));
                          Future.delayed(const Duration(seconds: 1));
                          response = await http.post(Uri.parse(
                              'https://api.thingspeak.com/update?api_key=KJ4TJDKRFHTNGG70&field2=0'));
                          // Future.delayed(const Duration(seconds: 1));
                          response = await http.post(Uri.parse(
                              'https://api.thingspeak.com/update?api_key=KJ4TJDKRFHTNGG70&field2=0'));
                          // Future.delayed(const Duration(seconds: 1));
                          response = await http.post(Uri.parse(
                              'https://api.thingspeak.com/update?api_key=KJ4TJDKRFHTNGG70&field2=0'));
                          // Future.delayed(const Duration(seconds: 1));
                          response = await http.post(Uri.parse(
                              'https://api.thingspeak.com/update?api_key=KJ4TJDKRFHTNGG70&field2=0'));
                          if (response.statusCode == 200) {
                            print("${response.statusCode}light off");
                          } else {
                            print(response.statusCode);
                          }
                          setState(() {
                            onTap = true;
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    title: BigText(
                      size: 17,
                      text: 'Light Status',
                    ),
                    subtitle: switchListTileValue
                        ? const Text(
                            'On',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        : const Text(
                            'Off',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
              ),
              const Divider(),
              BigText(text: 'Adjust Intensity'),
              Slider(
                  label: "Adjust Brightness",
                  value: slidervalue,
                  min: 1,
                  max: 10,
                  onChanged: (value) {
                    onTap
                        ? setState(() {
                            slidervalue = value.toDouble();
                          })
                        : ShowErrorSnackBar.showSnackBar(
                            text: 'Please first select light');
                  }),
              const Divider(),
              Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        value: checkBoxListTileValue,
                        onChanged: (newValue) {
                          if (onTap == false) {
                            ShowErrorSnackBar.showSnackBar(
                                text: "Please First Select Light");
                          } else {
                            setState(() => checkBoxListTileValue = newValue!);
                          }
                        },
                        title: BigText(
                          text: "Put It Into Maintenance",
                          color: Colors.white,
                          // size: 17,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (checkBoxListTileValue == true) {
                              Get.back();
                              Get.snackbar("Maintenance",
                                  "Light is succesfully put under maintenance",
                                  backgroundColor: AppColors.lightgreyColor,
                                  colorText: Colors.black);
                            }
                            setState(() {
                              checkBoxListTileValue = false;
                            });
                          },
                          child: const Text("Submit")),
                    ],
                  )),
            ],
          );
  }
}
