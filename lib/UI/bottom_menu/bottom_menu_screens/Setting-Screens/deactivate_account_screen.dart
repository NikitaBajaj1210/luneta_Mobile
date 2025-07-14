import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart'; // Adjust import as needed
import '../../../../custom-component/custom-button.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/deactivate_account_provider.dart';

class DeactivateAccountScreen extends StatelessWidget {
  const DeactivateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeactivateAccountProvider(),
      child: Consumer<DeactivateAccountProvider>(
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
                   },
                  buttonText: "Deactivate",
                  width: 90.w,
                  height: 4.h,
                  color:AppColors.errorRedColor,
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: false,
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h).copyWith(top: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Back Button and Title
                      backButtonWithTitle(
                        title: "",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Deactivate Account?',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize32,
                          fontWeight:FontWeight.w700,
                          fontFamily: AppColors.fontFamilyBold,
                          color: AppColors.Color_212121,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        alignment: Alignment.center,
                        child: Text(
                          'You will lose all completed profiles and also all your job applications.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.Color_212121,
                            fontFamily: AppColors.fontFamilyRegular,
                          ),
                        ),
                      ),
                      // Description Text

                      SizedBox(height: 1.5.h),
                      _buildApplicationsNotifications(provider),

                      SizedBox(height: 1.h),


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

Widget _buildApplicationsNotifications(DeactivateAccountProvider model) {
  return ListView.separated(
    itemCount: model.application.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final application = model.application[index];
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Container(
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.h),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(1.5.h),
                    margin: EdgeInsets.only(bottom: 2.h,right: 0.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1.8.h)),
                        border: Border.all(
                          width: 0.1.h,color: AppColors.Color_EEEEEE,
                        )),
                    child:  Image.asset(
                      application['image'],
                      width: 5.h,
                      height: 5.h,
                      fit: BoxFit.cover,
                    )),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          application["position"]!,
                          style: TextStyle(
                              fontSize: AppFontSize.fontSize20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.Color_212121,
                              fontFamily: AppColors.fontFamilyBold
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          application["company"]!,
                          style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.Color_616161,
                              fontFamily: AppColors.fontFamilyMedium
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                          decoration: BoxDecoration(
                            color: application["status"] == "Accepted"
                                ? AppColors.colorGreen
                                : AppColors.cardIconBgColour,
                            borderRadius: BorderRadius.circular(0.5.h),
                          ),
                          child: Text(
                            application["status"] == "Accepted"
                                ? "Application Accepted"
                                : "Application Sent",
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize12,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppColors.fontFamilySemiBold,
                              color: application["status"] == "Accepted"
                                  ? AppColors.successColor
                                  : AppColors.buttonColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.h,),
                    child: GestureDetector(
                      onTap: (){

                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 2.h,
                        color: AppColors.Color_212121,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    separatorBuilder: (context, index) => Divider(
      height: 1.h,
      color: AppColors.Color_EEEEEE,
    ),
  );
}
