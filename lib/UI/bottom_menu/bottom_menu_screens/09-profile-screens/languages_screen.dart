import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/languages_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  bool _isLanguageDropdownOpen = false;
  bool _isProficiencyDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LanguagesProvider>();
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
              final profileProvider = Provider.of<ProfileBottommenuProvider>(context, listen: false);

              // Validate required fields
              if (provider.selectedLanguage == null || provider.selectedProficiency == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('please select both language and proficiency')),
                );
                return;
              }

              // Add language to profile provider
              // profileProvider.addLanguage(
              //   language: provider.selectedLanguage,
              //   proficiency: provider.selectedProficiency,
              // );

              // Navigate back to Profile Screen after saving the data
              Navigator.pop(context);
            },
            buttonText: "Save",
            width: 90.w,
            height: 5.h,
            color: AppColors.buttonColor,
            buttonTextColor: AppColors.buttonTextWhiteColor,
            shadowColor: AppColors.buttonBorderColor,
            fontSize: AppFontSize.fontSize18,
            showShadow: true,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Header with Back and Delete Icon**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButtonWithTitle(
                    title: "Languages",
                    onBackPressed: () => Navigator.pop(context),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/images/Delete.png", height: AppFontSize.fontSize24))
                ],
              ),

              /// **Language Dropdown**
              _buildLabel("Language"),
              _buildDropdown(
                provider.selectedLanguage,
                provider.languages,
                provider.setLanguage,
                isOpen: _isLanguageDropdownOpen,
                toggleDropdown: () {
                  setState(() {
                    _isLanguageDropdownOpen = !_isLanguageDropdownOpen;
                    _isProficiencyDropdownOpen = false; // Close other dropdown if open
                  });
                },
              ),

              /// **Proficiency Dropdown**
              _buildLabel("Proficiency"),
              _buildDropdown(
                provider.selectedProficiency,
                provider.proficiencies,
                provider.setProficiency,
                isOpen: _isProficiencyDropdownOpen,
                toggleDropdown: () {
                  setState(() {
                    _isProficiencyDropdownOpen = !_isProficiencyDropdownOpen;
                    _isLanguageDropdownOpen = false; // Close other dropdown if open
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **🔹 Helper Methods**
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h, left: 1.w, top: 2.h),
      child: Text(
        text,
        style: TextStyle(fontSize: AppFontSize.fontSize16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildDropdown(
      String value, List<String> items, Function(String) onChanged,
      {required bool isOpen, required VoidCallback toggleDropdown}) {
    return Column(
      children: [
        GestureDetector(
          onTap: toggleDropdown,
          child: Container(
            height: 6.5.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: AppColors.Color_FAFAFA,
              borderRadius: BorderRadius.circular(2.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppColors.fontFamilySemiBold,
                    color: AppColors.Color_212121,
                  ),
                ),
                Image.asset("assets/images/dropdownIcon.png", height: 2.5.h, color: AppColors.Color_212121),
              ],
            ),
          ),
        ),
        if (isOpen)
          Container(
            margin: EdgeInsets.only(top: 1.h),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF), // White background
              borderRadius: BorderRadius.circular(12), // Adjust based on design
              boxShadow: [
                BoxShadow(
                  color: Color(0x04060F).withOpacity(0.08), // #04060F with 8% opacity
                  offset: Offset(0, 20), // X: 0, Y: 20
                  blurRadius: 100, // Blur: 100
                  spreadRadius: 0, // Spread: 0
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
              separatorBuilder: (_, __) => Padding(
                padding: EdgeInsets.only(left: 4.w,right: 4.w),
                child: Divider(color: AppColors.Color_EEEEEE, height: 0.5.h),
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onChanged(items[index]);
                    toggleDropdown();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                    child: Text(
                      items[index],
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.Color_212121,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
