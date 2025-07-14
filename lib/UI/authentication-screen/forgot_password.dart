import 'package:flutter/material.dart';
import 'package:luneta/provider/authentication-provider/forgot_password_password.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordProvider(),
      child: Consumer<ForgotPasswordProvider>(
        builder: (context, countryProvider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              bottomNavigationBar: Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: customButton(
                  voidCallback:
                  (){
                    if (countryProvider.selectedRoleIndex != -1) {
                      Navigator.of(context).pushNamed(otpScreen);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please Select One Detail.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  buttonText: "Continue",
                  width: 90.w,
                  height: 4.h,
                  color: countryProvider.selectedRoleIndex != -1
                      ? AppColors.buttonColor
                      : AppColors.Color_BDBDBD, // Change color dynamically
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: countryProvider.selectedRoleIndex != -1,
                ),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w,).copyWith(bottom: 0.h,top: 1.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      backButtonWithTitle(
                        title: "Forgot Password",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 2.h),
                      Image.asset(
                        "assets/images/SheildImg.png", // Update the path to your logo
                        height: 30.h, // Adjust logo size
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Select which contact details should we use to reset your password",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.Color_212121,
                            fontFamily: AppColors.fontFamilyMedium,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          countryProvider.roles.length,
                              (index) {
                            return GestureDetector(
                              onTap: () {
                                countryProvider.updateSelectedRole(index); // Update role
                              },
                              child: Container(
                                padding: EdgeInsets.all(2.h),
                                alignment: Alignment.center,
                                width: 90.w,
                                height: 15.h, // Set a specific height for the card
                                margin: EdgeInsets.only(bottom: 5.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(
                                    color: countryProvider.selectedRoleIndex == index
                                        ? AppColors.buttonColor
                                        : AppColors.Color_EEEEEE,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 9.h,
                                      width: 9.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                        color: AppColors.Color_607D8B
                                            .withOpacity(0.14),
                                      ),
                                      padding: EdgeInsets.all(2.h),
                                      child: Image.asset(
                                        countryProvider.roles[index]['icon']!,
                                        width: 5.h,
                                        height: 5.h,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                      width: 4.w,
                                    ),
                                    // Role title
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          countryProvider.roles[index]['title']!,
                                          style: TextStyle(
                                            fontSize:  AppFontSize.fontSize14,
                                            color: AppColors.Color_757575,
                                            fontFamily: AppColors.fontFamily,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        // Role subtitle
                                        Text(
                                          textAlign: TextAlign.center,
                                          countryProvider.roles[index]['subtitle']!,
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.Color_212121,
                                            fontFamily: AppColors.fontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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
