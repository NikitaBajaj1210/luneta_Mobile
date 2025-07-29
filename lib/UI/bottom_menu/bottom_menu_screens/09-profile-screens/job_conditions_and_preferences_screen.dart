import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:search_choices/search_choices.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/job_conditions_and_preferences_provider.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../custom-component/custom-button.dart';

class JobConditionsAndPreferencesScreen extends StatefulWidget {
  const JobConditionsAndPreferencesScreen({super.key});

  @override
  State<JobConditionsAndPreferencesScreen> createState() => _JobConditionsAndPreferencesScreenState();
}

class _JobConditionsAndPreferencesScreenState extends State<JobConditionsAndPreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobConditionsAndPreferencesProvider>(
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
                  if (provider.autovalidateMode == AutovalidateMode.disabled) {
                    setState(() {
                      provider.autovalidateMode = AutovalidateMode.always;
                    });
                  }
                  if (provider.formKey.currentState!.validate()) {
                    // Save the data in provider or update the profile here
                    Navigator.pop(context);
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
                        title: "Job Conditions and Preferences",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 2.h),

                      // Current Rank / Position
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Current Rank / Position*',
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
                          items: provider.ranks.map((rank) {
                            return DropdownMenuItem(
                              child: Text(rank),
                              value: rank,
                            );
                          }).toList(),
                          value: provider.currentRank,
                          hint: "Select Rank",
                          searchHint: "Search for a rank",
                          onChanged: (value) {
                            provider.setCurrentRank(value as String);
                          },
                          isExpanded: true,
                          underline: SizedBox(),
                          onClear: (){
                            provider.setCurrentRank('');
                          },
                          autovalidateMode: provider.autovalidateMode,
                          validator: (value) {
                            if (value == null && provider.autovalidateMode== AutovalidateMode.always) {
                              return 'Please select a rank';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Alternate Rank / Position
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Alternate Rank / Position',
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
                          items: provider.ranks.map((rank) {
                            return DropdownMenuItem(
                              child: Text(rank),
                              value: rank,
                            );
                          }).toList(),
                          value: provider.alternateRank,
                          hint: "Select Rank",
                          searchHint: "Search for a rank",
                          onChanged: (value) {
                            provider.setAlternateRank(value as String);
                          },
                          isExpanded: true,
                          underline: SizedBox(),
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Preferred Vessel Type
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Preferred Vessel Type*',
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
                          items: provider.vesselTypes.map((e) => MultiSelectItem(e, e)).toList(),
                          title: Text("Preferred Vessel Types"),
                          selectedColor: AppColors.buttonColor,
                          searchable: true,
                          decoration: BoxDecoration(
                            color: AppColors.Color_FAFAFA,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.buttonColor, width: 1),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down, color: AppColors.buttonColor),
                          buttonText: Text("Select Preferred Vessel Types"),
                          onConfirm: (values) {
                            provider.setPreferredVesselTypes(values.cast<String>());
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select at least one vessel type';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Preferred Contract Type
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Preferred Contract Type',
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
                          items: provider.contractTypes.map((type) {
                            return DropdownMenuItem(
                              child: Text(type),
                              value: type,
                            );
                          }).toList(),
                          value: provider.preferredContractType,
                          hint: "Select Contract Type",
                          searchHint: "Search for a contract type",
                          onChanged: (value) {
                            provider.setPreferredContractType(value as String);
                          },
                          isExpanded: true,
                          underline: SizedBox(),
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Preferred Position
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Preferred Position',
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
                          items: provider.ranks.map((rank) {
                            return DropdownMenuItem(
                              child: Text(rank),
                              value: rank,
                            );
                          }).toList(),
                          value: provider.preferredPosition,
                          hint: "Select Position",
                          searchHint: "Search for a position",
                          onChanged: (value) {
                            provider.setPreferredPosition(value as String);
                          },
                          isExpanded: true,
                          underline: SizedBox(),
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Manning Agency
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Manning Agency*',
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
                          items: provider.manningAgencies.map((agency) {
                            return DropdownMenuItem(
                              child: Text(agency),
                              value: agency,
                            );
                          }).toList(),
                          value: provider.manningAgency,
                          hint: "Select Manning Agency",
                          searchHint: "Search for an agency",
                          onChanged: (value) {
                            provider.setManningAgency(value as String);
                          },
                          isExpanded: true,
                          underline: SizedBox(),
                          onClear: (){
                            provider.setManningAgency('');
                          },
                          autovalidateMode: provider.autovalidateMode,
                          validator: (value) {
                            if (value == null && provider.autovalidateMode== AutovalidateMode.always) {
                              return 'Please select a manning agency';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Availability
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Availability',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),

                      // Current Availability Status
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Current Availability Status*',
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
                          items: provider.availabilityStatuses.map((status) {
                            return DropdownMenuItem(
                              child: Text(status),
                              value: status,
                            );
                          }).toList(),
                          value: provider.currentAvailabilityStatus,
                          hint: "Select Status",
                          searchHint: "Search for a status",
                          onChanged: (value) {
                            provider.setCurrentAvailabilityStatus(value as String);
                          },
                          isExpanded: true,
                          underline: SizedBox(),
                          onClear: (){
                            provider.setCurrentAvailabilityStatus('');
                          },
                          autovalidateMode: provider.autovalidateMode,
                          validator: (value) {
                            if (value == null && provider.autovalidateMode== AutovalidateMode.always) {
                              return 'Please select a status';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Available From
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Available From*',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            provider.setAvailableFrom(picked);
                          }
                        },
                        child: AbsorbPointer(
                          child: customTextField(
                            context: context,
                            controller: TextEditingController(
                                text: provider.availableFrom == null
                                    ? ''
                                    : "${provider.availableFrom!.toLocal()}".split(' ')[0]),
                            hintText: 'Select Date',
                            textInputType: TextInputType.datetime,
                            obscureText: false,
                            voidCallback: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a date';
                              }
                              return null;
                            },
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

                      // Min. on Board Duration
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Min. on Board Duration* (Months)',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),
                      customTextField(
                        context: context,
                        controller: provider.minOnBoardDurationController,
                        hintText: 'Enter Duration',
                        textInputType: TextInputType.number,
                        obscureText: false,
                        voidCallback: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter duration';
                          }
                          return null;
                        },
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

                      // Max. on Board Duration
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Max. on Board Duration* (Months)',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),
                      customTextField(
                        context: context,
                        controller: provider.maxOnBoardDurationController,
                        hintText: 'Enter Duration',
                        textInputType: TextInputType.number,
                        obscureText: false,
                        voidCallback: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter duration';
                          }
                          return null;
                        },
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

                      // Min. at Home Duration
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Min. at Home Duration (Months)',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),
                      customTextField(
                        context: context,
                        controller: provider.minAtHomeDurationController,
                        hintText: 'Enter Duration',
                        textInputType: TextInputType.number,
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

                      // Max. at Home Duration
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Max. at Home Duration (Months)',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),
                      customTextField(
                        context: context,
                        controller: provider.maxAtHomeDurationController,
                        hintText: 'Enter Duration',
                        textInputType: TextInputType.number,
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

                      // Preferred Rotation Pattern
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Preferred Rotation Pattern',
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
                          items: provider.rotationPatterns.map((pattern) {
                            return DropdownMenuItem(
                              child: Text(pattern),
                              value: pattern,
                            );
                          }).toList(),
                          value: provider.preferredRotationPattern,
                          hint: "Select Pattern",
                          searchHint: "Search for a pattern",
                          onChanged: (value) {
                            provider.setPreferredRotationPattern(value as String);
                          },
                          isExpanded: true,
                          underline: SizedBox(),
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Trading Area Exclusions
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Trading Area Exclusions*',
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
                          items: provider.tradingAreas.map((e) => MultiSelectItem(e, e)).toList(),
                          title: Text("Trading Area Exclusions"),
                          selectedColor: AppColors.buttonColor,
                          searchable: true,
                          decoration: BoxDecoration(
                            color: AppColors.Color_FAFAFA,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.buttonColor, width: 1),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down, color: AppColors.buttonColor),
                          buttonText: Text("Select Trading Area Exclusions"),
                          onConfirm: (values) {
                            provider.setTradingAreaExclusions(values.cast<String>());
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select at least one trading area exclusion';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Salary
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Salary',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),

                      // Last Job Salary
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Last Job Salary*',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),
                      customTextField(
                        context: context,
                        controller: provider.lastJobSalaryController,
                        hintText: 'Enter Salary',
                        textInputType: TextInputType.number,
                        obscureText: false,
                        voidCallback: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter salary';
                          }
                          return null;
                        },
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

                      // Last Rank Joined
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Last Rank Joined*',
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
                          items: provider.ranks.map((rank) {
                            return DropdownMenuItem(
                              child: Text(rank),
                              value: rank,
                            );
                          }).toList(),
                          value: provider.lastRankJoined,
                          hint: "Select Rank",
                          searchHint: "Search for a rank",
                          onClear: (){
                            provider.setLastRankJoined('');
                          },
                          autovalidateMode: provider.autovalidateMode,
                          onChanged: (value) {
                            provider.setLastRankJoined(value as String);
                          },
                          isExpanded: true,
                          underline: SizedBox(),

                          validator: (value) {
                            if (value == null && provider.autovalidateMode == AutovalidateMode.always) {
                              return 'Please select a rank';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Last Promoted Date
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Last Promoted Date',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            provider.setLastPromotedDate(picked);
                          }
                        },
                        child: AbsorbPointer(
                          child: customTextField(
                            context: context,
                            controller: TextEditingController(
                                text: provider.lastPromotedDate == null
                                    ? ''
                                    : "${provider.lastPromotedDate!.toLocal()}".split(' ')[0]),
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

                      // Currency
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Currency*',
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
                          items: provider.currencies.map((currency) {
                            return DropdownMenuItem(
                              child: Text(currency),
                              value: currency,
                            );
                          }).toList(),
                          value: provider.currency,
                          hint: "Select Currency",
                          searchHint: "Search for a currency",
                          onChanged: (value) {
                            provider.setCurrency(value as String);
                          },
                          isExpanded: true,
                          underline: SizedBox(),
                          onClear: (){
                            provider.setCurrency('');
                          },
                          autovalidateMode: provider.autovalidateMode,
                          validator: (value) {
                            if (value == null && provider.autovalidateMode == AutovalidateMode.always) {
                              return 'Please select a currency';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Justification Document
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          'Justification Document',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // await provider.showAttachmentOptions(context);
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
                      if (provider.justificationDocument != null)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(1.h),
                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.justificationDocument!.path.split('/').last,
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyBold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    FutureBuilder<int>(
                                      future: provider.justificationDocument!.length(),
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
                                  provider.removeJustificationDocument();
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
                      SizedBox(height: 10,)
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
