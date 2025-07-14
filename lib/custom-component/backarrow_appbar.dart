import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../const/color.dart';

PreferredSizeWidget backArrowAppBar
    ({
  required VoidCallback? onTapAction,
  required double?  size,
  String? label=""
}) {
  return AppBar(
    backgroundColor: AppColors.introBackgroundColor,
    titleSpacing: 0.0, // Removes spacing around the title
    leading: IconButton(
      padding: EdgeInsets.zero,
      onPressed:onTapAction,
      icon: Icon(
        Icons.arrow_back_ios_new,
        size: 2.5.h,
      ),

    ),
    centerTitle: false,
  );
}