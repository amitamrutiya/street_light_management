import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:street_light_management/constant/app_colors.dart';

class DatePickerFiled extends StatefulWidget {
  final TextEditingController pickDateController;
  final String lable;

  const DatePickerFiled(
      {Key? key, required this.pickDateController, required this.lable})
      : super(key: key);

  @override
  State<DatePickerFiled> createState() => _DatePickerFiledState();
}

class _DatePickerFiledState extends State<DatePickerFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      controller: widget.pickDateController,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: AppColors.primaryDarkColor),
        ),
        labelText: widget.lable,

        suffixIcon: IconButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2023),
            );
            if (newDate == null) return;
            setState(() {
              widget.pickDateController.text =
                  DateFormat('dd/MM/yyyy').format(newDate);
            });
          },
          icon: const Icon(Icons.date_range),
          color: AppColors.primaryDarkColor,
        ),
        // prefixIcon: Icon(
        //   Icons.timer,
        //   color: AppColors.secondryDarkColor,
        // ),
        hintText: "DD/MM/YYYY",
        border: const OutlineInputBorder(),
      ),
      cursorColor: AppColors.primaryDarkColor,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please choose a date';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          widget.pickDateController.text = value!;
        });
      },
    );
  }
}
