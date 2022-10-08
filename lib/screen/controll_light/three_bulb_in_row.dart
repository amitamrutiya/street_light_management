import 'package:flutter/material.dart';
import 'package:street_light_management/constant/app_colors.dart';

class ThreeBulbInRow extends StatefulWidget {
  bool?checkBoxListTileValue = false;
   ThreeBulbInRow({
    this.checkBoxListTileValue,
    Key? key,
  }) : super(key: key);

  @override
  State<ThreeBulbInRow> createState() => _ThreeBulbInRowState();
}

// bool onTap = false;
bool  onTap =false;

class _ThreeBulbInRowState extends State<ThreeBulbInRow> {
  @override
  void initState() {
    if (onTap == true) onTap = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.lightbulb_outline,
              size: 30,
            ),
            onPressed: () {},
          ),
          const Icon(
            Icons.remove,
            size: 30,
          ),
          Center(
            child: IconButton(
              iconSize: 45,
              icon: widget.checkBoxListTileValue!=false?const Icon(Icons.lightbulb,size: 45,color: Colors.red,): onTap
                  ? const Icon(
                      Icons.lightbulb,
                      size: 45,
                      color: AppColors.deepPurplecolor,
                    )
                  : const Icon(
                      Icons.lightbulb_outline,
                      size: 30,
                    ),
              onPressed: () {
                toogleOnTap();
              },
            ),
          ),
          const Icon(
            Icons.remove,
            size: 30,
          ),
          IconButton(
            icon: const Icon(
              Icons.lightbulb_outline,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void toogleOnTap() {
    setState(() {
      onTap = !onTap;
    });
  }
}
