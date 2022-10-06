import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/common_weights/custom_app_bar.dart';
import 'package:street_light_management/common_weights/show_error_snackbar.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/model/task_assign_model.dart';
import 'package:street_light_management/screen/controll_light/three_bulb_in_row.dart';
import 'package:street_light_management/screen/drawer/drawer.dart';
import 'package:street_light_management/screen/task_assign/date_picker_field.dart';
import 'package:street_light_management/screen/task_assign/show_list_engineer_dialog.dart';

class TaskAssignScreen extends StatelessWidget {
  var assignDateController = TextEditingController();
  var deadlineDateController = TextEditingController();
  var descriptionController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TaskAssignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.primaryLightColor,
      drawer: const CustomDrawerScreen(),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(title: "Assign Task", scaffoldKey: _scaffoldKey),
            Expanded(
                child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BigText(
                      text: 'Select Faulty Light',
                      size: 20,
                    ),
                    const ThreeBulbInRow(),
                    const Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    BigText(
                      text: 'Select Task Assign Date',
                      size: 17,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DatePickerFiled(
                      pickDateController: assignDateController,
                      lable: 'Assign Date',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BigText(
                      text: 'Select Available Engineer',
                      size: 17,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ShowListEngineerDialog(),
                    const SizedBox(
                      height: 10,
                    ),
                    BigText(
                      text: 'Select Deadline Date For Work',
                      size: 17,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DatePickerFiled(
                      pickDateController: deadlineDateController,
                      lable: 'Deadline Date',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BigText(
                      text: 'Description',
                      size: 17,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildDescription(descriptionController),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              await uploadUserData(
                                  '2',
                                  assignDateController.text.toString(),
                                  deadlineDateController.text.toString(),
                                  selectedPujari,
                                  descriptionController.text.toString());
                              Get.snackbar("All went Perfect",
                                  "Engineer will recive this task");
                              assignDateController.clear();
                              deadlineDateController.clear();
                              deadlineDateController.clear();
                            },
                            child: const Text("Submit")))
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    ));
  }
}

Widget buildDescription(descriptionController) {
  return TextFormField(
    controller: descriptionController,
    maxLines: 3,
    decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: AppColors.primaryDarkColor),
        ),
        labelText: 'Comments',
        hintText: "Extra Message For Engineer",
        prefixIcon: Icon(
          Icons.info_outline,
          color: AppColors.primaryDarkColor,
        ),
        border: OutlineInputBorder()),
  );
}

Future<void> uploadUserData(String lightId, String assignDate,
    String deadlineDate, String engineerName, String? description) {
  TaskAssignModel taskAssign = TaskAssignModel(
      lightId: lightId,
      assignDate: assignDate,
      deadlineDate: deadlineDate,
      engineerName: engineerName,
      description: description);
  return FirebaseFirestore.instance
      .collection("taskassign")
      .add(taskAssign.toJson())
      .then((_) async {
    print("got data");
  }).catchError((error) {
    ShowErrorSnackBar.showSnackBar(text: "An error occured");
  });
}
