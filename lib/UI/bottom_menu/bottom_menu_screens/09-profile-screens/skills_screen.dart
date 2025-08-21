import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/skills_provider.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final skillsProvider = Provider.of<SkillsProvider>(context, listen: false);
      final profileProvider = Provider.of<ProfileBottommenuProvider>(context, listen: false);
      
      // Reset and initialize with profile data
      skillsProvider.resetForm();
      // skillsProvider.skills.addAll(profileProvider.skills);
      skillsProvider.notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SkillsProvider>(
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
                  // Add any pending skill
                  if (provider.skillController.text.isNotEmpty) {
                    provider.addSkill(provider.skillController.text);
                    provider.skillController.clear();
                  }
                  if(provider.skills==[] || provider.skills== ''||provider.skills==null){
                    provider.skills.clear();
                  }
                  final profileProvider = Provider.of<ProfileBottommenuProvider>(context, listen: false);
                  // profileProvider.setSkills(provider.skills);

                  Navigator.pop(context);
                  // Update profile provider


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
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Header**
                  backButtonWithTitle(
                    title: "Skills",
                    onBackPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(height: 2.h),

                  /// **Skills Input Field**
                  customTextField(
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    textColor: AppColors.Color_212121,
                    context: context,
                    controller: provider.skillController,
                    focusNode: provider.skillFocusNode,
                    hintText: "Type here",
                    textInputType: TextInputType.text,
                    voidCallback: (value) => value!.isEmpty ? "Field cannot be empty" : null,
                    fillColor: AppColors.Color_FAFAFA,
                    activeFillColor: AppColors.activeFieldBgColor,
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        provider.addSkill(value);
                        provider.skillController.clear();
                      }
                      provider.skillFocusNode.unfocus();
                    },
                  ),
                  SizedBox(height: 2.h),

                  /// **Skill Tags**
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 1.h,
                    children: provider.skills.map((skill) => _buildSkillChip(skill, provider)).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillChip(String skill, SkillsProvider provider) {
    return Chip(
      label: Text(
        skill,
        style: TextStyle(
          fontSize: AppFontSize.fontSize16,
          fontWeight: FontWeight.w600,
          fontFamily: AppColors.fontFamilySemiBold,
          color: AppColors.buttonColor,
        ),
      ),
      deleteIcon: Icon(Icons.close, size: 2.h, color: AppColors.buttonColor),
      onDeleted: () => provider.removeSkill(skill),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.buttonColor),
        borderRadius: BorderRadius.circular(50.h),
      ),
      backgroundColor: AppColors.Color_FFFFFF,
    );
  }
}