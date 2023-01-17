import 'dart:async';

import 'package:flutter/material.dart';
import 'package:street_light_management/common_weights/big_text.dart';
import 'package:street_light_management/constant/app_colors.dart';
import 'package:street_light_management/constant/dimensions.dart';

List<String> name = [
  "Hirabag",
  "Varacha",
  "Mota Varacha",
  "SimadaNaka",
  "Jakatnaka",
  "Station Road",
  "Vesu",
  "Dumas Road",
  "Katargam",
  "Adajan",
  "Utran",
  "Bardoli",
  "Hajira"
];
String _selectedArea = "";
String get selectedArea => _selectedArea;

class ShowAreaListDialoge extends StatefulWidget {
  const ShowAreaListDialoge({Key? key}) : super(key: key);

  @override
  State<ShowAreaListDialoge> createState() => _ShowAreaListDialogeState();
}

class _ShowAreaListDialogeState extends State<ShowAreaListDialoge> {
  @override
  void initState() {
    _selectedArea = "Click on Me";
    super.initState();
  }

  @override
  void dispose() {
    _selectedArea = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StreamController<String> selectedPujariController = StreamController();
    return StreamBuilder<Object>(
        stream: selectedPujariController.stream,
        builder: (context, snapshot) {
          return InkWell(
            onTap: () async {
              await _showListOfArea(context, selectedPujariController);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                  border: _selectedArea == "Click on Me"
                      ? Border.all(
                          width: 2, color: Theme.of(context).disabledColor)
                      : Border.all(
                          width: 2, color: AppColors.primaryDarkColor)),
              child: Row(
                children: [
                  if (_selectedArea == "Click on Me")
                    const Icon(Icons.touch_app_outlined),
                  if (_selectedArea == "Click on Me")
                    const SizedBox(
                      width: 20,
                    ),
                  Text(_selectedArea,
                      style: TextStyle(
                        color: _selectedArea == "Click on Me"
                            ? Theme.of(context).disabledColor
                            : Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: Dimensions.font20,
                      )),
                ],
              ),
            ),
          );
        });
  }
}

_showListOfArea(BuildContext context, selectedPujariController) async {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: ((context, setState) {
          return Center(
              child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius20),
            ),
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width * 0.85,
            child: ListView.builder(
              itemCount: name.length,
              itemBuilder: ((context, index) {
                return Material(
                  child: RadioListTile(
                    value: name[index],
                    groupValue: _selectedArea,
                    onChanged: (value) async {
                      setState(() {
                        _selectedArea = value.toString();
                        selectedPujariController.sink.add(_selectedArea);
                      });
                      await Future.delayed(const Duration(milliseconds: 300));
                      Navigator.pop(context);
                    },
                    title: BigText(text: name[index]),
                  ),
                );
              }),
            ),
          ));
        }),
      );
    },
  );
}
