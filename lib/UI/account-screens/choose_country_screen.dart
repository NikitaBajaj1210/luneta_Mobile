import 'dart:io';

import 'package:flutter/material.dart';
import 'package:luneta/const/font_size.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../../const/color.dart';
import '../../custom-component/custom-button.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/customTextField.dart';
import '../../provider/account-provider/choose_country_provider.dart';

class ChooseCountryScreen extends StatefulWidget {
  const ChooseCountryScreen({super.key});

  @override
  State<ChooseCountryScreen> createState() => _ChooseCountryScreenState();
}

class _ChooseCountryScreenState extends State<ChooseCountryScreen> {
  // FocusNode for the search text field


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChooseCountryProvider(),
      child: Consumer<ChooseCountryProvider>(
        builder: (context, countryProvider, child) {
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
                backgroundColor: AppColors.Color_FFFFFF,
                bottomNavigationBar: Container(
                  height: 11.h,
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color:AppColors.bottomNavBorderColor),
                  ),
                  child: customButton(
                    voidCallback: () {
                      if (countryProvider.selectedCountryIndex != -1) {
                        // Get the selected country
                        final selectedCountry = countryProvider.selectedCountry;
                        if (selectedCountry != null) {
                          // Set global country data
                          ChooseCountryProvider.setGlobalSelectedCountry(
                            selectedCountry.name,
                            selectedCountry.code,
                          );
                          print("Global country set: ${selectedCountry.name}, ${selectedCountry.code}");

                          // Navigate to next screen (no need to pass arguments)
                          countryProvider.searchController.clear();
                          Navigator.of(context).pushNamed(chooseRole);
                        }
                      } else {
                        print("please select");
                      }
                    },
                    buttonText: "Continue",
                    width: 90.w,
                    height: 4.h,
                    color: countryProvider.selectedCountryIndex==-1
                        ? AppColors.Color_BDBDBD
                        : AppColors.buttonColor,
                    buttonTextColor: AppColors.buttonTextWhiteColor,
                    shadowColor: AppColors.buttonBorderColor,
                    fontSize: AppFontSize.fontSize18,
                    showShadow:  countryProvider.selectedCountryIndex==-1 ? false:true,
                  ),
                ),
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w,).copyWith(top: 0.h),
                  color: AppColors.Color_FFFFFF,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      backButtonWithTitle(
                        title: "Your Country",
                        onBackPressed: () {
                          // Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 2.h),
                      customTextField(
                        context: context,
                        focusNode: countryProvider.searchFocusNode,
                        controller: countryProvider.searchController,
                        hintText: 'Search',
                        textInputType: TextInputType.text,
                        obscureText: false,
                        voidCallback: null,
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        iconSize: AppFontSize.fontSize20,
                        // FontFamily:AppColors.fontFamilyRegular,
                        fillColor: countryProvider.searchFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.bottomNavBorderColor,
                        borderColor: AppColors.buttonColor,
                        textColor: AppColors.Color_212121,
                        labelColor: AppColors.Color_BDBDBD,
                        cursorColor: AppColors.Color_212121,
                        prefixIcon: Image.asset(
                          "assets/images/Search.png",
                          width: 2.h,
                          height: 2.h,
                          color: countryProvider.searchFocusNode.hasFocus
                              ? AppColors.buttonColor
                              : (countryProvider.searchController.text.isNotEmpty
                              ? AppColors.Color_212121
                              : AppColors.Color_BDBDBD),
                        ),
                        onPrefixIconPressed: () {
                          // Handle prefix icon press if needed
                        },
                        onChange: (value) {
                          countryProvider.updateSearchQuery(value.toString().trim());
                          setState(() {}); // Update the UI on input change
                          // Remove focus if input exceeds 3 words
                          if (value.split(' ').length > 3) {
                            countryProvider.searchFocusNode.unfocus();
                          }
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                          // Handle country field submitted if needed
                        },
                      ),
                    SizedBox(height: 1.h,),

                      Expanded(
                        child: countryProvider.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.buttonColor,
                                ),
                              )
                            : ListView.builder(
                                itemCount: countryProvider.filteredCountries.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  final country = countryProvider.filteredCountries[index];
                                  return Material(
                                    color: Colors.transparent,
                                    child: GestureDetector(
                                      onTap: () {
                                        countryProvider.updateSelectedCountry(index);
                                        FocusScope.of(context).unfocus();
                                      },
                                                                                                              child: Container(
                                        height: 6.3.h,
                                        // padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                                        margin: EdgeInsets.symmetric(vertical: 0.2.h),
                                        // decoration: BoxDecoration(
                                        //   color: countryProvider.selectedCountryIndex == index
                                        //       ? AppColors.buttonColor.withOpacity(0.1)
                                        //       : Colors.transparent,
                                        //   borderRadius: BorderRadius.circular(8),
                                        // ),
                                        child: Row(
                                        children: [
                                          Radio<int>(
                                            fillColor: MaterialStateProperty.all(AppColors.buttonColor),
                                            value: index,
                                            groupValue: countryProvider.selectedCountryIndex,
                                            onChanged: (value) {
                                              countryProvider.updateSelectedCountry(value);
                                            },
                                          ),
                                          Expanded(
                                            child: Text(
                                              country.name!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppColors.fontFamilySemiBold,
                                                color: AppColors.Color_212121,
                                                fontSize: AppFontSize.fontSize16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
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
