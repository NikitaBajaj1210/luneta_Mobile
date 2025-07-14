import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:luneta/const/color.dart';
import 'package:luneta/const/font_size.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:luneta/custom-component/custom-button.dart';

import '../../../../custom-component/back_button_with_title.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/cv_resume_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class CVResumeScreen extends StatelessWidget {
  const CVResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CVResumeProvider(),
      child: Consumer<CVResumeProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                ),
                child: customButton(
                  voidCallback: () {
                    final profileProvider = Provider.of<ProfileBottommenuProvider>(context, listen: false);

                    // Validate if a file is selected
                    if (provider.selectedFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please upload a CV/Resume')),
                      );
                      return;
                    }

                    // Add CV/Resume to profile provider
                    // profileProvider.setCVResume(provider.selectedFile);

                    // Navigate back to Profile Screen after saving the data
                    Navigator.pop(context);
                  },
                  buttonText: "Save",
                  width: 90.w,
                  height: 5.h,
                  color: AppColors.buttonColor,
                  buttonTextColor: Colors.white,
                  shadowColor: Colors.blueAccent,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: true,
                ),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          backButtonWithTitle(
                            title: "CV/Resume",
                            onBackPressed: () => Navigator.pop(context),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset("assets/images/Delete.png",
                                height: 24),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      // Upload CV Section
                      Text(
                        "Upload CV/Resume",
                        style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242),
                      ),
                      SizedBox(height: 1.h),
                      GestureDetector(
                        onTap: () async {
                          await provider.pickPdfFile();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(15),
                          dashPattern: [10, 10],
                          color: AppColors.buttonColor,
                          strokeWidth: 1,
                          child: Container(
                            width: 100.w,
                            padding: EdgeInsets.symmetric(vertical: 3.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h),
                              color: AppColors.Color_FAFAFA,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/Upload.png", height: 5.h),
                                SizedBox(height: 1.h),
                                Text(
                                  "Browse File",
                                  style: TextStyle(
                                      fontSize:AppFontSize.fontSize14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppColors.fontFamilySemiBold,
                                      color: AppColors.Color_9E9E9E),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),

                      // Display uploaded file name and size (if a file is selected)
                      provider.fileName != null
                          ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(1.h),
                        ),
                        child: Row(
                          children: [
                            Image.asset("assets/images/pdfIcon.png",height: 3.5.h,),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.fileName!,
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.Color_212121,
                                        fontFamily:
                                        AppColors.fontFamilyBold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    provider.fileSize,
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize12,
                                        color: AppColors.Color_616161,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                        AppColors.fontFamilyMedium),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: provider.removeFile,
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
