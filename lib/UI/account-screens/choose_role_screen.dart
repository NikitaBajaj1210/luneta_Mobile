import 'package:flutter/material.dart';
import 'package:luneta/network/network_helper.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';
import '../../provider/account-provider/choose_country_provider.dart';
class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});
  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChooseCountryProvider(),
      child: Consumer<ChooseCountryProvider>(
        builder: (context, countryProvider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              bottomNavigationBar: Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color:AppColors.bottomNavBorderColor),
                ),
                child: customButton(
                  voidCallback: (){
                    if (countryProvider.selectedRoleIndex != -1) {
                      // Navigate to next screen (country data is already in global provider)
                      Navigator.of(context).pushNamed(chooseRank);
                    } else {
                      ShowToast("Error", 'Please Select One Job Role.');
                    }
                  },
                  buttonText: "Continue",
                  width: 90.w,
                  height: 4.h,
                  color: countryProvider.selectedRoleIndex == -1
                      ? AppColors.Color_BDBDBD // Disabled color
                      : AppColors.buttonColor, // Active color
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: countryProvider.selectedRoleIndex == -1 ? false:true,
                ),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h).copyWith(top: 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    SizedBox(height: 3.h),
                backButtonWithTitle(
                  title: "",
                  onBackPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 5.h),
                Image.asset(
                  "assets/images/LunetaLogo.png", // Update the path to your logo
                  height: 2.h, // Adjust logo size
                ),
                // Title text
                SizedBox(height: 6.h),
                Text(
                  "Choose Your Role",
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize32,
                    fontWeight:FontWeight.w700,
                    fontFamily: AppColors.fontFamilyBold,
                    color: AppColors.Color_212121,
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  alignment: Alignment.center,
                  child: Text(
                    "Decide whether you're seeking a job or representing a Company looking to hire seafarers",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppFontSize.fontSize18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.Color_212121,
                      fontFamily: AppColors.fontFamilyRegular,
                    ),
                  ),
                ),
                      Container(
                  margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
                  height: 0.1.h,
                  color: AppColors.Color_EEEEEE,
                  width: 100.w,
                ),
                // Two cards for selection
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(countryProvider.roles.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // countryProvider.selectedRoleIndex = index; // Set selected card
                          });
                        },
                        child: Container(
                          width: 42.w,
                          height: 33.h, // Set a specific height for the card
                          margin: EdgeInsets.only(right: 4.w),
                          decoration: BoxDecoration(
                            // color: selectedRoleIndex == index
                            //     ? AppColors.buttonColor
                            //     : AppColors.cardBorderColorInactive,
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(
                              color: countryProvider.selectedRoleIndex == index
                                  ? AppColors.buttonColor
                                  : AppColors.Color_EEEEEE,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Role icon
                              SizedBox(height: 3.h),
                              Container(
                                height: 10.h,
                                width: 10.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  color:countryProvider.selectedRoleIndex != index
                                      ? AppColors.chooseRoleIconColour:AppColors.chooseRoleActiveIconColour,
                                ),
                                padding: EdgeInsets.all(2.9.h),
                                child: Image.asset(
                                  countryProvider.roles[index]['icon']!,
                                  width: 5.h,
                                  height: 5.h,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              // Role title
                              SizedBox(
                                width: 30.w,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  countryProvider.roles[index]['title']!,
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.Color_212121,
                                    fontFamily: AppColors.fontFamilyBold
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.5.h),
                              // Role subtitle
                              SizedBox(
                                width: 25.w,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  countryProvider.roles[index]['subtitle']!,
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize14,
                                    color: AppColors.Color_757575,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    fontWeight:FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
              ],
            ),
            ),
            ),
          );
        },
      ),
    );
  }
}