import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/custom_app_bar.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/dimensions.dart';

import 'package:street_light_management/screen/controll_light/three_bulb_in_row.dart';
import 'package:street_light_management/screen/drawer/drawer.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? textController1;
  TextEditingController? textController2;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryLightColor,
        key: _scaffoldKey,
        drawer: CustomDrawerScreen(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              // color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(
                title: "Complaint",
                scaffoldKey: _scaffoldKey,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 25, 25, 25),
                  child: Container(
                    width: double.infinity,
                    height: 30,
                    decoration: const BoxDecoration(
                        // color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: 'Select Light',
                          ),
                          ThreeBulbInRow(),
                          const Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.height10),
                            width: double.infinity,
                            height: 130,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BigText(
                                      text: 'Upload Image',
                                    ),
                                    ElevatedButton(
                                      onPressed: () => showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                                      leading: const Icon(Icons
                                                          .camera_alt_outlined),
                                                      title: const Text(
                                                          'From Camera'),
                                                      onTap: () => pickImage(
                                                              ImageSource
                                                                  .camera)
                                                          .then((value) =>
                                                              Get.back())),
                                                  ListTile(
                                                      leading: const Icon(
                                                          Icons.image_outlined),
                                                      title: const Text(
                                                          'From Gallery'),
                                                      onTap: () => pickImage(
                                                              ImageSource
                                                                  .gallery)
                                                          .then((value) =>
                                                              Get.back())),
                                                ],
                                              ),
                                            );
                                          }),
                                      child: const Text('Select'),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 101,
                                  width: 101,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1)),
                                  child: _pickedFile != null
                                      ? Image.file(
                                          image!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : const Center(
                                          child: Text("Upload \nImage"),
                                        ),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: double.infinity,
                            height: 10,
                          ),
                          SizedBox(height: Dimensions.height15),
                          TextFormField(
                            controller: textController1,

                            decoration: InputDecoration(
                              labelText: 'Address',
                              hintText: 'Light Address',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primaryDarkColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.home),
                            ),
                            // style: FlutterFlowTheme.of(context).bodyText1,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          ),
                          SizedBox(height: Dimensions.height15),
                          BigText(
                            size: 14,
                            text: 'Additional Info',

                            // style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                          SizedBox(height: Dimensions.height15),
                          TextFormField(
                            controller: textController2,

                            decoration: InputDecoration(
                              label: const Text('Info'),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primaryDarkColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(
                                Icons.info_outline_rounded,
                              ),
                            ),
                            // style: FlutterFlowTheme.of(context).bodyText1,
                            maxLines: 3,
                          ),
                          SizedBox(height: Dimensions.height20),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // textController1!.clear();
                                  // textController2!.clear();
                                  // image = null;
                                  // _pickedFile = null;
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          ),
                        ],
                      ),
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
