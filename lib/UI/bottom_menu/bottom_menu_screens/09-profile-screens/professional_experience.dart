import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/professional_experience_provider.dart';
import '../../../../Utils/helper.dart';
import '../../../../const/Enums.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/globalComponent.dart';
import '../../../../models/professional_experience_model.dart';
import '../../../../network/network_helper.dart';
import '../../../../network/network_services.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

class ProfessionalExperienceScreen extends StatefulWidget {
  const ProfessionalExperienceScreen({super.key});

  @override
  State<ProfessionalExperienceScreen> createState() => _ProfessionalExperienceScreenState();
}

class _ProfessionalExperienceScreenState extends State<ProfessionalExperienceScreen> {

  // Validation function for position names
  String? _validatePositionName(String value) {
    // First check: empty string
    if (value.isEmpty) {
      return 'please enter Position Name';
    }
    
    // Second check: only whitespace
    if (value.trim().isEmpty) {
      return 'please enter valid Position Name';
    }
    
    // Third check: contains only whitespace characters  
    if (value.replaceAll(RegExp(r'\s+'), '').isEmpty) {
      return 'please enter valid Position Name';
    }
    
    // Fourth check: emojis
    final emojiRegex = RegExp(r'[\u{1F600}-\u{1F64F}]|[\u{1F300}-\u{1F5FF}]|[\u{1F680}-\u{1F6FF}]|[\u{1F1E0}-\u{1F1FF}]|[\u{2600}-\u{26FF}]|[\u{2700}-\u{27BF}]', unicode: true);
    if (emojiRegex.hasMatch(value)) {
      return 'emojis are not allowed';
    }
    
    return null;
  }

