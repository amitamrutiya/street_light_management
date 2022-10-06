import 'package:flutter/material.dart';
import 'package:street_light_management/constant/app_colors.dart';

class ThreeBulbInRow extends StatefulWidget {
  const ThreeBulbInRow({
    Key? key,
  }) : super(key: key);

  @override
  State<ThreeBulbInRow> createState() => _ThreeBulbInRowState();
}

bool _onTap = false;
bool get onTap => _onTap;

class _ThreeBulbInRowState extends State<ThreeBulbInRow> {
  @override
  void initState() {
    if (_onTap == true) _onTap = false;
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
              icon: onTap
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
      _onTap = !_onTap;
    });
  }
}
