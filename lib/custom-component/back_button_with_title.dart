import 'package:flutter/material.dart';
import 'package:luneta/const/font_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../const/color.dart';

Widget backButtonWithTitle({
  required String title,
  required VoidCallback onBackPressed,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: onBackPressed,
        child: Image.asset(
          "assets/images/ArrowLeft.png",
          height: 3.h,
        ),
      ),
      SizedBox(height: 3.h, width: 4.w,),
      Text(
        title,
        style: TextStyle(
            fontSize: AppFontSize.fontSize24, // Responsive font size
          fontWeight: FontWeight.w700,
          color: AppColors.Color_212121,
          fontFamily: AppColors.fontFamilyBold
        ),
      ),
    ],
  );
}


Widget backButtonWithCrossIcon({
  required String title,
  required VoidCallback onBackPressed,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: onBackPressed,
        child: Image.asset(
          "assets/images/closeIcon.png",
          height: 3.h,
        ),
      ),
      SizedBox(height: 3.h, width: 4.w,),
      Text(
        title,
        style: TextStyle(
            fontSize: AppFontSize.fontSize24, // Responsive font size
            fontWeight: FontWeight.w700,
            color: AppColors.Color_212121,
            fontFamily: AppColors.fontFamilyBold
        ),
      ),
    ],
  );
}