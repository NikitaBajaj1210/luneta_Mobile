import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../const/color.dart';
import '../const/font_size.dart';

Widget customButton({
  required VoidCallback? voidCallback,
  required String buttonText,
  required double width,
  required double height,
  String? amt,
  required Color? color,
  required Color? buttonTextColor,
  required Color shadowColor,
  required double fontSize,
  bool useGradient = false,
  bool useBorder = false,
  bool showShadow = true,
  Key? key,
}) {
  return GestureDetector(
    onTap: voidCallback,
    child: Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: useGradient ? null : color,
        gradient: useGradient
            ? const LinearGradient(
          colors: [Color(0xFF4D3465), Color(0xFF7B5B9A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
        borderRadius: BorderRadius.circular(5.h),
        boxShadow: showShadow
            ? [
          BoxShadow(
            color: shadowColor.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(4, 8),
            spreadRadius: 0,
          ),
        ]
            : [],
        border: useBorder
            ? Border.all(color: AppColors.buttonBorderColor)
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style: TextStyle(
              color: buttonTextColor,
              fontSize: fontSize,
              fontFamily: AppColors.fontFamilyBold,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (amt != null) ...[
            SizedBox(width: width * 0.05),
            Text(
              amt,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: AppColors.fontFamilyBold,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}