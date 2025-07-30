import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:luneta/const/font_size.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../const/color.dart';
import '../../custom-component/custom-button.dart';
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
          child: PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
          if (didPop) return;
          bool? exitConfirmed =
              await
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.Color_212121),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.only(
                              top: 1.h, left: 3.w, right: 3.w, bottom: 3.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 2.h),
                              Text(
                                'Are you sure, you want to close the app ?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: AppColors.Color_212121,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.px,
                                ),
                              ),
                              SizedBox(height: 3.5.h),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.5.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 25.w,
                                          child: customButton(
                                            fontSize: 15.sp,
                                            voidCallback: () async {
                                              Navigator.of(context).pop();
                                            },
                                            buttonText: 'No',
                                            width: 45.w,
                                            height: 5.h,
                                            color: AppColors.Color_607D8B,
                                            shadowColor: AppColors.Color_607D8B,
                                            buttonTextColor: AppColors.Color_FFFFFF,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 25.w,
                                          child: customButton(
                                            fontSize: 15.sp,
                                            voidCallback: () async {
                                              Navigator.pop(context);
                                              exit(0);
                                            },
                                            buttonText: 'Yes',
                                            width: 45.w,
                                            height: 5.h,
                                            color: AppColors.Color_607D8B,
                                            shadowColor: AppColors.Color_607D8B,
                                            buttonTextColor: AppColors.Color_FFFFFF,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          );
          if (exitConfirmed == true && context.mounted) {
            Navigator.pop(context);
            exit(0);
          }},

            child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              extendBody: true,
              bottomNavigationBar: _buildBottomNavigationBar(provider),
              body: SingleChildScrollView(child: provider.getSelectedScreen(provider)), // Render the selected screen
            ),
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
