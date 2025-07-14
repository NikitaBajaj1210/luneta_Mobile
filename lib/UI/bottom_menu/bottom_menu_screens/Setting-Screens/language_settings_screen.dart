import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/language_provider.dart'; // Import the provider

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: Consumer<LanguageProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    backButtonWithTitle(
                      title: "Language",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Suggested Languages
                    Text(
                      "Suggested",
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize20,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppColors.fontFamilyBold,
                        color: AppColors.Color_212121
                      ),
                    ),
                    SizedBox(height: 1.h),
                    languageRadio(
                      label: 'English (US)',
                      value: 'English (US)',
                      groupValue: provider.suggestedLanguage,
                      onChanged: (String? value) {
                        provider.setSuggestedLanguage = value!;
                      },
                    ),
                    languageRadio(
                      label: 'English (UK)',
                      value: 'English (UK)',
                      groupValue: provider.suggestedLanguage,
                      onChanged: (String? value) {
                        provider.setSuggestedLanguage = value!;
                      },
                    ),
                    CustomDivider(),
                    // Language Selection
                    Text(
                      "Language",
                      style: TextStyle(
                          fontSize: AppFontSize.fontSize20,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppColors.fontFamilyBold,
                          color: AppColors.Color_212121
                      ),
                    ),
                    SizedBox(height: 1.h),
                    languageRadio(
                      label: 'Mandarin',
                      value: 'Mandarin',
                      groupValue: provider.selectedLanguage,
                      onChanged: (String? value) {
                        provider.setSelectedLanguage = value!;
                      },
                    ),
                    languageRadio(
                      label: 'Hindi',
                      value: 'Hindi',
                      groupValue: provider.selectedLanguage,
                      onChanged: (String? value) {
                        provider.setSelectedLanguage = value!;
                      },
                    ),
                    languageRadio(
                      label: 'Spanish',
                      value: 'Spanish',
                      groupValue: provider.selectedLanguage,
                      onChanged: (String? value) {
                        provider.setSelectedLanguage = value!;
                      },
                    ),
                    languageRadio(
                      label: 'French',
                      value: 'French',
                      groupValue: provider.selectedLanguage,
                      onChanged: (String? value) {
                        provider.setSelectedLanguage = value!;
                      },
                    ),
                    languageRadio(
                      label: 'Arabic',
                      value: 'Arabic',
                      groupValue: provider.selectedLanguage,
                      onChanged: (String? value) {
                        provider.setSelectedLanguage = value!;
                      },
                    ),
                    languageRadio(
                      label: 'Bengali',
                      value: 'Bengali',
                      groupValue: provider.selectedLanguage,
                      onChanged: (String? value) {
                        provider.setSelectedLanguage = value!;
                      },
                    ),
                    languageRadio(
                      label: 'Russian',
                      value: 'Russian',
                      groupValue: provider.selectedLanguage,
                      onChanged: (String? value) {
                        provider.setSelectedLanguage = value!;
                      },
                    ),
                    languageRadio(
                      label: 'Indonesia',
                      value: 'Indonesia',
                      groupValue: provider.selectedLanguage,
                      onChanged: (String? value) {
                        provider.setSelectedLanguage = value!;
                      },
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

  // Custom Radio Button for each language option
  Widget languageRadio({
    required String label,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: AppFontSize.fontSize18,
            fontWeight: FontWeight.w600,
            color: AppColors.Color_212121,
            fontFamily: AppColors.fontFamilySemiBold
          ),
        ),
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColors.buttonColor,
          fillColor: MaterialStateProperty.all(AppColors.buttonColor),
        ),
      ],
    );
  }
}
// Custom Divider Widget
class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
      height: 0.01.h,
      color: AppColors.Color_EEEEEE,
      width: 100.w,
    );
  }
}