  void _showAddPositionHeldDialog(ProfessionalExperienceProvider provider) {
    final TextEditingController _controller = TextEditingController();
    final FocusNode _focusNode = FocusNode(); // Add focus node to maintain focus
    String? errorMessage; // Remove test message
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Add Position Held'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextField(
                    context: context,
                    controller: _controller,
                    focusNode: _focusNode, // Add focus node
                    hintText: 'Enter position name',
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
                    onChange: (value) {
                      setDialogState(() {
                        errorMessage = _validatePositionName(value);
                      });
                    },
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(top: 1.h, left: 1.w),
                      child: Text(
                        errorMessage!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: AppFontSize.fontSize12,
                        ),
                      ),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel",style:TextStyle(
                    fontSize: AppFontSize.fontSize18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.buttonColor,
                  ),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Add",style:TextStyle(
                    fontSize: AppFontSize.fontSize18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.buttonColor,
                  ),),
                  onPressed: () {
                    final validation = _validatePositionName(_controller.text);
                    if (validation == null) {
                      provider.addPositionHeld(_controller.text.toString().trim(), context);
                      Navigator.of(context).pop();
                    } else {
                      setDialogState(() {
                        errorMessage = validation;
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      _focusNode.dispose(); // Dispose focus node when dialog closes
    });
  }

  void _showAddEmploymentHistoryPositionDialog(ProfessionalExperienceProvider provider) {
    final TextEditingController _controller = TextEditingController();
    final FocusNode _focusNode = FocusNode(); // Add focus node to maintain focus
    String? errorMessage; // Move outside builder to persist state
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Add Employment Position'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextField(
                    context: context,
                    controller: _controller,
                    focusNode: _focusNode, // Add focus node
                    hintText: 'Enter position name',
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
                    onChange: (value) {
                      setDialogState(() {
                        errorMessage = _validatePositionName(value);
                      });
                    },
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(top: 1.h, left: 1.w),
                      child: Text(
                        errorMessage!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: AppFontSize.fontSize12,
                        ),
                      ),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel",style:TextStyle(
                    fontSize: AppFontSize.fontSize18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.buttonColor,
                  ),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Add",style:TextStyle(
                    fontSize: AppFontSize.fontSize18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.buttonColor,
                  ),),
                  onPressed: () {
                    final validation = _validatePositionName(_controller.text);
                    if (validation == null) {
                      provider.addEmploymentHistoryPosition(_controller.text.trim(), context);
                      Navigator.of(context).pop();
                    } else {
                      setDialogState(() {
                        errorMessage = validation;
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      _focusNode.dispose(); // Dispose focus node when dialog closes
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var provider = Provider.of<ProfessionalExperienceProvider>(context,listen: false);
      
      // Reset form before fetching data
      provider.resetForm();
      provider.fetchProfessionalExperience(NetworkHelper.loggedInUserId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfessionalExperienceProvider>(
      builder: (context, provider, child) {
        return Container(
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
                  NetworkService.loading = 0;
                  String userId = NetworkHelper.loggedInUserId.isNotEmpty
                                          ? NetworkHelper.loggedInUserId
                                          : '';
                                      provider.fetchProfessionalExperience(userId, context);
                  setState(() {});
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
                    SizedBox(
                      height:1.h,
                    ),
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
          ):SafeArea(
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
                  voidCallback: () async {
                    if (provider.formKey.currentState!.validate()) {
                      // Show loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          );
                        },
                      );

                      // Call the API
                      bool success = await provider.createOrUpdateProfessionalExperienceAPI(context);
                      Navigator.of(context).pop();
                      if(success) {
                        // WidgetsBinding.instance.addPostFrameCallback((_) {
                          Provider.of<ProfileBottommenuProvider>(
                              context,
                              listen: false).getProfileInfo(context);
                        // });
                        // Hide loading indicator
                        Navigator.of(context).pop();
                      }
                    } else {
                      setState(() {
                        provider.autovalidateMode = AutovalidateMode.always;
                      });
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
                child:
                // provider.isLoading
                //     ? Center(
                //         child: CircularProgressIndicator(
                //           color: AppColors.buttonColor,
                //         ),
                //       )
                //     : provider.hasError
                //         ? Center(
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Text(
                //                   'Error: ${provider.errorMessage}',
                //                   style: TextStyle(
                //                     fontSize: AppFontSize.fontSize16,
                //                     color: Colors.red,
                //                   ),
                //                   textAlign: TextAlign.center,
                //                 ),
                //                 SizedBox(height: 2.h),
                //                 ElevatedButton(
                //                   onPressed: () {
                //                     String userId = NetworkHelper.loggedInUserId.isNotEmpty
                //                         ? NetworkHelper.loggedInUserId
                //                         : '';
                //                     provider.fetchProfessionalExperience(userId, context);
                //                   },
                //                   child: Text('Retry'),
                //                 ),
                //               ],
                //             ),
                //           )
                //         :
                SingleChildScrollView(
                  child: Form(
                    key: provider.formKey,
                    autovalidateMode: provider.autovalidateMode,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                            Padding(
                              padding: EdgeInsets.only(right: 10.0, top: 10,bottom: 7),
                              child: GestureDetector(
                                onTap: () {
                                  _showAddPositionHeldDialog(provider);
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
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: MultiSelectDialogField(
                              searchable: true,
                              searchHint: 'Search Position',
                              dialogHeight: 30.h,
                              autovalidateMode: provider.autovalidateMode,
                              validator: (value) {
                                print("positions validator ===> ${value}");
                                if(value!.length>0) {
                                  return null;
                                }else{
                                  return 'please select at least a position';
                                }
                              },
                              initialValue: provider.positionsHeld,
                              items: provider.positionsHeldList.map((e) => MultiSelectItem(e["name"], e["name"]!)).toList(),
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
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: MultiSelectDialogField(
                                searchable: true,
                                dialogHeight: 30.h,
                                searchHint: 'Search Vessel Type',
                                autovalidateMode: provider.autovalidateMode,
                                validator: (value) {
                                  if(value!.length>0) {
                                    return null;
                                  }else{
                                    return 'please select at least a Vessel Type';
                                  }
                                },
                                initialValue: provider.vesselTypeExperience,
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
                        //                       ),

                        // Show existing vessel type experience from API
                        // if (provider.professionalExperienceData != null &&
                        //     provider.professionalExperienceData!.vesselTypeExperience != null &&
                        //     provider.professionalExperienceData!.vesselTypeExperience!.isNotEmpty)
                        //   Container(
                        //     margin: EdgeInsets.symmetric(vertical: 1.h),
                        //     padding: EdgeInsets.all(2.w),
                        //     decoration: BoxDecoration(
                        //       color: Colors.green.shade50,
                        //       borderRadius: BorderRadius.circular(1.h),
                        //       border: Border.all(color: Colors.green.shade200),
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             Icon(Icons.check_circle, color: Colors.green, size: 2.h),
                        //             SizedBox(width: 1.w),
                        //             Text(
                        //               'Existing Vessel Type Experience',
                        //               style: TextStyle(
                        //                 fontSize: AppFontSize.fontSize14,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.green.shade700,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(height: 1.h),
                        //         Wrap(
                        //           spacing: 2.w,
                        //           runSpacing: 1.h,
                        //           children: provider.professionalExperienceData!.vesselTypeExperience!.map((vessel) =>
                        //             Container(
                        //               padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(50.h),
                        //                 border: Border.all(color: AppColors.buttonColor, width: 0.15.h),
                        //               ),
                        //               child: Text(
                        //                 vessel,
                        //                 style: TextStyle(
                        //                   fontSize: AppFontSize.fontSize14,
                        //                   fontWeight: FontWeight.w600,
                        //                   color: AppColors.buttonColor,
                        //                   fontFamily: AppColors.fontFamilySemiBold,
                        //                 ),
                        //               ),
                        //             )
                        //           ).toList(),
                        //         ),
                        //       ],
                        //     ),
                        //   ),

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
                              padding: EdgeInsets.only(right: 10.0,top:10),
                              child: GestureDetector(
                                onTap: (){
                                  if(provider.employment_IsEdit) {
                                    provider.setEmploymentHistoryVisibility(true);
                                    provider.showAddSection_employmentHistory = true;
                                  }else if (provider.showAddSection_employmentHistory){
                                    provider.setEmploymentHistoryVisibility(false);
                                    provider.showAddSection_employmentHistory = false;
                                  }else{
                                    provider.setEmploymentHistoryVisibility(true);
                                    provider.showAddSection_employmentHistory = true;
                                  }
                                  // Clear form data
                                  provider.companyController.clear();
                                  provider.startDate.clear();
                                  provider.endDate.clear();
                                  provider.responsibilitiesController.clear();
                                  provider.setEmpHisPositionsHeld(null);
                                  // provider.showAddSection_employmentHistory = !provider.showAddSection_employmentHistory;

                                  // provider.setEmploymentHistoryVisibility(provider.showAddSection_employmentHistory);
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
                            ProfessionalEmploymentHistory empDetail = provider.employmentHistory[index];
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
                                                Text(empDetail.companyName ?? '',
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
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap:(){
                                                       provider.companyController.text = empDetail.companyName ?? '';
                                                       provider.setEmpHisPositionsHeld(empDetail.position);
                                                       provider.startDate.text = empDetail.startDate ?? '';
                                                       provider.endDate.text = empDetail.endDate ?? '';
                                                       provider.responsibilitiesController.text = empDetail.responsibilities ?? '';
                                                       provider.setEmploymentHistoryVisibility(true);
                                                       provider.employment_Edit_Index=index;
                                                       provider.employment_IsEdit=true;
                                                      },
                                                      child: Image.asset(
                                                        "assets/images/Edit.png",
                                                        height: 2.h,
                                                      ),
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    GestureDetector(
                                                      onTap:(){
                            if(provider.employment_IsEdit){
                            showToast("Updating or cancel the current record before continuing.");
                            }else {
                              provider.removeEmploymentHistory(index);
                            }
                                                      },
                                                      child: Image.asset(
                                                        "assets/images/Delete.png",
                                                        height: 2.h,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 0.5.h),
                                            Wrap(
                                              spacing: 2.w,
                                              // Space between chips horizontally
                                              runSpacing: 1.h,
                                              // Space between chips vertically
                                              children: [empDetail.position ?? '']
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
                                            Text((empDetail.startDate ?? '') +" - "+(empDetail.endDate ?? ''),
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
                                      child: Text(empDetail.responsibilities ?? '',
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
                        provider.showAddSection_employmentHistory ? Container(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: Text(
                                    provider.employment_IsEdit?'Edit Employment History':'Add Employment History',
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
                                  focusNode: provider.companyFocusNode,
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
                                  fillColor: AppColors.Color_FAFAFA,
                                  activeFillColor: AppColors.activeFieldBgColor,
                                  onFieldSubmitted: (String ) {  },
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
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
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.0, top: 10,bottom: 7),
                                      child: GestureDetector(
                                        onTap: () {
                                          _showAddEmploymentHistoryPositionDialog(provider);
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
                                    child: DropdownButton<dynamic>(
                                      value: provider.empHisPositionsHeld,
                                      isExpanded: true,
                                      hint: Text("Search Position"),
                                      onChanged: (newValue) {
                                        provider.setEmpHisPositionsHeld(newValue!);
                                      },
                                      items: provider.employmentHistoryPositionList.map((value) {
                                        return DropdownMenuItem<dynamic>(
                                          value: value['name'],
                                          child: Text(value['name']!),
                                        );
                                      }).toList(),
                                      underline: SizedBox(),
                                    ),
                                  ),
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
                                    // Clear focus from all fields before opening date picker
                                    FocusScope.of(context).unfocus();
                                    // Clear focus from all fields before opening date picker
                                    FocusScope.of(context).unfocus();
                                    final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
                                      lastDate: DateTime.now(),
                                    );
                                    if (picked != null) {
                                      // Check if this start date would be valid with existing end date
                                      String tempStartDate = "${picked.toLocal()}".split(' ')[0];
                                      String? dateError = provider.validateDateRange(
                                        tempStartDate,
                                        provider.endDate.text
                                      );

                                      if (dateError != null) {
                                        ShowToast("Error", dateError);
                                        // Don't set the invalid date
                                      } else {
                                        provider.setStartDate(picked);
                                      }
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: customTextField(
                                      context: context,
                                      controller: provider.startDate,
                                      focusNode: provider.startDateFocusNode,
                                      hintText: 'Select Start Date',
                                      textInputType: TextInputType.datetime,
                                      obscureText: false,
                                      voidCallback: (value) {},
                                      fontSize: AppFontSize.fontSize16,
                                      inputFontSize: AppFontSize.fontSize16,
                                      backgroundColor: AppColors.Color_FAFAFA,
                                      // borderColor: AppColors.buttonColor,
                                      textColor: Colors.black,
                                      labelColor: AppColors.Color_9E9E9E,
                                      cursorColor: AppColors.Color_212121,
                                      fillColor: AppColors.Color_FAFAFA,
                                      activeFillColor: AppColors.activeFieldBgColor,
                                      borderColor: AppColors.buttonColor,
                                      onFieldSubmitted: (String ) {  },
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
                                    // Clear focus from all fields before opening date picker
                                    FocusScope.of(context).unfocus();
                                    if(provider.startDate.text.isNotEmpty)
                                      {
                                    final String startDateString = provider.startDate.text;
                                    DateTime firstDate = DateTime(DateTime.now().year-100); // default fallback

                                    if (startDateString.isNotEmpty) {
                                      try {
                                        firstDate = DateTime.parse(startDateString);
                                      } catch (e) {
                                        // handle invalid date format if necessary
                                        print('Invalid date format: $e');
                                      }
                                    }

                                    // Clear focus from all fields before opening date picker
                                    FocusScope.of(context).unfocus();
                                    final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: firstDate,
                                      lastDate: DateTime(DateTime.now().year + 100),
                                    );
                                      if (picked != null) {
                                        // Check if this end date would be valid with existing start date
                                        String tempEndDate = "${picked.toLocal()}"
                                            .split(' ')[0];
                                        String? dateError = provider
                                            .validateDateRange(
                                            provider.startDate.text,
                                            tempEndDate
                                        );

                                        if (dateError != null) {
                                          ShowToast("Error", dateError);
                                          // Don't set the invalid date
                                        } else {
                                          provider.setEndDate(picked);
                                        }
                                      }
                                    }else{
                                      ShowToast("Error", "please select Start Date First");
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: customTextField(
                                      context: context,
                                      controller: provider.endDate,
                                      focusNode: provider.endDateFocusNode,
                                      hintText: 'Select End Date',
                                      textInputType: TextInputType.datetime,
                                      obscureText: false,
                                      voidCallback: (value) {},
                                      fontSize: AppFontSize.fontSize16,
                                      inputFontSize: AppFontSize.fontSize16,
                                      backgroundColor: AppColors.Color_FAFAFA,
                                      // borderColor: AppColors.buttonColor,
                                      textColor: Colors.black,
                                      labelColor: AppColors.Color_9E9E9E,
                                      cursorColor: AppColors.Color_212121,
                                      fillColor: AppColors.Color_FAFAFA,
                                      activeFillColor: AppColors.activeFieldBgColor,
                                      borderColor: AppColors.buttonColor,
                                      onFieldSubmitted: (String ) {  },
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
                                  focusNode: provider.responsibilitiesFocusNode,
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
                                  fillColor: AppColors.Color_FAFAFA,
                                  activeFillColor: AppColors.activeFieldBgColor,
                                  onFieldSubmitted: (String ) {  },
                                ),


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
                                          provider.companyController.clear();
                                          provider.startDate.clear();
                                          provider.endDate.clear();
                                          provider.responsibilitiesController.clear();
                                          provider.setEmpHisPositionsHeld(null);
                                          provider.showAddSection_employmentHistory = false;

                                          provider.setEmploymentHistoryVisibility(false);
                                          provider.employment_Edit_Index=null;
                                          provider.employment_IsEdit=false;
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
                                          voidCallback: () async {
                                            print("click => ${provider.empHisPositionsHeld}");
                                            // Validate fields and add employment history
                                            if (provider.companyController.text.isNotEmpty &&
                                                provider.startDate.text.isNotEmpty &&
                                                provider.endDate.text.isNotEmpty &&
                                                provider.responsibilitiesController.text.isNotEmpty) {

                                              // Validate date range
                                              String? dateError = provider.validateDateRange(
                                                provider.startDate.text,
                                                provider.endDate.text
                                              );
                                              if (dateError != null) {
                                                ShowToast("Error", dateError);
                                                return;
                                              }
                                              if (!provider.employment_IsEdit) {
                                                await provider.addEmploymentHistory(ProfessionalEmploymentHistory(
                                                  companyName: provider.companyController.text,
                                                  position: provider.empHisPositionsHeld,
                                                  startDate: provider.startDate.text,
                                                  endDate: provider.endDate.text,
                                                  responsibilities: provider.responsibilitiesController.text,
                                                ));
                                              } else {
                                                await provider.updateEmploymentHistory(provider.employment_Edit_Index!, ProfessionalEmploymentHistory(
                                                  companyName: provider.companyController.text,
                                                  position: provider.empHisPositionsHeld,
                                                  startDate: provider.startDate.text,
                                                  endDate: provider.endDate.text,
                                                  responsibilities: provider.responsibilitiesController.text,
                                                ));
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
                                              ShowToast("Error", "Please fill in all required fields");
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
                                   ],
                                 ),
                              ],
                            ),
                          ),
                        ) : Container(),

                        // Show existing employment history from API
                        // if (provider.professionalExperienceData != null &&
                        //     provider.professionalExperienceData!.employmentHistory != null &&
                        //     provider.professionalExperienceData!.employmentHistory!.isNotEmpty)
                        //   Container(
                        //     margin: EdgeInsets.symmetric(vertical: 1.h),
                        //     padding: EdgeInsets.all(2.w),
                        //     decoration: BoxDecoration(
                        //       color: Colors.green.shade50,
                        //       borderRadius: BorderRadius.circular(1.h),
                        //       border: Border.all(color: Colors.green.shade200),
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             Icon(Icons.check_circle, color: Colors.green, size: 2.h),
                        //             SizedBox(width: 1.w),
                        //             Text(
                        //               'Existing Employment History',
                        //               style: TextStyle(
                        //                 fontSize: AppFontSize.fontSize14,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.green.shade700,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(height: 1.h),
                        //         ...provider.professionalExperienceData!.employmentHistory!.map((history) =>
                        //           Container(
                        //             margin: EdgeInsets.only(bottom: 1.h),
                        //             padding: EdgeInsets.all(2.w),
                        //             decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               borderRadius: BorderRadius.circular(0.5.h),
                        //               border: Border.all(color: Colors.green.shade200),
                        //             ),
                        //             child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   history.companyName ?? '',
                        //                   style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize16,
                        //                     fontWeight: FontWeight.bold,
                        //                     color: AppColors.Color_212121,
                        //                   ),
                        //                 ),
                        //                 SizedBox(height: 0.5.h),
                        //                 Text(
                        //                   'Position: ${history.position ?? ''}',
                        //                   style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize14,
                        //                     color: AppColors.Color_616161,
                        //                   ),
                        //                 ),
                        //                 Text(
                        //                   'Period: ${history.startDate ?? ''} - ${history.endDate ?? ''}',
                        //                   style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize14,
                        //                     color: AppColors.Color_616161,
                        //                   ),
                        //                 ),
                        //                 Text(
                        //                   'Responsibilities: ${history.responsibilities ?? ''}',
                        //                   style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize14,
                        //                     color: AppColors.Color_616161,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           )
                        //         ).toList(),
                        //       ],
                        //     ),
                        //   ),

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
                              padding: EdgeInsets.only(right: 10.0,top:10),
                              child: GestureDetector(
                                onTap: (){
                                  if(provider.reference_IsEdit) {
                                    provider.setReferenceVisibility(true);
                                    provider.showAddSection_reference = true;
                                  }else if (provider.showAddSection_reference){
                                    provider.setReferenceVisibility(false);
                                    provider.showAddSection_reference = false;
                                  }else{
                                    provider.setReferenceVisibility(true);
                                    provider.showAddSection_reference = true;
                                  }
                                  // Clear form data
                                  provider.referenceVesselController.clear();
                                  provider.referenceIssuedDate.clear();
                                  provider.referenceDocumentController.clear();
                                  provider.referenceIssuedBy = null;

                                  // provider.showAddSection_reference = !provider.showAddSection_reference;
                                  // provider.setReferenceVisibility( provider.showAddSection_reference);
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

                        // Show existing references from API
                        // if (provider.professionalExperienceData != null &&
                        //     provider.professionalExperienceData!.references != null &&
                        //     provider.professionalExperienceData!.references!.isNotEmpty)
                        //   Container(
                        //     margin: EdgeInsets.symmetric(vertical: 1.h),
                        //     padding: EdgeInsets.all(2.w),
                        //     decoration: BoxDecoration(
                        //       color: Colors.green.shade50,
                        //       borderRadius: BorderRadius.circular(1.h),
                        //       border: Border.all(color: Colors.green.shade200),
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             Icon(Icons.check_circle, color: Colors.green, size: 2.h),
                        //             SizedBox(width: 1.w),
                        //             Text(
                        //               'Existing References',
                        //               style: TextStyle(
                        //                 fontSize: AppFontSize.fontSize14,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.green.shade700,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(height: 1.h),
                        //         ...provider.professionalExperienceData!.references!.map((reference) =>
                        //           Container(
                        //             margin: EdgeInsets.only(bottom: 1.h),
                        //             padding: EdgeInsets.all(2.w),
                        //             decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               borderRadius: BorderRadius.circular(0.5.h),
                        //               border: Border.all(color: Colors.green.shade200),
                        //             ),
                        //             child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   reference.vesselOrCompanyName ?? '',
                        //                   style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize16,
                        //                     fontWeight: FontWeight.bold,
                        //                     color: AppColors.Color_212121,
                        //                   ),
                        //                 ),
                        //                 SizedBox(height: 0.5.h),
                        //                 Text(
                        //                   'Issued By: ${reference.issuedBy ?? ''}',
                        //                   style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize14,
                        //                     color: AppColors.Color_616161,
                        //                   ),
                        //                 ),
                        //                 Text(
                        //                   'Issued Date: ${reference.issuingDate ?? ''}',
                        //                   style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize14,
                        //                     color: AppColors.Color_616161,
                        //                   ),
                        //                 ),
                        //                 if (reference.experienceDocumentOriginalName != null &&
                        //                     reference.experienceDocumentOriginalName!.isNotEmpty)
                        //                   Text(
                        //                     'Document: ${reference.experienceDocumentOriginalName}',
                        //                     style: TextStyle(
                        //                       fontSize: AppFontSize.fontSize14,
                        //                       color: AppColors.Color_616161,
                        //                     ),
                        //                   ),
                        //               ],
                        //             ),
                        //           )
                        //         ).toList(),
                        //       ],
                        //     ),
                        //   ),

                        ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.references.length,
                          itemBuilder: (context, index) {
                            Reference referenceDetail = provider.references[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 1.h),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 15.w,
                                    height: 15.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.cardIconBgColour,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/profileActive.png",
                                        height: 6.w,
                                        width: 6.w,
                                        color: AppColors.buttonColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          referenceDetail.vesselOrCompanyName ?? '',
                                          style: TextStyle(
                                            fontSize:
                                            AppFontSize.fontSize20,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.Color_212121,
                                            fontFamily: AppColors
                                                .fontFamilyBold,
                                          ),
                                        ),
                                        SizedBox(height: 0.8.h),
                                        Text(referenceDetail.issuedBy ?? '',
                                          style: TextStyle(
                                            fontSize:
                                            AppFontSize.fontSize14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors
                                                .Color_424242,
                                            fontFamily: AppColors
                                                .fontFamilyMedium,
                                          ),
                                        ),
                                        SizedBox(height: 0.8.h),
                                        Text(
                                          referenceDetail.issuingDate ?? '',
                                          style: TextStyle(
                                            fontSize:
                                            AppFontSize.fontSize14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors
                                                .Color_424242,
                                            fontFamily: AppColors
                                                .fontFamilyMedium,
                                          ),
                                        ),
                                        SizedBox(height: 0.8.h),
                                        Text(
                                          referenceDetail.newReferenceDocument?.path.split('/').last ?? referenceDetail.experienceDocumentOriginalName ?? '',
                                          style: TextStyle(
                                            fontSize:
                                            AppFontSize.fontSize14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors
                                                .Color_424242,
                                            fontFamily: AppColors
                                                .fontFamilyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      provider.referenceVesselController.text = referenceDetail.vesselOrCompanyName ?? '';
                                      provider.referenceIssuedDate.text = referenceDetail.issuingDate ?? '';
                                      provider.setReferenceIssuedBy(referenceDetail.issuedBy ?? '');
                                      provider.referenceDocumentController.text = referenceDetail.experienceDocumentOriginalName ?? '';
                                      provider.setReferenceVisibility(true);
                                      provider.reference_Edit_Index=index;
                                      provider.reference_IsEdit=true;
                                    },
                                    child: Image.asset(
                                      "assets/images/Edit.png",
                                      height: 2.h,
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  GestureDetector(
                                    onTap:(){
                                      if(provider.reference_IsEdit){
                                        showToast("Updating or cancel the current record before continuing.");
                                      }else {
                                        provider.removeReference(index);
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
                        provider.showAddSection_reference ? Container(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: Text(
                                    provider.employment_IsEdit?'Edit Reference':'Add Reference',
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
                                  focusNode: provider.referenceVesselFocusNode,
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
                                  fillColor: AppColors.Color_FAFAFA,
                                  activeFillColor: AppColors.activeFieldBgColor,
                                  onFieldSubmitted: (String ) {  },
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
                                      items: issuedByList.map((value) {
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
                                    // Clear focus from all fields before opening date picker
                                    FocusScope.of(context).unfocus();
                                    // Clear focus from all fields before opening date picker
                                    FocusScope.of(context).unfocus();
                                    final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(DateTime.now().year - 100), // 100 years ago
                                      lastDate: DateTime.now(),
                                    );
                                    if (picked != null) {
                                      provider.setReferenceIssuingDate(picked);
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: customTextField(
                                      context: context,
                                      controller: provider.referenceIssuedDate,
                                      focusNode: provider.referenceIssuedDateFocusNode,
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
                                      fillColor: AppColors.Color_FAFAFA,
                                      activeFillColor: AppColors.activeFieldBgColor,
                                      onFieldSubmitted: (String ) {  },
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
                                  onTap: () async {
                                    await provider.showAttachmentOptions(context);
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
                                                color: AppColors.Color_9E9E9E),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (provider.newReference == null &&
                                    !(provider.reference_IsEdit &&
                                        provider.references[provider.reference_Edit_Index!].hasExistingReferenceDocument) &&
                                    provider.autovalidateMode ==
                                        AutovalidateMode.always)
                                  Padding(
                                    padding:
                                    EdgeInsets.only(top: 1.h, left: 4.w),
                                    child: Text(
                                      "please select Reference",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: AppFontSize.fontSize12,
                                      ),
                                    ),
                                  ),
                                if (provider.newReference == null &&
                                    !(provider.reference_IsEdit &&
                                        provider.reference_Edit_Index != null &&
                                        provider.references[provider.reference_Edit_Index!].hasExistingReferenceDocument) &&
                                    provider.autovalidateMode ==
                                        AutovalidateMode.always)
                                  Padding(
                                    padding:
                                    EdgeInsets.only(top: 1.h, left: 4.w),
                                    child: Text(
                                      "please select Reference",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: AppFontSize.fontSize12,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 3.h),
                                if (provider.newReference != null)
                                  GestureDetector(
                                    onTap: (){
                                      OpenFile_View(provider.newReference!.path,context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 2.h),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade100,
                                        borderRadius: BorderRadius.circular(1.h),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/Paper.png", height: 3.5.h,color: Colors.red,),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  provider.newReference!.path.split('/').last,
                                                  style: TextStyle(
                                                      fontSize: AppFontSize.fontSize16,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.Color_212121,
                                                      fontFamily:
                                                      AppColors.fontFamilyBold),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                FutureBuilder<int>(
                                                  future: provider.newReference!.length(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                                        style: TextStyle(
                                                            fontSize: AppFontSize.fontSize12,
                                                            color: AppColors.Color_616161,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily:
                                                            AppColors.fontFamilyMedium),
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
                                              provider.removeAttachment();
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
                                if (provider.reference_IsEdit && provider.reference_Edit_Index != null && provider.references[provider.reference_Edit_Index!].hasExistingReferenceDocument && provider.newReference == null)
                                  GestureDetector(
                                    onTap: (){
                                      OpenFile_View(provider.references[provider.reference_Edit_Index!].experienceDocumentPath,context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 2.h),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade100,
                                        borderRadius: BorderRadius.circular(1.h),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/Paper.png", height: 3.5.h,color: Colors.red,),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                            child: Text(
                                              provider.references[provider.reference_Edit_Index!].experienceDocumentOriginalName ?? 'Existing Document',
                                              style: TextStyle(
                                                  fontSize: AppFontSize.fontSize16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.Color_212121,
                                                  fontFamily:
                                                  AppColors.fontFamilyBold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              provider.removeAttachment(index: provider.reference_Edit_Index!);
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
                                if (provider.reference_IsEdit && provider.reference_Edit_Index == null && provider.references[provider.reference_Edit_Index!].hasExistingReferenceDocument && provider.newReference == null)
                                  GestureDetector(
                                    onTap: (){
                                      OpenFile_View(provider.references[provider.reference_Edit_Index!].experienceDocumentPath,context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 2.h),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade100,
                                        borderRadius: BorderRadius.circular(1.h),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/Paper.png", height: 3.5.h,color: Colors.red,),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                            child: Text(
                                              provider.references[provider.reference_Edit_Index!].experienceDocumentOriginalName ?? 'Existing Document',
                                              style: TextStyle(
                                                  fontSize: AppFontSize.fontSize16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.Color_212121,
                                                  fontFamily:
                                                  AppColors.fontFamilyBold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              provider.removeAttachment(index: provider.reference_Edit_Index!);
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
                                          provider.referenceVesselController.clear();
                                          provider.referenceIssuedBy = null;
                                          provider.referenceIssuedDate.clear();
                                          provider.referenceDocumentController.clear();
                                          provider.reference_IsEdit=false;
                                          provider.reference_Edit_Index=null;
                                          provider.setReferenceVisibility(false);
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
                                          voidCallback: () async {
                                            if (provider.referenceVesselController.text.isNotEmpty &&
                                                provider.referenceIssuedBy != null &&
                                                provider.referenceIssuedDate.text.isNotEmpty) {
                                              if (!provider.reference_IsEdit) {
                                                await provider.addReference(Reference(
                                                  vesselOrCompanyName: provider.referenceVesselController.text,
                                                  issuedBy: provider.referenceIssuedBy!,
                                                  issuingDate: provider.referenceIssuedDate.text,
                                                  experienceDocumentOriginalName: provider.referenceDocumentController.text.isNotEmpty ? provider.referenceDocumentController.text : null,
                                                ));
                                              } else {
                                                await provider.updateReference(provider.reference_Edit_Index!, Reference(
                                                  vesselOrCompanyName: provider.referenceVesselController.text,
                                                  issuedBy: provider.referenceIssuedBy!,
                                                  issuingDate: provider.referenceIssuedDate.text,
                                                  experienceDocumentOriginalName: provider.referenceDocumentController.text.isNotEmpty ? provider.referenceDocumentController.text : null,
                                                ));
                                              }
                                              provider.referenceVesselController.clear();
                                              provider.referenceIssuedBy = null;
                                              provider.referenceIssuedDate.clear();
                                              provider.referenceDocumentController.clear();
                                              provider.reference_IsEdit=false;
                                              provider.reference_Edit_Index=null;
                                              provider.setReferenceVisibility(false);
                                            } else {
                                              ShowToast("Error", "Please fill in all required fields");
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
                                 ],
                               ),

                              ],
                            ),
                          ),
                        ) : Container(),
                      ],
                    ),
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


