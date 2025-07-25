import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:search_choices/search_choices.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/professional_skills_provider.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../custom-component/custom-button.dart';

class ProfessionalSkillsScreen extends StatefulWidget {
  const ProfessionalSkillsScreen({super.key});

  @override
  State<ProfessionalSkillsScreen> createState() => _ProfessionalSkillsScreenState();
}

class _ProfessionalSkillsScreenState extends State<ProfessionalSkillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfessionalSkillsProvider>(
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
                  // Save the data in provider or update the profile here
                  Navigator.pop(context);
                },
                buttonText: "Save",
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
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button and Title
                    backButtonWithTitle(
                      title: "Professional Skills",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Computer and Software
                    buildComputerAndSoftwareSection(provider),

                    // Cargo Experience
                    buildCargoExperienceSection(provider),

                    // Cargo Gear Experience
                    buildCargoGearExperienceSection(provider),

                    // Metal Working Skills
                    buildMetalWorkingSkillsSection(provider),

                    // Tank Coating Experience
                    buildTankCoatingExperienceSection(provider),

                    // Port State Control Experience
                    buildPortStateControlExperienceSection(provider),

                    // Vetting Inspection Experience
                    buildVettingInspectionExperienceSection(provider),

                    // Trading Area Experience
                    buildTradingAreaExperienceSection(provider),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildComputerAndSoftwareSection(ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Text(
                'Computer and Software',
                style: TextStyle(
                  fontSize: AppFontSize.fontSize16,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppColors.fontFamilyMedium,
                  color: AppColors.Color_424242,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0, top: 10),
              child: GestureDetector(
                onTap: () {
                  provider.setComputerAndSoftwareVisibility(true);
                },
                child: Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(
                      color: AppColors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 2.5.h,
                    color: AppColors.buttonTextWhiteColor,
                  ),
                ),
              ),
            )
          ],
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: provider.computerAndSoftwareList.length,
          itemBuilder: (context, index) {
            ComputerAndSoftware item = provider.computerAndSoftwareList[index];
            return ListTile(
              title: Text(item.software),
              subtitle: Text(item.level),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      provider.editComputerAndSoftware(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      provider.removeComputerAndSoftware(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        if (provider.showAddSection_computerAndSoftware)
          Column(
            children: [
              // Dropdown for Software
              // Dropdown for Level
              // Add/Update Button
            ],
          ),
      ],
    );
  }

  Widget buildCargoExperienceSection(ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Yes/No for Cargo Experience
        // Dropdowns for different cargo types
      ],
    );
  }

  Widget buildCargoGearExperienceSection(ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Yes/No for Cargo Gear Experience
        // Repeater for Type, Maker, SWL
      ],
    );
  }

  Widget buildMetalWorkingSkillsSection(ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Yes/No for Metal Working Skills
        // Repeater for Skill, Level, Certificate, Document
      ],
    );
  }

  Widget buildTankCoatingExperienceSection(ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Yes/No for Tank Coating Experience
        // Repeater for Type
      ],
    );
  }

  Widget buildPortStateControlExperienceSection(ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Yes/No for Port State Control Experience
        // Repeater for Regional Agreement, Port, Date, Observations
      ],
    );
  }

  Widget buildVettingInspectionExperienceSection(ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Inspection By, Port, Date, Observations
      ],
    );
  }

  Widget buildTradingAreaExperienceSection(ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Multiselect for Trading Area
      ],
    );
  }
}

class backButtonWithTitle extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;

  const backButtonWithTitle({
    Key? key,
    required this.title,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
        SizedBox(width: 3.w),
        Text(
          title,
          style: TextStyle(
            fontSize: AppFontSize.fontSize18,
            fontWeight: FontWeight.bold,
            color: AppColors.Color_424242,
          ),
        ),
      ],
    );
  }
}
