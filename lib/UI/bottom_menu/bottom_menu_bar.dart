import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:luneta/const/font_size.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../const/color.dart';
import '../../provider/bottom_menu_provider/bottom_menu_provider.dart';
class BottomMenuBar extends StatefulWidget {
  const BottomMenuBar({super.key});

  @override
  State<BottomMenuBar> createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<BottomMenuProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            extendBody: true,
            bottomNavigationBar: _buildBottomNavigationBar(provider),
            body: SingleChildScrollView(child: provider.getSelectedScreen(provider)), // Render the selected screen
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BottomMenuProvider provider) {
    return Container(
      height: Platform.isIOS ? 9.5.h : 8.h,
      padding: Platform.isIOS
          ? EdgeInsets.only(left: 5.w, right: 5.w).copyWith(bottom: 1.h)
          : EdgeInsets.only(left: 2.5.w, right: 2.5.w, bottom: 1.h),
      color: AppColors.introBackgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildNavItem(provider, 0),
          _buildNavItem(provider, 1),
          _buildNavItem(provider, 2),
          _buildNavItem(provider, 3),
          _buildNavItem(provider, 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(BottomMenuProvider provider, int index) {
    bool isSelected = provider.selectedIndex == index;
    String iconPath = isSelected ? provider.selectedIcons[index]! : provider.unselectedIcons[index]!;

    return GestureDetector(
      onTap: () {
        provider.updateSelectedIndex(index);
        if (kDebugMode) {
          print("object");
        }// Navigate to the selected index
        setState(() {

        });
      },
      child: Container(
        width: 8.h,
        padding: EdgeInsets.only(top: 1.h),
        child: Column(
          children: [
            Image.asset(
              iconPath,
              height: 2.5.h,
              width: 2.5.h,
            ),
            SizedBox(height: 1.h),
            Text(
              provider.tabNames[index],
              style: TextStyle(
                color: isSelected ? AppColors.buttonColor : AppColors.Color_BDBDBD,
                fontSize: AppFontSize.fontSize10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
