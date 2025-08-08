import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime initialDate;
  final String addDate;
  final String hintText;
  final String addDateApi;
  final double width;
  final VoidCallback onTap;
  final Function(DateTime?)? onDateSelected;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;

  const CustomDatePicker({
    super.key,
    required this.initialDate,
    required this.addDate,
    required this.hintText,
    required this.addDateApi,
    required this.width,
    required this.onTap,
    this.onDateSelected,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColors.Color_FAFAFA,
        borderRadius: BorderRadius.circular(2.h),
        border: Border.all(
          width: 1,
          color: borderColor,
        ),
      ),
      child: FormField<String>(
        validator: validator,
        autovalidateMode: autovalidateMode,
        builder: (FormFieldState<String> state) {
          return GestureDetector(
            onTap: onTap,
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 4.w),
                border: InputBorder.none,
                errorStyle: TextStyle(
                  color: AppColors.errorRedColor,
                  fontSize: AppFontSize.fontSize12,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    addDate,
                    style: TextStyle(
                      fontSize: AppFontSize.fontSize16,
                      color: addDate == 'Date of Birth'?AppColors.Color_9E9E9E:textColor,
                      fontFamily:addDate == 'Date of Birth'?AppColors.fontFamilyRegular: textColor == AppColors.Color_9E9E9E
                          ? AppColors.fontFamilyRegular
                          : AppColors.fontFamilySemiBold,
                      fontWeight:addDate == 'Date of Birth'?FontWeight.w400: textColor == AppColors.Color_9E9E9E ? FontWeight.w400 : FontWeight.w600,
                    ),
                  ),
                  Image.asset(
                    'assets/images/CalendarIcon.png',
                    height: 2.5.h,
                    color: iconColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}