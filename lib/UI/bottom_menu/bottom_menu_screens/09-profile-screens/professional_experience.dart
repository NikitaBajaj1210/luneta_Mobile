import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/professional_experience_provider.dart';
import '../../../../const/Enums.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../custom-component/custom-button.dart';

class ProfessionalExperienceScreen extends StatefulWidget {
  const ProfessionalExperienceScreen({super.key});

  @override
  State<ProfessionalExperienceScreen> createState() => _ProfessionalExperienceScreenState();
}

class _ProfessionalExperienceScreenState extends State<ProfessionalExperienceScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfessionalExperienceProvider>(
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
                      title: "Professional Experience",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Positions Held (Multiselect Dropdown)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Positions Held',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),

                    Container(
                      width: 90.w,
                      padding: EdgeInsets.symmetric(horizontal: 0.1.w),
                      decoration: BoxDecoration(
                        color: AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                        border: Border.all(
                          color: AppColors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: MultiSelectDialogField(
                          searchable: true,
                          searchHint: 'Search Position',
                          dialogHeight: 30.h,
                          items: predefinedPositionList.map((e) => MultiSelectItem(e["key"], e["value"]!)).toList(),
                          title: Text("Positions"),
                          selectedColor: AppColors.buttonColor,
                          decoration: BoxDecoration(
                            color: AppColors.Color_FAFAFA,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.buttonColor, width: 1),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down, color: AppColors.buttonColor,),
                          buttonText: Text("Select Positions"),
                          onConfirm: (values) {
                            setState(() {
                              provider.setPositionsHeld(values.cast<String>());
                            });
                          },
                        ),
                      )
                    ),

                    // Vessel Type Experience (Multiselect Dropdown)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Vessel Type Experience',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    Container(
                        width: 90.w,
                        padding: EdgeInsets.symmetric(horizontal: 0.1.w),
                        decoration: BoxDecoration(
                          color: AppColors.Color_FAFAFA,
                          borderRadius: BorderRadius.circular(2.h),
                          border: Border.all(
                            color: AppColors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: MultiSelectDialogField(
                            searchable: true,
                            dialogHeight: 30.h,
                            searchHint: 'Search Vessel Type',
                            items: vesselTypeList.map((e) => MultiSelectItem(e["key"], e["value"]!)).toList(),
                            title: Text('Vessel Type'),
                            selectedColor: AppColors.buttonColor,
                            decoration: BoxDecoration(
                              color: AppColors.Color_FAFAFA,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.buttonColor, width: 1),
                            ),
                            buttonIcon: Icon(Icons.arrow_drop_down, color: AppColors.buttonColor,),
                            buttonText: Text('Select Vessel Type'),
                            onConfirm: (values) {
                              setState(() {
                                provider.setVesselTypeExperience(values.cast<String>());
                              });
                            },
                          ),
                        )
                    ),

                    // Container(
                    //   width: 90.w,
                    //   padding: EdgeInsets.symmetric(horizontal: 0.1.w),
                    //   decoration: BoxDecoration(
                    //     color: AppColors.Color_FAFAFA,
                    //     borderRadius: BorderRadius.circular(2.h),
                    //     border: Border.all(
                    //       color: AppColors.transparent,
                    //       width: 1,
                    //     ),
                    //   ),
                    //   child: Padding(
                    //     padding: EdgeInsets.only(left: 8.0),
                    //     child: DropdownButton<String>(
                    //       value: provider.vesselTypeExperience,
                    //       isExpanded: true,
                    //       hint: Text(),
                    //       onChanged: (newValue) {
                    //         provider.setVesselTypeExperience(newValue!);
                    //       },
                    //       items: ['Bulk Carrier', 'Tanker', 'Cargo Ship'].map((value) {
                    //         return DropdownMenuItem<String>(
                    //           value: value,
                    //           child: Text(value),
                    //         );
                    //       }).toList(),
                    //       underline: SizedBox(),
                    //     ),
                    //   ),
                    // ),

                    // Employment History (Repeater)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Employment History',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: (){
                              provider.setEmploymentHistoryVisibility(true);
                              provider.employment_Edit_Index=null;
                              provider.employment_IsEdit=false;
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.5.w),
                              decoration: BoxDecoration(
                                color: AppColors.buttonColor,
                                borderRadius: BorderRadius.circular(150),
                                border: Border.all(
                                  color: AppColors.transparent, // Set the border color here
                                  width: 1, // You can adjust the width of the border
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 2.5.h,
                                color: AppColors.buttonTextWhiteColor,
                              )
                              ,),
                          ),
                        )
                      ],
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.employmentHistory.length,
                      itemBuilder: (context, index) {
                        EmploymentHistory empDetail = provider.employmentHistory[index];
                        print("position at index => ${empDetail.position}");
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.1.h,
                                            color: AppColors
                                                .Color_EEEEEE),
                                        borderRadius:
                                        BorderRadius.circular(
                                            2.h)),
                                    padding: EdgeInsets.all(1.2.h),
                                    child: Image.asset(
                                      "assets/images/companyLogo.png",
                                      height: 5.h,
                                      width: 5.h,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Container(
                                    // color:Colors.red,
                                    width: 64.w,
                                    margin:
                                    EdgeInsets.only(bottom: 2.h),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(empDetail.companyName,
                                              style: TextStyle(
                                                fontSize: AppFontSize
                                                    .fontSize20,
                                                fontWeight:
                                                FontWeight.w700,
                                                color: AppColors
                                                    .Color_212121,
                                                fontFamily: AppColors
                                                    .fontFamilyBold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap:(){
                                               provider.companyController.text =empDetail.companyName;
                                               provider.setEmpHisPositionsHeld(empDetail.position);
                                               provider.startDate.text =empDetail.startDate ;
                                               provider.endDate.text =empDetail.endDate;
                                               provider.responsibilitiesController.text=empDetail.responsibilities;
                                               provider.setEmploymentHistoryVisibility(true);
                                               provider.employment_Edit_Index=index;
                                               provider.employment_IsEdit=true;
                                              },
                                              child: Image.asset(
                                                "assets/images/Edit.png",
                                                height: 2.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Wrap(
                                          spacing: 2.w,
                                          // Space between chips horizontally
                                          runSpacing: 1.h,
                                          // Space between chips vertically
                                          children: empDetail.position
                                              .map((position) => Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w, vertical: 1.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50.h),
                                              border: Border.all(
                                                  color: AppColors.buttonColor,
                                                  width: 0.15.h),
                                            ),
                                            child: Text(
                                              position,
                                              style: TextStyle(
                                                fontSize:
                                                AppFontSize.fontSize14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.buttonColor,
                                                fontFamily: AppColors
                                                    .fontFamilySemiBold,
                                              ),
                                            ),
                                          ))
                                              .toList(),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(empDetail.startDate +" - "+empDetail.endDate,
                                          style: TextStyle(
                                            fontSize: AppFontSize
                                                .fontSize14,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: AppColors
                                                .Color_212121,
                                            fontFamily: AppColors
                                                .fontFamilyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image.asset(IconPath,
                                //   height: 2.h,
                                // ),
                                // SizedBox(width: 3.w),
                                Text("Responsibilities: ",
                                  style: TextStyle(
                                      fontSize: AppFontSize.fontSize16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.Color_212121,
                                      fontFamily:
                                      AppColors.fontFamilyMedium),
                                ),
                                Expanded(
                                  child: Text(empDetail.responsibilities,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.Color_212121,
                                        fontFamily:
                                        AppColors.fontFamilyMedium),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                          ],
                        );

                        //   EmploymentHistoryField(
                        //   onEdit: (updatedHistory) {
                        //     provider.updateEmploymentHistory(index, updatedHistory);
                        //   },
                        //   onDelete: () {
                        //     provider.removeEmploymentHistory(index);
                        //   }, history: provider.employmentHistory[index],
                        // );
                      },
                    ),



                    // Button to Add/Edit Employment History
                    provider.showAddSection_employmentHistory ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Company Name',
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
                          controller: provider.companyController,
                          hintText: 'Enter Company Name',
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
                          fillColor: provider.companyFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Position',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),



                        Container(
                            width: 90.w,
                            padding: EdgeInsets.symmetric(horizontal: 0.1.w),
                            decoration: BoxDecoration(
                              color: AppColors.Color_FAFAFA,
                              borderRadius: BorderRadius.circular(2.h),
                              border: Border.all(
                                color: AppColors.transparent,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: MultiSelectDialogField(
                                searchable: true,
                                dialogHeight: 30.h,
                                searchHint: 'Search Position',
                                initialValue: provider.empHisPositionsHeld,
                                items: vesselTypeList.map((e) => MultiSelectItem(e["value"], e["key"]!)).toList(),
                                title: Text('Position'),
                                selectedColor: AppColors.buttonColor,
                                decoration: BoxDecoration(
                                  color: AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.buttonColor, width: 1),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down, color: AppColors.buttonColor,),
                                buttonText: Text('Select Position'),
                                onConfirm: (values) {
                                    print("values ${values}");
                                    provider.setEmpHisPositionsHeld(values.cast<String>());
                                },
                              ),
                            )
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Start Date',
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
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setStartDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.startDate,
                              hintText: 'Select Start Date',
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
                              fillColor: provider.startDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'End Date',
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
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setEndDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.endDate,
                              hintText: 'Select End Date',
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
                              fillColor: provider.endDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Responsibilities',
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
                          controller: provider.responsibilitiesController,
                          hintText: 'Enter Responsibilities',
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
                          fillColor: provider.responsibilitiesFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                            child: customButton(
                              voidCallback: () async {
                                print("click => ${provider.empHisPositionsHeld}");
                                // Validate fields and add employment history
                                if (provider.companyController.text.isNotEmpty &&
                                    provider.empHisPositionsHeld.isNotEmpty &&
                                    provider.startDate.text.isNotEmpty &&
                                    provider.endDate.text.isNotEmpty &&
                                    provider.responsibilitiesController.text.isNotEmpty) {
                                  if (!provider.employment_IsEdit) {
                                    await provider.addEmploymentHistory(EmploymentHistory(companyName: provider.companyController.text, position: provider.empHisPositionsHeld, startDate: provider.startDate.text, endDate: provider.endDate.text, responsibilities: provider.responsibilitiesController.text));
                                  } else {
                                    await provider.updateEmploymentHistory(provider.employment_Edit_Index!,EmploymentHistory(companyName: provider.companyController.text, position: provider.empHisPositionsHeld, startDate: provider.startDate.text, endDate: provider.endDate.text, responsibilities: provider.responsibilitiesController.text));
                                  }
                                  provider.companyController.clear();
                                  provider.startDate.clear();
                                  provider.endDate.clear();
                                  provider.responsibilitiesController.clear();
                                  // provider.empHisPositionsHeld.clear();
                                  provider.employment_IsEdit=false;
                                  provider.employment_Edit_Index=null;
                                  provider.setEmploymentHistoryVisibility(false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please fill in all required fields'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              buttonText: provider.employment_IsEdit ? "Update" : "Add",
                              width: 30.w,
                              height: 10.w,
                              color: AppColors.buttonColor,
                              buttonTextColor: AppColors.buttonTextWhiteColor,
                              shadowColor: AppColors.buttonBorderColor,
                              fontSize: AppFontSize.fontSize18,
                              showShadow: true,
                            ),
                          ),
                        ),
                      ],
                    ) : Container(),



                    // References (Repeater)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'References',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: (){
                              provider.setReferenceVisibility(true);
                              provider.reference_Edit_Index=null;
                              provider.reference_IsEdit=false;
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.5.w),
                              decoration: BoxDecoration(
                                color: AppColors.buttonColor,
                                borderRadius: BorderRadius.circular(150),
                                border: Border.all(
                                  color: AppColors.transparent, // Set the border color here
                                  width: 1, // You can adjust the width of the border
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 2.5.h,
                                color: AppColors.buttonTextWhiteColor,
                              )
                              ,),
                          ),
                        )
                      ],
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.references.length,
                      itemBuilder: (context, index) {
                        Reference referenceDetail = provider.references[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.1.h,
                                            color: AppColors
                                                .Color_EEEEEE),
                                        borderRadius:
                                        BorderRadius.circular(
                                            2.h)),
                                    padding: EdgeInsets.all(1.2.h),
                                    child: Image.asset(
                                      "assets/images/companyLogo.png",
                                      height: 5.h,
                                      width: 5.h,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Container(
                                    // color:Colors.red,
                                    width: 64.w,
                                    margin:
                                    EdgeInsets.only(bottom: 2.h),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(referenceDetail.vesselOrCompanyName,
                                              style: TextStyle(
                                                fontSize: AppFontSize
                                                    .fontSize20,
                                                fontWeight:
                                                FontWeight.w700,
                                                color: AppColors
                                                    .Color_212121,
                                                fontFamily: AppColors
                                                    .fontFamilyBold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap:(){
                                                provider.referenceVesselController.text =referenceDetail.vesselOrCompanyName;
                                                provider.referenceIssuedDate.text =referenceDetail.issuingDate ;
                                                provider.setReferenceIssuedBy(referenceDetail.issuedBy);
                                                provider.referenceDocumentController.text=referenceDetail.documentUrl;
                                                provider.setReferenceVisibility(true);
                                                provider.reference_Edit_Index=index;
                                                provider.reference_IsEdit=true;
                                              },
                                              child: Image.asset(
                                                "assets/images/Edit.png",
                                                height: 2.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.5.h),

                                        SizedBox(height: 0.5.h),
                                        Text(referenceDetail.issuingDate,
                                          style: TextStyle(
                                            fontSize: AppFontSize
                                                .fontSize14,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: AppColors
                                                .Color_212121,
                                            fontFamily: AppColors
                                                .fontFamilyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Issued By: ",
                                  style: TextStyle(
                                      fontSize: AppFontSize.fontSize16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.Color_212121,
                                      fontFamily:
                                      AppColors.fontFamilyMedium),
                                ),
                                Expanded(
                                  child: Text(referenceDetail.issuedBy,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.Color_212121,
                                        fontFamily:
                                        AppColors.fontFamilyMedium),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                          ],
                        );
                      },
                    ),
                    provider.showAddSection_reference ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Vessel/Company Name',
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
                          controller: provider.referenceVesselController,
                          hintText: 'Enter Vessel/Company Name',
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
                          fillColor: provider.referenceVesselFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Issued By',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),

                        Container(
                          width: 90.w,
                          padding: EdgeInsets.symmetric(horizontal: 0.1.w),
                          decoration: BoxDecoration(
                            color: AppColors.Color_FAFAFA,
                            borderRadius: BorderRadius.circular(2.h),
                            border: Border.all(
                              color: AppColors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: DropdownButton<String>(
                              value: provider.referenceIssuedBy,
                              isExpanded: true,
                              hint: Text("Select Issued By"),
                              onChanged: (newValue) {
                                provider.setReferenceIssuedBy(newValue!);
                              },
                              items: ['Company', 'Vessel'].map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              underline: SizedBox(),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Issued Date',
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
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setReferenceIssuingDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.referenceIssuedDate,
                              hintText: 'Select Issued Date',
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
                              fillColor: provider.referenceIssuedDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Document',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            provider.pickImage();
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.referenceDocumentController,
                              hintText: 'Attach Document',
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
                              fillColor: provider.referenceDocumentFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                            child: customButton(
                              voidCallback: () async {
                                if (provider.referenceVesselController.text.isNotEmpty &&
                                    provider.referenceIssuedBy != null &&
                                    provider.referenceIssuedDate.text.isNotEmpty &&
                                    provider.referenceDocumentController.text.isNotEmpty) {
                                  if (!provider.reference_IsEdit) {
                                    await provider.addReference(Reference(vesselOrCompanyName: provider.referenceVesselController.text, issuedBy: provider.referenceIssuedBy!, issuingDate: provider.referenceIssuedDate.text, documentUrl: provider.referenceDocumentController.text));
                                  } else {
                                    await provider.updateReference(provider.reference_Edit_Index!,Reference(vesselOrCompanyName: provider.referenceVesselController.text, issuedBy: provider.referenceIssuedBy!, issuingDate: provider.referenceIssuedDate.text, documentUrl: provider.referenceDocumentController.text));
                                  }
                                  provider.referenceVesselController.clear();
                                  provider.referenceIssuedBy = null;
                                  provider.referenceIssuedDate.clear();
                                  provider.referenceDocumentController.clear();
                                  provider.reference_IsEdit=false;
                                  provider.reference_Edit_Index=null;
                                  provider.setReferenceVisibility(false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please fill in all required fields'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              buttonText: provider.reference_IsEdit ? "Update" : "Add",
                              width: 30.w,
                              height: 10.w,
                              color: AppColors.buttonColor,
                              buttonTextColor: AppColors.buttonTextWhiteColor,
                              shadowColor: AppColors.buttonBorderColor,
                              fontSize: AppFontSize.fontSize18,
                              showShadow: true,
                            ),
                          ),
                        ),
                      ],
                    ) : Container(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ReferenceField extends StatelessWidget {
  final Reference reference;
  final Function(Reference) onEdit;
  final VoidCallback onDelete;

  const ReferenceField({
    Key? key,
    required this.reference,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Issued By: ${reference.issuedBy}"),
                Text("Vessel/Company: ${reference.vesselOrCompanyName}"),
                Text("Issued On: ${reference.issuingDate}"),
                SizedBox(height: 1.h),
                Text("Document: ${reference.documentUrl}"),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => onEdit(reference),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class EmploymentHistoryField extends StatelessWidget {
  final EmploymentHistory history;
  final Function(EmploymentHistory) onEdit;
  final VoidCallback onDelete;

  const EmploymentHistoryField({
    Key? key,
    required this.history,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Company: ${history.companyName}"),
                Text("Position: ${history.position}"),
                Text("Start Date: ${history.startDate}"),
                Text("End Date: ${history.endDate}"),
                SizedBox(height: 1.h),
                Text("Responsibilities: ${history.responsibilities}"),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => onEdit(history),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
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


