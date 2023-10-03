import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'button.dart';

class CustomDatePickerScreen extends StatefulWidget {
  final Function(DateTime?) onTap;
  const CustomDatePickerScreen({Key? key, required this.onTap})
      : super(key: key);

  @override
  State<CustomDatePickerScreen> createState() => _CustomDatePickerScreenState();
}

class _CustomDatePickerScreenState extends State<CustomDatePickerScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.06,
          ),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                selectedDate = newDateTime;
                if (kDebugMode) {
                  print(selectedDate?.month);
                }
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          Button(
              backgroundColor: AppColors().primary,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
                widget.onTap(selectedDate);
              },
              isLoading: false,
              title: "Select")
        ],
      ),
    );
  }
}
