import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/09-profile-screens-provider/travel_document_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provider/09-profile-screens-provider/travel_document_provider.dart';

class TravelDocuments extends StatefulWidget {
  const TravelDocuments({super.key});

  @override
  State<TravelDocuments> createState() => _TravelDocumentsState();
}

class _TravelDocumentsState extends State<TravelDocuments> {

  @override
  Widget build(BuildContext context) {
    return Consumer<TravelDocumentProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.Color_FFFFFF,
                  bottomNavigationBar: Container(
                    height: 11.h,
                    width: 100.w,
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: AppColors.bottomNavBorderColor),
                    ),
                    child: customButton(
                      voidCallback: () {
                        // Save the data in provider or update the profile here
                        Navigator.pop(context);
                      },
                      buttonText: "Save",
                      width: 90.w,
                      height: 4.h,
                      color: AppColors.buttonColor,
                      buttonTextColor: AppColors.buttonTextWhiteColor,
                      shadowColor: AppColors.buttonBorderColor,
                      fontSize: AppFontSize.fontSize18,
                      showShadow: true,
                    ),
                  ),
                  body: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Back Button and Title
          backButtonWithTitle(
          title: "Travel Documents & Credentials",
          onBackPressed: () {
          Navigator.pop(context);
          },
          ),
          SizedBox(height: 2.h),
          ]
          )
          )
                  )
              )
          );
        });
  }
}
