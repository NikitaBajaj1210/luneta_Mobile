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
                    countryProvider.selectedCountryIndex!=-1?
                    Navigator.of(context).pushNamed(chooseRole):print("please select");
                    // Handle button click action
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
                        Navigator.pop(context);
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
                        countryProvider.updateSearchQuery(value);
                        setState(() {}); // Update the UI on input change
                        // Remove focus if input exceeds 3 words
                        if (value.split(' ').length > 3) {
                          countryProvider.searchFocusNode.unfocus();
                        }
                      },
                      onFieldSubmitted: (value) {
                        // Handle country field submitted if needed
                      },
                    ),
                  SizedBox(height: 1.h,),
            
                    Expanded(
                      child: ListView.builder(
                        itemCount: countryProvider.filteredCountries.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 6.3.h,
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
                                Text(countryProvider.filteredCountries[index],style: TextStyle(
                                  fontWeight:FontWeight.w600,
                                  fontFamily: AppColors.fontFamilySemiBold,
                                  color: AppColors.Color_212121,
                                  fontSize: AppFontSize.fontSize18
                                ),),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
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
