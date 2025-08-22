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
import '../../../../custom-component/globalComponent.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_services.dart';
import '../../../../Utils/helper.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class ProfessionalSkillsScreen extends StatefulWidget {
  const ProfessionalSkillsScreen({super.key});

  @override
  State<ProfessionalSkillsScreen> createState() =>
      _ProfessionalSkillsScreenState();
}

class _ProfessionalSkillsScreenState extends State<ProfessionalSkillsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<ProfessionalSkillsProvider>(context, listen: false);
      // Clear only the form inputs first, preserving existing data
      provider.clearFormInputs();
      // Then fetch the data
      provider.fetchProfessionalSkillsData(context);
      provider.fetchDropdownData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfessionalSkillsProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Container(
            height: 100.h,
            width: 100.w,
            color: AppColors.Color_FFFFFF,
            child: NetworkService.loading == 0 ? Center(
              child: CircularProgressIndicator(color: AppColors.Color_607D8B),
            ) :
            NetworkService.loading == 1 ? Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    var provider = Provider.of<ProfessionalSkillsProvider>(context, listen: false);
                    provider.clearFormInputs();
                    provider.fetchProfessionalSkillsData(context);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                          'assets/images/refresh.png',
                          width: 4.5.h,
                          height: 4.5.h,
                          color: AppColors.Color_607D8B
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "Tap to Try Again",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: AppColors.fontFamilyBold,
                            fontSize: AppFontSize.fontSize15,
                            color: AppColors.Color_607D8B,
                            decoration: TextDecoration.none
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ) :
            Scaffold(
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
                voidCallback: () async {
                  NetworkService.loading = 0;
                  setState(() {});
                  bool success = await provider.createOrUpdateProfessionalSkillsAPI(context);
                  if (success) {
                    Provider.of<ProfileBottommenuProvider>(
                        context,
                        listen: false).getProfileInfo(context);
                    // showToast("Professional skills saved successfully");
                    Navigator.pop(context);
                  } else {
                    showToast( "Failed to save professional skills");
                  }
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
        ));
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
                  if(provider.computerAndSoftware_IsEdit) {
                    provider.setComputerAndSoftwareVisibility(true);
                    provider.showAddSection_computerAndSoftware = true;
                  }else if (provider.showAddSection_computerAndSoftware){
                    provider.setComputerAndSoftwareVisibility(false);
                    provider.showAddSection_computerAndSoftware = false;
                  }else{
                    provider.setComputerAndSoftwareVisibility(true);
                    provider.showAddSection_computerAndSoftware = true;
                  }
                  provider.software = null;
                  provider.level = null;
                  provider.computerAndSoftware_IsEdit = false;
                  provider.computerAndSoftware_Edit_Index = null;
               // provider.showAddSection_computerAndSoftware = !provider.showAddSection_computerAndSoftware;
               //    provider.setComputerAndSoftwareVisibility( provider.showAddSection_computerAndSoftware );
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
                      provider.computerAndSoftware_Edit_Index = index;
                      provider.computerAndSoftware_IsEdit = true;
                      provider.software = provider.computerAndSoftwareList[index].software;
                      provider.level = provider.computerAndSoftwareList[index].level;
                      provider.setComputerAndSoftwareVisibility(true);
                    },
                    child: Image.asset(
                      "assets/images/Edit.png",
                      height: 2.h,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  GestureDetector(
                    onTap: () {
    if(provider.computerAndSoftware_IsEdit){
    showToast("Updating or cancel the current record before continuing.");
    }else {
      provider.removeComputerAndSoftware(index);
    }
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.buttonColor.withOpacity(0.15), // 👈 shadow color
                  blurRadius: 0,   // how soft the shadow is
                  spreadRadius: 0, // how wide it spreads
                  // offset: const Offset(4, 4), // X, Y position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(2.h),
              border: Border.all(
                color: AppColors.buttonColor, // Set the border color here
                width: 1, // You can adjust the width of the border
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Text(
                      provider.computerAndSoftware_IsEdit?'Edit Computer and Software skill Detail':'Add Computer and Software skill Detail',
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize19,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppColors.fontFamilyMedium,
                        color: AppColors.Color_424242,
                      ),
                    ),
                  ),
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
                      items: provider.getAvailableSoftwareList().map((item) {
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        // height: 9.h,
                        // width: 30.w,
                        padding: EdgeInsets.symmetric(horizontal: .5.w, vertical: 2.h),
                        child: customButton(
                          voidCallback: () {
                            // Clear form data
                            provider.setComputerAndSoftwareVisibility(false);
                            provider.software = null;
                            provider.level = null;
                            provider.computerAndSoftware_IsEdit = false;
                            provider.computerAndSoftware_Edit_Index = null;
                          },
                          buttonText: "Cancel",
                          width: 30.w,
                          height: 10.w,
                          color: AppColors.Color_BDBDBD,
                          buttonTextColor: AppColors.buttonTextWhiteColor,
                          shadowColor: AppColors.buttonBorderColor,
                          fontSize: AppFontSize.fontSize18,
                          showShadow: true,
                        ),
                      ),
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
              ),
            ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, top: 10,bottom: 7),
                    child: GestureDetector(
                      onTap: () {
                        provider.showAddCargoDialog(
                          context,
                          "Add Bulk Cargo",
                          postMasterCargoExperience,
                          () => provider.getBulkCargo(context),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(1.w),
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
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: MultiSelectDialogField(
                  items: provider.bulkCargoList_data
                      .map((e) => MultiSelectItem(e.name, e.name ?? ''))
                      .toList(),
                  title: Text("Bulk Cargo"),
                  selectedColor: AppColors.buttonColor,
                  searchable: true,
                  initialValue: provider.bulkCargo,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, top: 10,bottom: 7),
                    child: GestureDetector(
                      onTap: () {
                        provider.showAddCargoDialog(
                          context,
                          "Add Tanker Cargo",
                          postMasterTankerCargo,
                          () => provider.getTankerCargo(context),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(1.w),
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
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: MultiSelectDialogField(
                  items: provider.tankerCargoList_data
                      .map((e) => MultiSelectItem(e.name, e.name ?? ''))
                      .toList(),
                  title: Text("Tanker Cargo"),
                  selectedColor: AppColors.buttonColor,
                  searchable: true,
                  initialValue: provider.tankerCargo,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, top: 10,bottom: 7),
                    child: GestureDetector(
                      onTap: () {
                        provider.showAddCargoDialog(
                          context,
                          "Add General Cargo",
                          postMasterGeneralCargo,
                          () => provider.getGeneralCargo(context),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(1.w),
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
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: MultiSelectDialogField(
                  items: provider.generalCargoList_data
                      .map((e) => MultiSelectItem(e.name, e.name ?? ''))
                      .toList(),
                  title: Text("General Cargo"),
                  selectedColor: AppColors.buttonColor,
                  searchable: true,
                  initialValue: provider.generalCargo,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, top: 10,bottom: 7),
                    child: GestureDetector(
                      onTap: () {
                        provider.showAddCargoDialog(
                          context,
                          "Add Wood Product",
                          postMasterWoodProduct,
                          () => provider.getWoodProducts(context),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(1.w),
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

              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: MultiSelectDialogField(
                  items: provider.woodProductsList_data
                      .map((e) => MultiSelectItem(e.name, e.name ?? ''))
                      .toList(),
                  title: Text("Wood Products"),
                  selectedColor: AppColors.buttonColor,
                  searchable: true,
                  initialValue: provider.woodProducts,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.Color_FAFAFA,
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: MultiSelectDialogField(
                  items: provider.stowageAndLashingExperienceList_data
                      .map((e) => MultiSelectItem(e.name, e.name ?? ''))
                      .toList(),
                  title: Expanded(child: Text("Stowage and Lashing Experience",overflow: TextOverflow.ellipsis,)),
                  selectedColor: AppColors.buttonColor,
                  searchable: true,
                  initialValue: provider.stowageAndLashingExperience,
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
                        if(provider.cargoGearExperience_IsEdit) {
                          provider.setCargoGearExperienceVisibility(true);
                          provider.showAddSection_cargoGearExperience = true;
                        }else if (provider.showAddSection_cargoGearExperience){
                          provider.setCargoGearExperienceVisibility(false);
                          provider.showAddSection_cargoGearExperience = false;
                        }else{
                          provider.setCargoGearExperienceVisibility(true);
                          provider.showAddSection_cargoGearExperience = true;
                        }
                        // provider.showAddSection_cargoGearExperience = !provider.showAddSection_cargoGearExperience;
                        // provider.setCargoGearExperienceVisibility(provider.showAddSection_cargoGearExperience);
                        provider.cargoGearType = null;
                        provider.cargoGearMakerController.clear();
                        provider.cargoGearSWLController.clear();
                        provider.cargoGearExperience_IsEdit = false;
                        provider.cargoGearExperience_Edit_Index = null;
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
    if(provider.cargoGearExperience_IsEdit){
    showToast("Updating or cancel the current record before continuing.");
    }else {
      provider.removeCargoGearExperience(index);
    }
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.buttonColor.withOpacity(0.15), // 👈 shadow color
                        blurRadius: 0,   // how soft the shadow is
                        spreadRadius: 0, // how wide it spreads
                        // offset: const Offset(4, 4), // X, Y position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(2.h),
                    border: Border.all(
                      color: AppColors.buttonColor, // Set the border color here
                      width: 1, // You can adjust the width of the border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            provider.cargoGearExperience_IsEdit?'Edit Cargo Gear Experience Detail':'Add Cargo Gear Experience Detail',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize19,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Text("Type"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.Color_FAFAFA,
                              borderRadius: BorderRadius.circular(2.h),
                            ),
                            child: SearchChoices.single(
                              items: provider.getAvailableCargoGearTypes().map((item) {
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
                        ),
                        SizedBox(height: 1.h),
                        Text("Maker"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: customTextField(
                            context: context,
                            controller: provider.cargoGearMakerController,
                            focusNode: provider.cargoGearMakerFocusNode,
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
                            activeFillColor: AppColors.activeFieldBgColor,
                            onFieldSubmitted: (String) {},
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text("SWL"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: customTextField(
                            context: context,
                            controller: provider.cargoGearSWLController,
                            focusNode: provider.cargoGearSWLFocusNode,
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
                            activeFillColor: AppColors.activeFieldBgColor,
                            onFieldSubmitted: (String) {},
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              // height: 9.h,
                              // width: 30.w,
                              padding: EdgeInsets.symmetric(horizontal: .5.w, vertical: 2.h),
                              child: customButton(
                                voidCallback: () {
                                  // Clear form data
                                  provider.cargoGearType = null;
                                  provider.cargoGearMakerController.clear();
                                  provider.cargoGearSWLController.clear();
                                  provider.cargoGearExperience_IsEdit = false;
                                  provider.cargoGearExperience_Edit_Index = null;
                                  provider.setCargoGearExperienceVisibility(false);
                                },
                                buttonText: "Cancel",
                                width: 30.w,
                                height: 10.w,
                                color: AppColors.Color_BDBDBD,
                                buttonTextColor: AppColors.buttonTextWhiteColor,
                                shadowColor: AppColors.buttonBorderColor,
                                fontSize: AppFontSize.fontSize18,
                                showShadow: true,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
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
                  ),
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
                        if(provider.metalWorkingSkills_IsEdit) {
                          provider.setMetalWorkingSkillsVisibility(true);
                          provider.showAddSection_metalWorkingSkills = true;
                        }else if (provider.showAddSection_metalWorkingSkills){
                          provider.setMetalWorkingSkillsVisibility(false);
                          provider.showAddSection_metalWorkingSkills = false;
                        }else{
                          provider.setMetalWorkingSkillsVisibility(true);
                          provider.showAddSection_metalWorkingSkills = true;
                        }
                        provider.metalWorkingSkill = null;
                        provider.metalWorkingSkillLevel = null;
                        provider.metalWorkingSkillCertificate = false;
                        provider.metalWorkingSkillDocument = null;
                        provider.metalWorkingSkills_IsEdit = false;
                        provider.metalWorkingSkills_Edit_Index = null;
                        // provider.showAddSection_metalWorkingSkills =!provider.showAddSection_metalWorkingSkills;
                        // provider.setMetalWorkingSkillsVisibility(provider.showAddSection_metalWorkingSkills);
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
                    child: Column(
                      children: [
                        Row(
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
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    item.certificate ? "Certificate: Yes" : "Certificate: No",
                                    style: TextStyle(
                                      fontSize: AppFontSize.fontSize14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.Color_212121,
                                      fontFamily: AppColors.fontFamilyMedium,
                                    ),
                                  ),
                                  SizedBox(height: 0.5,),
                                 Text(
                                    item.originalName??'',
                                    style: TextStyle(
                                      fontSize: AppFontSize.fontSize14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.Color_212121,
                                      fontFamily: AppColors.fontFamilyMedium,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.editMetalWorkingSkill(index);
                              },
                              child: Image.asset(
                                "assets/images/Edit.png",
                                height: 2.h,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            GestureDetector(
                              onTap: () {
    if(provider.metalWorkingSkills_IsEdit){
    showToast("Updating or cancel the current record before continuing.");
    }else {
      provider.removeMetalWorkingSkill(index);
    }
                              },
                              child: Image.asset(
                                "assets/images/Delete.png",
                                height: 2.h,
                              ),
                            ),
                          ],
                        ),
                        // Display document if it exists
                        // if (item.documentPath != null && item.documentPath!.isNotEmpty)
                        //   Container(
                        //     margin: EdgeInsets.only(top: 1.h),
                        //     padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                        //     decoration: BoxDecoration(
                        //       color: Colors.blue.shade50,
                        //       borderRadius: BorderRadius.circular(1.h),
                        //       border: Border.all(color: AppColors.buttonColor, width: 1),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Image.asset("assets/images/Paper.png", height: 2.5.h),
                        //         SizedBox(width: 2.w),
                        //         Expanded(
                        //           child:
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                      ],
                    ),
                  );
                },
              ),
              if (provider.showAddSection_metalWorkingSkills)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.buttonColor.withOpacity(0.15), // 👈 shadow color
                        blurRadius: 0,   // how soft the shadow is
                        spreadRadius: 0, // how wide it spreads
                        // offset: const Offset(4, 4), // X, Y position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(2.h),
                    border: Border.all(
                      color: AppColors.buttonColor, // Set the border color here
                      width: 1, // You can adjust the width of the border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            provider.metalWorkingSkills_IsEdit?'Edit Metal Working Skill Detail':'Add Metal Working Skill Detail',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize19,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Text("Skill Selection"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.Color_FAFAFA,
                              borderRadius: BorderRadius.circular(2.h),
                            ),
                            child: SearchChoices.single(
                              items: provider.getAvailableMetalWorkingSkillsTypes().map((item) {
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
                        ),
                        SizedBox(height: 1.h),
                        Text("Level"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.Color_FAFAFA,
                              borderRadius: BorderRadius.circular(2.h),
                            ),
                            child: SearchChoices.single(
                              items:
                                  provider.levelList.map((item) {
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  provider.showAttachmentOptions(
                                      context, 'metalWorkingSkill');
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(15),
                                  dashPattern: [10, 10],
                                  color: AppColors.buttonColor,
                                  strokeWidth: 1,
                                  child: Container(
                                    width: 100.w,
                                    padding: EdgeInsets.symmetric(vertical: 3.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1.h),
                                      color: AppColors.Color_FAFAFA,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/images/Upload.png", height: 5.h),
                                        SizedBox(height: 1.h),
                                        Text(
                                          "Browse File",
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AppColors.fontFamilySemiBold,
                                            color: AppColors.Color_9E9E9E,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                            ],
                          ),
                        // Display existing or newly selected document
                        if (provider.getCurrentMetalWorkingSkillDocumentPath() != null)
                          GestureDetector(
                            onTap: () {
                              String? documentPath = provider.getCurrentMetalWorkingSkillDocumentPath();
                              print("Document path for opening: $documentPath"); // Debug print
                              if (documentPath != null && documentPath.isNotEmpty) {
                                OpenFile_View(documentPath, context);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(1.h),
                                // border: Border.all(color: AppColors.buttonColor, width: 1),
                              ),

                              child: Row(
                                children: [
                                  Image.asset("assets/images/Paper.png", height: 3.5.h,color: Colors.red,),
                                  SizedBox(width: 2.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          " ${provider.getCurrentMetalWorkingSkillDocumentPath()?.split('/').last ?? 'Unknown'}", // Debug text
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.Color_212121,
                                            fontFamily: AppColors.fontFamilyBold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        if (provider.metalWorkingSkillDocument != null)
                                          FutureBuilder<int>(
                                            future: provider.metalWorkingSkillDocument!.length(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                                  style: TextStyle(
                                                    fontSize: AppFontSize.fontSize12,
                                                    color: AppColors.Color_616161,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: AppColors.fontFamilyMedium,
                                                  ),
                                                );
                                              }
                                              return SizedBox();
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      provider.removeMetalWorkingSkillDocument();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        // Debug: Always show the current state
                        SizedBox(height: 1.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              // height: 9.h,
                              // width: 30.w,
                              padding: EdgeInsets.symmetric(horizontal: .5.w, vertical: 2.h),
                              child: customButton(
                                voidCallback: () {
                                  // Clear form data
                                  provider.setMetalWorkingSkillsVisibility(false);
                                  provider.metalWorkingSkill = null;
                                  provider.metalWorkingSkillLevel = null;
                                  provider.metalWorkingSkillCertificate = false;
                                  provider.metalWorkingSkillDocument = null;
                                  provider.metalWorkingSkills_IsEdit = false;
                                  provider.metalWorkingSkills_Edit_Index = null;
                                },
                                buttonText: "Cancel",
                                width: 30.w,
                                height: 10.w,
                                color: AppColors.Color_BDBDBD,
                                buttonTextColor: AppColors.buttonTextWhiteColor,
                                shadowColor: AppColors.buttonBorderColor,
                                fontSize: AppFontSize.fontSize18,
                                showShadow: true,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
                  ),
                ),
            ],
          )
      ]
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
                        if(provider.tankCoatingExperience_IsEdit) {
                          provider.setTankCoatingExperienceVisibility(true);
                          provider.showAddSection_tankCoatingExperience = true;
                        }else if (provider.showAddSection_tankCoatingExperience){
                          provider.setTankCoatingExperienceVisibility(false);
                          provider.showAddSection_tankCoatingExperience = false;
                        }else{
                          provider.setTankCoatingExperienceVisibility(true);
                          provider.showAddSection_tankCoatingExperience = true;
                        }
                        provider.tankCoatingType = null;
                        provider.tankCoatingExperience_IsEdit = false;
                        provider.tankCoatingExperience_Edit_Index = null;
                        // provider.showAddSection_tankCoatingExperience =!provider.showAddSection_tankCoatingExperience;
                        // provider.setTankCoatingExperienceVisibility(provider.showAddSection_tankCoatingExperience);
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
    if(provider.tankCoatingExperience_IsEdit){
    showToast("Updating or cancel the current record before continuing.");
    }else {
      provider.removeTankCoatingExperience(index);
    }
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.buttonColor.withOpacity(0.15), // 👈 shadow color
                        blurRadius: 0,   // how soft the shadow is
                        spreadRadius: 0, // how wide it spreads
                        // offset: const Offset(4, 4), // X, Y position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(2.h),
                    border: Border.all(
                      color: AppColors.buttonColor, // Set the border color here
                      width: 1, // You can adjust the width of the border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            provider.tankCoatingExperience_IsEdit?'Edit Tank Coating Experience Detail':'Add Tank Coating Experience Detail',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize19,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Text("Type"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.Color_FAFAFA,
                              borderRadius: BorderRadius.circular(2.h),
                            ),
                            child: SearchChoices.single(
                              items: provider.getAvailableTankCoatingTypes().map((item) {
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
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              // height: 9.h,
                              // width: 30.w,
                              padding: EdgeInsets.symmetric(horizontal: .5.w, vertical: 2.h),
                              child: customButton(
                                voidCallback: () {
                                  // Clear form data
                                  provider.setTankCoatingExperienceVisibility(false);
                                  provider.tankCoatingType = null;
                                  provider.tankCoatingExperience_IsEdit = false;
                                  provider.tankCoatingExperience_Edit_Index = null;
                                },
                                buttonText: "Cancel",
                                width: 30.w,
                                height: 10.w,
                                color: AppColors.Color_BDBDBD,
                                buttonTextColor: AppColors.buttonTextWhiteColor,
                                shadowColor: AppColors.buttonBorderColor,
                                fontSize: AppFontSize.fontSize18,
                                showShadow: true,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
                  ),
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
                        if(provider.portStateControlExperience_IsEdit) {
                          provider.setPortStateControlExperienceVisibility(true);
                          provider.showAddSection_portStateControlExperience = true;
                        }else if (provider.showAddSection_portStateControlExperience){
                          provider.setPortStateControlExperienceVisibility(false);
                          provider.showAddSection_portStateControlExperience = false;
                        }else{
                          provider.setPortStateControlExperienceVisibility(true);
                          provider.showAddSection_portStateControlExperience = true;
                        }

                        provider.regionalAgreement = null;
                        provider.port = null;
                        provider.dateController.clear();
                        provider.observationsController.clear();
                        provider.portStateControlExperience_IsEdit = false;
                        provider.portStateControlExperience_Edit_Index = null;
                        // provider.showAddSection_portStateControlExperience=!provider.showAddSection_portStateControlExperience;
                        // provider.setPortStateControlExperienceVisibility(provider.showAddSection_portStateControlExperience);
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
                              if (item.observations.isNotEmpty)
                                SizedBox(height: 0.5.h),
                              if (item.observations.isNotEmpty)
                                Text(
                                  "Observations: ${item.observations}",
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
                            provider.editPortStateControlExperience(index);
                          },
                          child: Image.asset(
                            "assets/images/Edit.png",
                            height: 2.h,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        GestureDetector(
                          onTap: () {
    if(provider.portStateControlExperience_IsEdit){
    showToast("Updating or cancel the current record before continuing.");
    }else {
      provider.removePortStateControlExperience(index);
    }
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
              if (provider.showAddSection_portStateControlExperience)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.buttonColor.withOpacity(0.15), // 👈 shadow color
                        blurRadius: 0,   // how soft the shadow is
                        spreadRadius: 0, // how wide it spreads
                        // offset: const Offset(4, 4), // X, Y position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(2.h),
                    border: Border.all(
                      color: AppColors.buttonColor, // Set the border color here
                      width: 1, // You can adjust the width of the border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            provider.portStateControlExperience_IsEdit?'Edit Port State Control Experience Detail':'Add Port State Control Experience Detail',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize19,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Text("Regional Agreement"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.Color_FAFAFA,
                              borderRadius: BorderRadius.circular(2.h),
                            ),
                            child: SearchChoices.single(
                              items: provider.getAvailableRegionalAgreements().map((item) {
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
                        ),
                        SizedBox(height: 1.h),
                        Text("Port"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.Color_FAFAFA,
                              borderRadius: BorderRadius.circular(2.h),
                            ),
                            child: SearchChoices.single(
                              items: provider.getAvailablePorts().map((item) {
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
                        ),
                        SizedBox(height: 1.h),
                        Text("Date"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: GestureDetector(
                            onTap: () async {
                              // Clear focus from all fields before opening date picker
                              FocusScope.of(context).unfocus();
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
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
                                focusNode: provider.dateFocusNode,
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
                                activeFillColor: AppColors.activeFieldBgColor,
                                onFieldSubmitted: (String) {},
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text("Observations"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: customTextField(
                            context: context,
                            controller: provider.observationsController,
                            focusNode: provider.observationsFocusNode,
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
                            activeFillColor: AppColors.activeFieldBgColor,
                            onFieldSubmitted: (String) {},
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              // height: 9.h,
                              // width: 30.w,
                              padding: EdgeInsets.symmetric(horizontal: .5.w, vertical: 2.h),
                              child: customButton(
                                voidCallback: () {
                                  // Clear form data
                                  provider.setPortStateControlExperienceVisibility(false);
                                  provider.regionalAgreement = null;
                                  provider.port = null;
                                  provider.dateController.clear();
                                  provider.observationsController.clear();
                                  provider.portStateControlExperience_IsEdit = false;
                                  provider.portStateControlExperience_Edit_Index = null;
                                },
                                buttonText: "Cancel",
                                width: 30.w,
                                height: 10.w,
                                color: AppColors.Color_BDBDBD,
                                buttonTextColor: AppColors.buttonTextWhiteColor,
                                shadowColor: AppColors.buttonBorderColor,
                                fontSize: AppFontSize.fontSize18,
                                showShadow: true,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
                  ),
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: customTextField(
            context: context,
            controller: provider.inspectionByController,
            focusNode: provider.inspectionByFocusNode,
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
            activeFillColor: AppColors.activeFieldBgColor,
            onFieldSubmitted: (String) {},
          ),
        ),
        SizedBox(height: 1.h),
        Text("Port"),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.Color_FAFAFA,
              borderRadius: BorderRadius.circular(2.h),
            ),
            child: SearchChoices.single(
              items: provider.getAvailableVettingPorts().map((item) {
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
        ),
        SizedBox(height: 1.h),
        Text("Date"),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: GestureDetector(
            onTap: () async {
              // Clear focus from all fields before opening date picker
              FocusScope.of(context).unfocus();
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
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
                focusNode: provider.vettingDateFocusNode,
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
                activeFillColor: AppColors.activeFieldBgColor,
                onFieldSubmitted: (String) {},
              ),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Text("Observations"),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: customTextField(
            context: context,
            controller: provider.vettingObservationsController,
            focusNode: provider.vettingObservationsFocusNode,
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
            activeFillColor: AppColors.activeFieldBgColor,
            onFieldSubmitted: (String) {},
          ),
        ),
        SizedBox(height: 1.h),
        // Document Attachment
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 1.h),
        //   child: Text(
        //     'Document',
        //     style: TextStyle(
        //       fontSize: AppFontSize.fontSize16,
        //       fontWeight: FontWeight.w500,
        //       fontFamily: AppColors.fontFamilyMedium,
        //       color: AppColors.Color_424242,
        //     ),
        //   ),
        // ),
        // GestureDetector(
        //   onTap: () async {
        //     await provider.showAttachmentOptions(context, 'vettingDocument');
        //   },
        //   child: DottedBorder(
        //     borderType: BorderType.RRect,
        //     radius: Radius.circular(15),
        //     dashPattern: [10, 10],
        //     color: AppColors.buttonColor,
        //     strokeWidth: 1,
        //     child: Container(
        //       width: 100.w,
        //       padding: EdgeInsets.symmetric(vertical: 3.h),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(1.h),
        //         color: AppColors.Color_FAFAFA,
        //       ),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Image.asset("assets/images/Upload.png", height: 5.h),
        //           SizedBox(height: 1.h),
        //           Text(
        //             "Browse File",
        //             style: TextStyle(
        //               fontSize: AppFontSize.fontSize14,
        //               fontWeight: FontWeight.w500,
        //               fontFamily: AppColors.fontFamilySemiBold,
        //               color: AppColors.Color_9E9E9E,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(height: 10,),
        // if ((provider.vettingInspectionDocument != null && provider.vettingInspectionDocument!.path.isNotEmpty) ||
        //     (provider.vettingInspectionDocumentPath != null && provider.vettingInspectionDocumentPath!.isNotEmpty))
        //   GestureDetector(
        //     onTap: (){
        //       OpenFile_View(provider.vettingInspectionDocument==null?provider.vettingInspectionDocumentPath:provider.vettingInspectionDocument!.path,context);
        //     },
        //     child: Container(
        //       padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        //       decoration: BoxDecoration(
        //         color: Colors.red.shade100,
        //         borderRadius: BorderRadius.circular(1.h),
        //       ),
        //       child: Row(
        //         children: [
        //           Image.asset("assets/images/Paper.png", height: 3.5.h),
        //           SizedBox(width: 2.w),
        //           Expanded(
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   provider.vettingInspectionDocument != null
        //                     ? provider.vettingInspectionDocument!.path.split('/').last
        //                     : provider.vettingInspectionDocumentPath != null
        //                       ? provider.vettingInspectionDocumentPath!.split('/').last
        //                       : '',
        //                   style: TextStyle(
        //                     fontSize: AppFontSize.fontSize16,
        //                     fontWeight: FontWeight.w700,
        //                     color: AppColors.Color_212121,
        //                     fontFamily: AppColors.fontFamilyBold,
        //                   ),
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //                 if (provider.vettingInspectionDocument != null)
        //                   FutureBuilder<int>(
        //                     future: provider.vettingInspectionDocument!.length(),
        //                     builder: (context, snapshot) {
        //                       if (snapshot.hasData) {
        //                         return Text(
        //                           "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
        //                           style: TextStyle(
        //                             fontSize: AppFontSize.fontSize12,
        //                             color: AppColors.Color_616161,
        //                             fontWeight: FontWeight.w500,
        //                             fontFamily: AppColors.fontFamilyMedium,
        //                           ),
        //                         );
        //                       }
        //                       return SizedBox();
        //                     },
        //                   ),
        //               ],
        //             ),
        //           ),
        //           GestureDetector(
        //             onTap: () async {
        //               provider.removeAttachment('vettingDocument');
        //               // Update the UI
        //               (context as Element).markNeedsBuild();
        //             },
        //             child: Icon(
        //               Icons.close,
        //               color: Colors.red,
        //               size: 24,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // SizedBox(height: 10,)
      ],
    );
  }

  Widget buildTradingAreaExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Trading Area Experience"),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Container(
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
              initialValue: provider.tradingAreaExperience,
              decoration: BoxDecoration(
                color: AppColors.Color_FAFAFA,
                borderRadius: BorderRadius.circular(10),
              ),
              buttonIcon:
                  Icon(Icons.arrow_drop_down, color: AppColors.buttonColor),
              buttonText: Text("Select Trading Area"),
              onConfirm: (values) {
                provider.tradingAreaExperience = values.cast<String>();
              },
            ),
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

