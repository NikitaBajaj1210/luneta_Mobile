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
  State<ProfessionalSkillsScreen> createState() =>
      _ProfessionalSkillsScreenState();
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
                border: Border.all(
                    width: 1, color: AppColors.bottomNavBorderColor),
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
                child: Form(
                  key: provider.formKey,
                  autovalidateMode: provider.autovalidateMode,
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
          ),
        );
      },
    );
  }

  Widget buildComputerAndSoftwareSection(
      ProfessionalSkillsProvider provider) {
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
            return Container(
              margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 15.w,
                    height: 15.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.1.h, color: AppColors.Color_EEEEEE),
                      borderRadius: BorderRadius.circular(2.h),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/TicketStar.png",
                        // Replace with appropriate icon
                        width: 8.w,
                        height: 8.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.software,
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.Color_212121,
                            fontFamily: AppColors.fontFamilyBold,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          item.level,
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.Color_212121,
                            fontFamily: AppColors.fontFamilyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      provider.editComputerAndSoftware(index);
                    },
                    child: Image.asset(
                      "assets/images/Edit.png",
                      height: 2.h,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  GestureDetector(
                    onTap: () {
                      provider.removeComputerAndSoftware(index);
                    },
                    child: Image.asset(
                      "assets/images/Delete.png",
                      height: 2.h,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (provider.showAddSection_computerAndSoftware)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  'Software',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.Color_424242,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: SearchChoices.single(
                  items: provider.softwareList.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  value: provider.software,
                  hint: "Select Software",
                  searchHint: "Search for a software",
                  onChanged: (value) {
                    provider.setSoftware(value as String);
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  displayItem: (item, selected) {
                    return Container(
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                        border: Border.all(
                          color: AppColors.transparent,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(item.child.data),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  'Level',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.Color_424242,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: SearchChoices.single(
                  items: provider.levelList.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  value: provider.level,
                  hint: "Select Level",
                  searchHint: "Search for a level",
                  onChanged: (value) {
                    provider.setLevel(value as String);
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  displayItem: (item, selected) {
                    return Container(
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                        border: Border.all(
                          color: AppColors.transparent,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(item.child.data),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 1.h),
              Align(
                alignment: Alignment.centerRight,
                child: customButton(
                  voidCallback: () {
                    provider.addComputerAndSoftware();
                  },
                  buttonText:
                      provider.computerAndSoftware_IsEdit ? "Update" : "Add",
                  width: 30.w,
                  height: 10.w,
                  color: AppColors.buttonColor,
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: true,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget buildCargoExperienceSection(ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Text(
            'Cargo Experience',
            style: TextStyle(
              fontSize: AppFontSize.fontSize16,
              fontWeight: FontWeight.bold,
              fontFamily: AppColors.fontFamilyMedium,
              color: AppColors.Color_424242,
            ),
          ),
        ),
        Row(
          children: [
            Radio(
              value: true,
              groupValue: provider.cargoExperience,
              onChanged: (value) {
                provider.setCargoExperience(value as bool);
              },
              activeColor: AppColors.buttonColor,
            ),
            Text("Yes"),
            Radio(
              value: false,
              groupValue: provider.cargoExperience,
              onChanged: (value) {
                provider.setCargoExperience(value as bool);
              },
              activeColor: AppColors.buttonColor,
            ),
            Text("No"),
          ],
        ),
        if (provider.cargoExperience)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  'Bulk Cargo',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.Color_424242,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: MultiSelectDialogField(
                  items: provider.bulkCargoList
                      .map((e) => MultiSelectItem(e, e))
                      .toList(),
                  title: Text("Bulk Cargo"),
                  selectedColor: AppColors.buttonColor,
                  searchable: true,
                  decoration: BoxDecoration(
                    color: AppColors.Color_FAFAFA,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.buttonColor, width: 1),
                  ),
                  buttonIcon:
                      Icon(Icons.arrow_drop_down, color: AppColors.buttonColor),
                  buttonText: Text("Select Bulk Cargo"),
                  onConfirm: (values) {
                    provider.bulkCargo = values.cast<String>();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  'Tanker Cargo',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.Color_424242,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: MultiSelectDialogField(
                  items: provider.tankerCargoList
                      .map((e) => MultiSelectItem(e, e))
                      .toList(),
                  title: Text("Tanker Cargo"),
                  selectedColor: AppColors.buttonColor,
                  searchable: true,
                  decoration: BoxDecoration(
                    color: AppColors.Color_FAFAFA,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.buttonColor, width: 1),
                  ),
                  buttonIcon:
                      Icon(Icons.arrow_drop_down, color: AppColors.buttonColor),
                  buttonText: Text("Select Tanker Cargo"),
                  onConfirm: (values) {
                    provider.tankerCargo = values.cast<String>();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  'General Cargo',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.Color_424242,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: MultiSelectDialogField(
                  items: provider.generalCargoList
                      .map((e) => MultiSelectItem(e, e))
                      .toList(),
                  title: Text("General Cargo"),
                  selectedColor: AppColors.buttonColor,
                  searchable: true,
                  decoration: BoxDecoration(
                    color: AppColors.Color_FAFAFA,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.buttonColor, width: 1),
                  ),
                  buttonIcon:
                      Icon(Icons.arrow_drop_down, color: AppColors.buttonColor),
                  buttonText: Text("Select General Cargo"),
                  onConfirm: (values) {
                    provider.generalCargo = values.cast<String>();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  'Wood Products',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.Color_424242,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: MultiSelectDialogField(
                  items: provider.woodProductsList
                      .map((e) => MultiSelectItem(e, e))
                      .toList(),
                  title: Text("Wood Products"),
                  selectedColor: AppColors.buttonColor,
                  searchable: true,
                  decoration: BoxDecoration(
                    color: AppColors.Color_FAFAFA,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.buttonColor, width: 1),
                  ),
                  buttonIcon:
                      Icon(Icons.arrow_drop_down, color: AppColors.buttonColor),
                  buttonText: Text("Select Wood Products"),
                  onConfirm: (values) {
                    provider.woodProducts = values.cast<String>();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  'Stowage and Lashing Experience',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.Color_424242,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: MultiSelectDialogField(
                  items: provider.stowageAndLashingExperienceList
                      .map((e) => MultiSelectItem(e, e))
                      .toList(),
                  title: Text("Stowage and Lashing Experience"),
                  selectedColor: AppColors.buttonColor,
                  searchable: true,
                  decoration: BoxDecoration(
                    color: AppColors.Color_FAFAFA,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.buttonColor, width: 1),
                  ),
                  buttonIcon:
                      Icon(Icons.arrow_drop_down, color: AppColors.buttonColor),
                  buttonText: Text("Select Stowage and Lashing Experience"),
                  onConfirm: (values) {
                    provider.stowageAndLashingExperience =
                        values.cast<String>();
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget buildCargoGearExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Cargo Gear Experience"),
            Radio(
              value: true,
              groupValue: provider.cargoGearExperience,
              onChanged: (value) {
                provider.setCargoGearExperience(value as bool);
              },
              activeColor: AppColors.buttonColor,
            ),
            Text("Yes"),
            Radio(
              value: false,
              groupValue: provider.cargoGearExperience,
              onChanged: (value) {
                provider.setCargoGearExperience(value as bool);
              },
              activeColor: AppColors.buttonColor,
            ),
            Text("No"),
          ],
        ),
        if (provider.cargoGearExperience)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cargo Gear Experience Details"),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        provider.setCargoGearExperienceVisibility(true);
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
                itemCount: provider.cargoGearExperienceList.length,
                itemBuilder: (context, index) {
                  CargoGearExperience item =
                      provider.cargoGearExperienceList[index];
                  return Container(
                    margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 15.w,
                          height: 15.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.1.h, color: AppColors.Color_EEEEEE),
                            borderRadius: BorderRadius.circular(2.h),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/TicketStar.png",
                              // Replace with appropriate icon
                              width: 8.w,
                              height: 8.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.type,
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.Color_212121,
                                  fontFamily: AppColors.fontFamilyBold,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                item.maker,
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.Color_212121,
                                  fontFamily: AppColors.fontFamilyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            provider.editCargoGearExperience(index);
                          },
                          child: Image.asset(
                            "assets/images/Edit.png",
                            height: 2.h,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        GestureDetector(
                          onTap: () {
                            provider.removeCargoGearExperience(index);
                          },
                          child: Image.asset(
                            "assets/images/Delete.png",
                            height: 2.h,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (provider.showAddSection_cargoGearExperience)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Type"),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                      child: SearchChoices.single(
                        items: provider.cargoGearTypes.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        value: provider.cargoGearType,
                        hint: Text("Select Type"),
                        searchHint: "Search for a type",
                        onChanged: (value) {
                          provider.setCargoGearType(value as String);
                        },
                        isExpanded: true,
                        underline: SizedBox(),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text("Maker"),
                    customTextField(
                      context: context,
                      controller: provider.cargoGearMakerController,
                      hintText: 'Enter Maker',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {},
                    ),
                    SizedBox(height: 1.h),
                    Text("SWL"),
                    customTextField(
                      context: context,
                      controller: provider.cargoGearSWLController,
                      hintText: 'Enter SWL',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {},
                    ),
                    SizedBox(height: 1.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: customButton(
                        voidCallback: () {
                          provider.addCargoGearExperience();
                        },
                        buttonText: provider.cargoGearExperience_IsEdit
                            ? "Update"
                            : "Add",
                        width: 30.w,
                        height: 10.w,
                        color: AppColors.buttonColor,
                        buttonTextColor: AppColors.buttonTextWhiteColor,
                        shadowColor: AppColors.buttonBorderColor,
                        fontSize: AppFontSize.fontSize18,
                        showShadow: true,
                      ),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }

  Widget buildMetalWorkingSkillsSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Metal Working Skills"),
            Radio(
              value: true,
              groupValue: provider.metalWorkingSkills,
              onChanged: (value) {
                provider.setMetalWorkingSkills(value as bool);
              },
              activeColor: AppColors.buttonColor,
            ),
            Text("Yes"),
            Radio(
              value: false,
              groupValue: provider.metalWorkingSkills,
              onChanged: (value) {
                provider.setMetalWorkingSkills(value as bool);
              },
              activeColor: AppColors.buttonColor,
            ),
            Text("No"),
          ],
        ),
        if (provider.metalWorkingSkills)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Metal Working Skills Details"),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        provider.setMetalWorkingSkillsVisibility(true);
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
                itemCount: provider.metalWorkingSkillsList.length,
                itemBuilder: (context, index) {
                  MetalWorkingSkill item =
                      provider.metalWorkingSkillsList[index];
                  return Container(
                    margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 15.w,
                          height: 15.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.1.h, color: AppColors.Color_EEEEEE),
                            borderRadius: BorderRadius.circular(2.h),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/TicketStar.png",
                              // Replace with appropriate icon
                              width: 8.w,
                              height: 8.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.skillSelection,
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.Color_212121,
                                  fontFamily: AppColors.fontFamilyBold,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                item.level,
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.Color_212121,
                                  fontFamily: AppColors.fontFamilyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (provider.showAddSection_metalWorkingSkills)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Skill Selection"),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                      child: SearchChoices.single(
                        items: provider.metalWorkingSkillsTypes.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        value: provider.metalWorkingSkill,
                        hint: Text("Select Skill"),
                        searchHint: "Search for a skill",
                        onChanged: (value) {
                          provider.setMetalWorkingSkill(value as String);
                        },
                        isExpanded: true,
                        underline: SizedBox(),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text("Level"),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                      child: SearchChoices.single(
                        items:
                            provider.metalWorkingSkillLevelList.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        value: provider.metalWorkingSkillLevel,
                        hint: Text("Select Level"),
                        searchHint: "Search for a level",
                        onChanged: (value) {
                          provider.setMetalWorkingSkillLevel(value as String);
                        },
                        isExpanded: true,
                        underline: SizedBox(),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Text("Certificate"),
                        Radio(
                          value: true,
                          groupValue: provider.metalWorkingSkillCertificate,
                          onChanged: (value) {
                            provider
                                .setMetalWorkingSkillCertificate(value as bool);
                          },
                          activeColor: AppColors.buttonColor,
                        ),
                        Text("Yes"),
                        Radio(
                          value: false,
                          groupValue: provider.metalWorkingSkillCertificate,
                          onChanged: (value) {
                            provider
                                .setMetalWorkingSkillCertificate(value as bool);
                          },
                          activeColor: AppColors.buttonColor,
                        ),
                        Text("No"),
                      ],
                    ),
                    if (provider.metalWorkingSkillCertificate)
                      customButton(
                        voidCallback: () {
                          provider.showAttachmentOptions(
                              context, 'metalWorkingSkill');
                        },
                        buttonText: "Attach Document",
                        width: 40.w,
                        height: 10.w,
                        color: AppColors.buttonColor,
                        buttonTextColor: AppColors.buttonTextWhiteColor,
                        shadowColor: AppColors.buttonBorderColor,
                        fontSize: AppFontSize.fontSize18,
                        showShadow: true,
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: customButton(
                        voidCallback: () {
                          provider.addMetalWorkingSkill();
                        },
                        buttonText: provider.metalWorkingSkills_IsEdit
                            ? "Update"
                            : "Add",
                        width: 30.w,
                        height: 10.w,
                        color: AppColors.buttonColor,
                        buttonTextColor: AppColors.buttonTextWhiteColor,
                        shadowColor: AppColors.buttonBorderColor,
                        fontSize: AppFontSize.fontSize18,
                        showShadow: true,
                      ),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }

  Widget buildTankCoatingExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Tank Coating Experience"),
            Radio(
              value: true,
              groupValue: provider.tankCoatingExperience,
              onChanged: (value) {
                provider.setTankCoatingExperience(value as bool);
              },
              activeColor: AppColors.buttonColor,
            ),
            Text("Yes"),
            Radio(
              value: false,
              groupValue: provider.tankCoatingExperience,
              onChanged: (value) {
                provider.setTankCoatingExperience(value as bool);
              },
              activeColor: AppColors.buttonColor,
            ),
            Text("No"),
          ],
        ),
        if (provider.tankCoatingExperience)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tank Coating Experience Details"),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        provider.setTankCoatingExperienceVisibility(true);
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
                itemCount: provider.tankCoatingExperienceList.length,
                itemBuilder: (context, index) {
                  TankCoatingExperience item =
                      provider.tankCoatingExperienceList[index];
                  return ListTile(
                    title: Text(item.type),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            provider.editTankCoatingExperience(index);
                          },
                          child: Image.asset(
                            "assets/images/Edit.png",
                            height: 2.h,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        GestureDetector(
                          onTap: () {
                            provider.removeTankCoatingExperience(index);
                          },
                          child: Image.asset(
                            "assets/images/Delete.png",
                            height: 2.h,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (provider.showAddSection_tankCoatingExperience)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Type"),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                      child: SearchChoices.single(
                        items: provider.tankCoatingTypes.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        value: provider.tankCoatingType,
                        hint: Text("Select Type"),
                        searchHint: "Search for a type",
                        onChanged: (value) {
                          provider.setTankCoatingType(value as String);
                        },
                        isExpanded: true,
                        underline: SizedBox(),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: customButton(
                        voidCallback: () {
                          provider.addTankCoatingExperience();
                        },
                        buttonText: provider.tankCoatingExperience_IsEdit
                            ? "Update"
                            : "Add",
                        width: 30.w,
                        height: 10.w,
                        color: AppColors.buttonColor,
                        buttonTextColor: AppColors.buttonTextWhiteColor,
                        shadowColor: AppColors.buttonBorderColor,
                        fontSize: AppFontSize.fontSize18,
                        showShadow: true,
                      ),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }

  Widget buildPortStateControlExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Port State Control Experience"),
            Radio(
              value: true,
              groupValue: provider.portStateControlExperience,
              onChanged: (value) {
                provider.setPortStateControlExperience(value as bool);
              },
              activeColor: AppColors.buttonColor,
            ),
            Text("Yes"),
            Radio(
              value: false,
              groupValue: provider.portStateControlExperience,
              onChanged: (value) {
                provider.setPortStateControlExperience(value as bool);
              },
              activeColor: AppColors.buttonColor,
            ),
            Text("No"),
          ],
        ),
        if (provider.portStateControlExperience)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Port State Control Experience Details"),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        provider.setPortStateControlExperienceVisibility(true);
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
                itemCount: provider.portStateControlExperienceList.length,
                itemBuilder: (context, index) {
                  PortStateControlExperience item =
                      provider.portStateControlExperienceList[index];
                  return Container(
                    margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 15.w,
                          height: 15.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.1.h, color: AppColors.Color_EEEEEE),
                            borderRadius: BorderRadius.circular(2.h),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/TicketStar.png",
                              // Replace with appropriate icon
                              width: 8.w,
                              height: 8.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.regionalAgreement,
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.Color_212121,
                                  fontFamily: AppColors.fontFamilyBold,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                item.port,
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.Color_212121,
                                  fontFamily: AppColors.fontFamilyMedium,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                item.date.toString(),
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.Color_212121,
                                  fontFamily: AppColors.fontFamilyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (provider.showAddSection_portStateControlExperience)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Regional Agreement"),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                      child: SearchChoices.single(
                        items: provider.regionalAgreements.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        value: provider.regionalAgreement,
                        hint: Text("Select Regional Agreement"),
                        searchHint: "Search for a regional agreement",
                        onChanged: (value) {
                          provider.setRegionalAgreement(value as String);
                        },
                        isExpanded: true,
                        underline: SizedBox(),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text("Port"),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                      child: SearchChoices.single(
                        items: provider.ports.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        value: provider.port,
                        hint: Text("Select Port"),
                        searchHint: "Search for a port",
                        onChanged: (value) {
                          provider.setPort(value as String);
                        },
                        isExpanded: true,
                        underline: SizedBox(),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text("Date"),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          provider.setDate(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.dateController,
                          hintText: 'Select Date',
                          textInputType: TextInputType.datetime,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: AppColors.Color_FAFAFA,
                          onFieldSubmitted: (String) {},
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text("Observations"),
                    customTextField(
                      context: context,
                      controller: provider.observationsController,
                      hintText: 'Enter Observations',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {},
                    ),
                    SizedBox(height: 1.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: customButton(
                        voidCallback: () {
                          provider.addPortStateControlExperience();
                        },
                        buttonText: provider.portStateControlExperience_IsEdit
                            ? "Update"
                            : "Add",
                        width: 30.w,
                        height: 10.w,
                        color: AppColors.buttonColor,
                        buttonTextColor: AppColors.buttonTextWhiteColor,
                        shadowColor: AppColors.buttonBorderColor,
                        fontSize: AppFontSize.fontSize18,
                        showShadow: true,
                      ),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }

  Widget buildVettingInspectionExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Vetting Inspection Experience"),
        SizedBox(height: 1.h),
        Text("Inspection By"),
        customTextField(
          context: context,
          controller: provider.inspectionByController,
          hintText: 'Enter Inspection By',
          textInputType: TextInputType.text,
          obscureText: false,
          voidCallback: (value) {},
          fontSize: AppFontSize.fontSize16,
          inputFontSize: AppFontSize.fontSize16,
          backgroundColor: AppColors.Color_FAFAFA,
          borderColor: AppColors.buttonColor,
          textColor: Colors.black,
          labelColor: AppColors.Color_9E9E9E,
          cursorColor: AppColors.Color_212121,
          fillColor: AppColors.Color_FAFAFA,
          onFieldSubmitted: (String) {},
        ),
        SizedBox(height: 1.h),
        Text("Port"),
        Container(
          decoration: BoxDecoration(
            color: AppColors.Color_FAFAFA,
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: SearchChoices.single(
            items: provider.vettingPorts.map((item) {
              return DropdownMenuItem(
                child: Text(item),
                value: item,
              );
            }).toList(),
            value: provider.vettingPort,
            hint: Text("Select Port"),
            searchHint: "Search for a port",
            onChanged: (value) {
              provider.setVettingPort(value as String);
            },
            isExpanded: true,
            underline: SizedBox(),
          ),
        ),
        SizedBox(height: 1.h),
        Text("Date"),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              provider.setVettingDate(picked);
            }
          },
          child: AbsorbPointer(
            child: customTextField(
              context: context,
              controller: provider.vettingDateController,
              hintText: 'Select Date',
              textInputType: TextInputType.datetime,
              obscureText: false,
              voidCallback: (value) {},
              fontSize: AppFontSize.fontSize16,
              inputFontSize: AppFontSize.fontSize16,
              backgroundColor: AppColors.Color_FAFAFA,
              borderColor: AppColors.buttonColor,
              textColor: Colors.black,
              labelColor: AppColors.Color_9E9E9E,
              cursorColor: AppColors.Color_212121,
              fillColor: AppColors.Color_FAFAFA,
              onFieldSubmitted: (String) {},
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Text("Observations"),
        customTextField(
          context: context,
          controller: provider.vettingObservationsController,
          hintText: 'Enter Observations',
          textInputType: TextInputType.text,
          obscureText: false,
          voidCallback: (value) {},
          fontSize: AppFontSize.fontSize16,
          inputFontSize: AppFontSize.fontSize16,
          backgroundColor: AppColors.Color_FAFAFA,
          borderColor: AppColors.buttonColor,
          textColor: Colors.black,
          labelColor: AppColors.Color_9E9E9E,
          cursorColor: AppColors.Color_212121,
          fillColor: AppColors.Color_FAFAFA,
          onFieldSubmitted: (String) {},
        ),
      ],
    );
  }

  Widget buildTradingAreaExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Trading Area Experience"),
        Container(
          decoration: BoxDecoration(
            color: AppColors.Color_FAFAFA,
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: MultiSelectDialogField(
            items: provider.tradingAreaList
                .map((e) => MultiSelectItem(e, e))
                .toList(),
            title: Text("Trading Area"),
            selectedColor: AppColors.buttonColor,
            searchable: true,
            decoration: BoxDecoration(
              color: AppColors.Color_FAFAFA,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.buttonColor, width: 1),
            ),
            buttonIcon:
                Icon(Icons.arrow_drop_down, color: AppColors.buttonColor),
            buttonText: Text("Select Trading Area"),
            onConfirm: (values) {
              provider.tradingAreaExperience = values.cast<String>();
            },
          ),
        ),
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
