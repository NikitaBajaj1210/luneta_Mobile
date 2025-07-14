import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../const/color.dart';
import '../const/font_size.dart';

Widget customDatePicker({
  DateTime? initialDate, // Make optional
  String? addDate, // Make optional
  String? addDateApi, // Make optional
  Color? borderColor,
  Color? dateColour,
  required double width,
  required Function onTap,
  Widget? icon, // Optional icon parameter
  bool isTimePicker = false, // New parameter to indicate date or time picker
  String? hintText, // Added hintText parameter
  bool hasFocus = false, // Added to handle focused state
  Color? focusedBorderColor, // Added to specify focused border color
  bool hasBorder = true, // Added to control border visibility
  Color? backgroundColor, // Added to control background color
}) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Center(
      child: Container(
        height: 6.2.h,
        width: width,
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(1.h),
          color: backgroundColor ?? Colors.transparent, // Apply background color
          border: hasBorder
              ? Border.all(
            color: hasFocus ? (focusedBorderColor ?? borderColor!) : borderColor!,
            width: 1.5,
          )
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                addDate != null && addDate.isNotEmpty
                    ? addDate
                    : (hintText ?? (isTimePicker ? '' : 'dd/mm/yyyy')),
                style: TextStyle(
                  fontFamily: addDate != null && addDate.isNotEmpty && addDate !='Date of Birth'
                      ? AppColors.fontFamilySemiBold
                      : AppColors.fontFamilyRegular, // Use fontFamilyRegular for hint
                  color: addDate != null && addDate.isNotEmpty&& addDate !='Date of Birth'
                      ? (dateColour ?? AppColors.Color_212121)
                      : AppColors.Color_9E9E9E, // Lighter color for hint text
                  fontSize: addDate != null && addDate.isNotEmpty&& addDate !='Date of Birth'
                      ? AppFontSize.fontSize15
                      : AppFontSize.fontSize16, // Use fontSize16 for hint
                  fontWeight: addDate != null && addDate.isNotEmpty&& addDate !='Date of Birth'
                      ? null // Default weight for selected date
                      : FontWeight.w400, // Use w400 for hint
                ),
              ),
            ),
            icon ??
                Image.asset(
                  "assets/images/CalendarIcon.png",
                  color: const Color(0xffCACACA),
                  width: 5.w,
                  height: 10.h,
                ),
          ],
        ),
      ),
    ),
  );
}

Future<void> selectTime(BuildContext context, Function(String) onTimeSelected) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );
    },
  );

  if (picked != null) {
    final now = DateTime.now();
    final DateTime selectedTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
    final String formattedTime = DateFormat('hh:mm a').format(selectedTime); // Format time to include AM/PM
    onTimeSelected(formattedTime); // Update the time
  }
}