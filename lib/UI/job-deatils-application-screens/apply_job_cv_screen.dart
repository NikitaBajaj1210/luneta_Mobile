import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:luneta/provider/job-details-application-provider/apply_job_cv_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Utils/validation.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';
import '../../custom-component/customMultiLineTextField.dart';
import '../../custom-component/customTextField.dart';
class ApplyJobCvScreen extends StatefulWidget {
  const ApplyJobCvScreen({super.key});

  @override
  State<ApplyJobCvScreen> createState() => _ApplyJobCvScreenState();
}

class _ApplyJobCvScreenState extends State<ApplyJobCvScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApplyJobCvProvider(),
      child: Consumer<ApplyJobCvProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              bottomNavigationBar: Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.bottomNavBorderColor),
                ),
                child: customButton(
                  voidCallback: () {
                    showCustomDialogWithLoader(context);
                    // _showApplyJobBottomSheet(context,jobDetailsProvider);
                    // Navigator.of(context).pushNamed('');
                    // Handle button click action
                  },
                  buttonText: "Submit",
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
                color: AppColors.Color_FFFFFF,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h).copyWith(bottom: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with Back Button and Actions
                      backButtonWithTitle(
                        title: "Apply Job",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Full Name",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color:AppColors.Color_424242,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      customTextField(
                        context: context,
                        focusNode: provider.nameFocusNode,
                        controller: provider.nameController,
                        hintText: 'Full Name',
                        textInputType: TextInputType.name,
                        obscureText: false,
                        voidCallback: validateName,
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        backgroundColor: provider.nameFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: Colors.black,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.Color_212121,
                        fillColor: provider.nameFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(provider.emailFocusNode);
                        },
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color:AppColors.Color_424242,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      customTextField(
                        context: context,
                        focusNode: provider.emailFocusNode,
                        controller: provider.emailController,
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                        voidCallback: validateEmail,
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        backgroundColor: provider.emailFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: Colors.black,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.Color_212121,
                        suffixIcon: Image.asset(
                          "assets/images/emailIcon.png",
                          width: 2.5.h,
                          height: 2.5.h,
                          color: provider.emailFocusNode.hasFocus
                              ? AppColors.buttonColor
                              : (provider.emailController.text.isNotEmpty
                              ? AppColors.Color_212121
                              : AppColors.Color_BDBDBD),
                        ),
                        fillColor: provider.emailFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        "Upload CV/Resume",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color:AppColors.Color_424242,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      GestureDetector(
                        onTap: () async {
                          await provider.pickPdfFile();
                        },
                        child: provider.isUploading
                            ? DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(15),
                          dashPattern: [10, 10],
                          color: AppColors.Color_BDBDBD,
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
                                LoadingAnimationWidget.hexagonDots(
                                  color: AppColors.buttonColor,
                                  size: 5.h,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "Uploading...",
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.buttonColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                            : provider.fileName != null
                            ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.colorRed,
                            borderRadius: BorderRadius.circular(1.h),
                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/Paper.png", height: 3.5.h,color: Colors.red,),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.fileName!,
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.Color_424242,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      provider.fileSize,
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize12,
                                        color: AppColors.Color_424242.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: provider.removeFile,
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.errorRedColor,
                                  size: 2.5.h,
                                ),
                              ),
                            ],
                          ),
                        )
                            : DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(15),
                          dashPattern: [10, 10],
                          color: AppColors.Color_BDBDBD,
                          strokeWidth: 1,
                          child: Container(
                            width: 100.w,
                            padding: EdgeInsets.symmetric(vertical: 3.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h),
                              color: AppColors.Color_FAFAFA,
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset("assets/images/Upload.png",height: 5.h,),
                                  Text(
                                    "Browse File",
                                    style: TextStyle(
                                      fontSize: AppFontSize.fontSize14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.buttonColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        "Motivation Letter (Optional)",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color:AppColors.Color_424242,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      customMultilineTextField(
                        maxLines:5,
                        context: context,
                        controller: provider.motivationLetterController,
                        hintText: 'Motivation letter...',
                        textInputType: TextInputType.multiline,
                        validator: (value) => value!.isEmpty ? 'This field cannot be empty' : null,
                        borderColor: AppColors.buttonColor,
                        textColor: Colors.black,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.Color_212121,
                        fillColor: provider.nameFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                      ),

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

void showCustomDialogWithLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
        child: Container(
          width: 100.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: AppColors.introBackgroundColor,
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/CvUploadImg.png",
                height: 20.h,
                width: 100.w,
              ),
              SizedBox(height: 3.h),
              Text(
                "Congratulations!",
                style: TextStyle(
                  fontSize: AppFontSize.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppColors.fontFamilyBold,
                  color: AppColors.buttonColor,
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                "Your application has been successfully submitted. You can track the progress of your application through the applications menu.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppColors.fontFamilyRegular,
                    color: AppColors.Color_212121,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              customButton(
                voidCallback: () {
                  Navigator.pop(context);
                },
                buttonText: "Go to My Applications",
                width: 65.w,
                height: 7.h,
                color: AppColors.buttonColor,
                buttonTextColor: AppColors.Color_FFFFFF,
                shadowColor: AppColors.buttonBorderColor,
                fontSize: AppFontSize.fontSize16,
                showShadow: true,
              ),
              SizedBox(height: 3.h),
              customButton(
                voidCallback: () {
                  Navigator.pop(context);
                },
                buttonText: "Cancel",
                width: 65.w,
                height: 7.h,
                color: AppColors.applyCVButtonColor,
                buttonTextColor: AppColors.buttonColor,
                shadowColor: AppColors.buttonBorderColor,
                fontSize: AppFontSize.fontSize16,
                showShadow: false,
              ),
            ],
          )));
    },
  );
}

/*
void showCustomDialogWithLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
        child: Container(
          width: 100.w,
          height: 68.h,
          decoration: BoxDecoration(
            color: AppColors.introBackgroundColor,
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/errorPopUpImg.png",
                height: 20.h,
                width: 80.w,
              ),
              SizedBox(height: 3.h),
              Text(
                "Oops, Failed!",
                style: TextStyle(
                  fontSize: AppFontSize.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppColors.fontFamilyBold,
                  color: AppColors.errorRedColor,
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  "Please check your internet connection then try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppColors.fontFamilyRegular,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              customButton(
                voidCallback: () {
                },
                buttonText: "Try Again",
                width: 65.w,
                height: 7.h,
                color: AppColors.buttonColor,
                buttonTextColor: AppColors.bgColor,
                shadowColor: AppColors.buttonBorderColor,
                fontSize: AppFontSize.fontSize16,
                showShadow: true,
              ),
              SizedBox(height: 3.h),
              customButton(
                voidCallback: () {
                },
                buttonText: "Cancel",
                width: 65.w,
                height: 7.h,
                color: AppColors.applyCVButtonColor,
                buttonTextColor: AppColors.buttonColor,
                shadowColor: AppColors.buttonBorderColor,
                fontSize: AppFontSize.fontSize16,
                showShadow: false,
              ),
            ],
          )));
    },
  );
}
*/

