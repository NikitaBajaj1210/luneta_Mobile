import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../Utils/validation.dart';
import '../../../../const/Enums.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/country_input_field.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/personal_information_provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalInformationProvider>(
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
                  // Validate fields
                  if (provider.addressController.text.isNotEmpty &&
                      provider.phoneNumber.phoneNumber != null &&
                      provider.emailController.text.isNotEmpty) {

                    // Save the data in provider or update the profile here
                    // Add validation or API call as needed

                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all required fields'),
                        duration: Duration(seconds: 2),
                      ),
                    );
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button and Title
                    backButtonWithTitle(
                      title: "Personal Information",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 2.h),
                    // Profile Image Picker
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 8.h,
                            backgroundColor: AppColors.introBackgroundColor,
                            backgroundImage: provider.profileImage == null
                                ? AssetImage("assets/images/dummyProfileImg.png")
                                : FileImage(provider.profileImage!),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: (){
                                  showChooseFile(provider);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 2.h),
                                  child: Image.asset("assets/images/EditIcon.png",height: 3.h,),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Name (First and Last)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'First Name',
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
                      controller: provider.firstNameController,
                      hintText: 'First Name',
                      textInputType: TextInputType.name,
                      obscureText: false,
                      voidCallback: validateName,
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: provider.firstNameFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.firstNameFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(provider.lastNameFocusNode);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Last Name',
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
                      controller: provider.lastNameController,
                      hintText: 'Last Name',
                      textInputType: TextInputType.name,
                      obscureText: false,
                      voidCallback: validateName,
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: provider.lastNameFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.lastNameFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(provider.dobFocusNode);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Date of Birth',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    // Date of Birth
                    customTextField(
                      context: context,
                      controller: provider.dobController,
                      hintText: 'Date of Birth',
                      textInputType: TextInputType.datetime,
                      obscureText: false,
                      voidCallback: validateName,
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: provider.dobFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.dobFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(provider.countryOfBirthFocusNode);
                      },
                    ),

                    // Country of Birth

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Country of Birth',
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
                          color: AppColors.transparent, // Set the border color here
                          width: 1, // You can adjust the width of the border
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: DropdownButton<dynamic>(
                          focusNode: provider.countryOfBirthFocusNode,
                          value: provider.countryOfBirthController.text.isEmpty ? null : provider.countryOfBirthController.text,
                          onChanged: (dynamic newValue) {
                            setState(() {
                              provider.countryOfBirthController.text = newValue!;
                            });
                          },
                          items: nationalityList.map((value) {
                            return DropdownMenuItem<dynamic>(
                                value: value["key"],
                                child: Text(
                                  // value.Type!,
                                  value["value"].toString(),
                                  overflow: TextOverflow.ellipsis,
                                ));
                          }).toList(),
                          hint: Text('Country Of Birth'),
                          isExpanded: true, // Make the dropdown take up the full width
                          underline: SizedBox(), // Remove the default underline
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Religion',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),

                    // Religion
                    customTextField(
                      context: context,
                      controller: provider.religionController,
                      hintText: 'Religion',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: validateName,
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: provider.religionFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.religionFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(provider.sexFocusNode);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    // Sex (Dropdown)
                    Container(
                      width: 90.w,
                      padding: EdgeInsets.symmetric(horizontal: 0.1.w),
                      decoration: BoxDecoration(
                        color: AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                        border: Border.all(
                          color: AppColors.transparent, // Set the border color here
                          width: 1, // You can adjust the width of the border
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: DropdownButton<dynamic>(
                          value: provider.sex,
                          onChanged: (dynamic newValue) {
                            setState(() {
                              provider.sex = newValue!;
                            });
                          },
                          isExpanded: true,
                          underline: SizedBox(), // Remove the default underline
                          items: sexList.map((value) {
                            return DropdownMenuItem<dynamic>(
                                value: value["key"],
                                child: Text(
                                  // value.Type!,
                                  value["value"].toString(),
                                  overflow: TextOverflow.ellipsis,
                                ));
                          }).toList(),
                        ),
                      ),
                    ),

                    // Nationality (Dropdown for Country)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Nationality',
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
                          color: AppColors.transparent, // Set the border color here
                          width: 1, // You can adjust the width of the border
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: DropdownButton<dynamic>(
                          value: provider.nationalityController.text.isEmpty ? null : provider.nationalityController.text,
                          onChanged: (dynamic newValue) {
                            setState(() {
                              provider.nationalityController.text = newValue!;
                            });
                          },
                          items: nationalityList.map((value) {
                            return DropdownMenuItem<dynamic>(
                                value: value["key"],
                                child: Text(
                                  // value.Type!,
                                  value["value"].toString(),
                                  overflow: TextOverflow.ellipsis,
                                ));
                          }).toList(),
                          isExpanded: true,
                          underline: SizedBox(), // Remove the default underline
                          hint: Text('Select Nationality'),
                        ),
                      ),
                    ),

                    // Contact Information
                    // Email, Phone Number, Address, Nearest Airport (Phone number inputs)
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Contact Information',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize18,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Email Address',
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
                      controller: provider.emailController,
                      hintText: 'Email Address',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: validateEmail,
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: provider.emailFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.emailFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(provider.phoneFocusNode);
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    countryPhoneInput(
                      phoneNumber: provider.phoneNumber,
                      controller: provider.phoneController,
                      onPhoneChanged: (PhoneNumber newNumber) {
                        setState(() {
                          provider.phoneNumber = newNumber; // Update provider with new number
                        });
                      }, onFieldSubmitted: (String ) {  },
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Direct Line Phone',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    countryPhoneInput(
                      phoneNumber: provider.directPhoneNumber,
                      controller: provider.directPhoneController,
                      onPhoneChanged: (PhoneNumber newNumber) {
                        setState(() {
                          provider.directPhoneNumber = newNumber; // Update provider with new number
                        });
                      }, onFieldSubmitted: (String ) {  },
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Address',
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
                      controller: provider.addressController,
                      hintText: 'Address',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value){ return;},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: provider.addressFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: provider.addressFocusNode.hasFocus
                          ? AppColors.activeFieldBgColor
                          : AppColors.Color_FAFAFA,
                      onFieldSubmitted: (value) {
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Nearest Airport',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    // Marital Status and Children Number (Dropdown)
                    Container(
                      width: 90.w,
                      padding: EdgeInsets.symmetric(horizontal: 0.1.w),
                      decoration: BoxDecoration(
                        color: AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                        border: Border.all(
                          color: AppColors.transparent, // Set the border color here
                          width: 1, // You can adjust the width of the border
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: DropdownButton<dynamic>(
                          value: provider.nearestAirport,
                          isExpanded: true,
                          underline: SizedBox(),
                          hint: Text('Select Airport'),
                          onChanged: (dynamic newValue) {
                            setState(() {
                              provider.nearestAirport = newValue!;
                            });
                          },
                          items: nearestAirportList.map((value) {
                            return DropdownMenuItem<dynamic>(
                                value: value["key"],
                                child: Text(
                                  // value.Type!,
                                  value["value"].toString(),
                                  overflow: TextOverflow.ellipsis,
                                ));
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Online Communication',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize18,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap: (){
                                provider.setcommunicationVisibility(!provider.showAddSection_communication);
                                provider.platform=null;
                                provider.NumberOrIDController.clear();
                                provider.communication_Edit_Index=null;
                                provider.communication_IsEdit=false;
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
                    ),

                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.communicationList.length,
                        itemBuilder: (context, index) {
                          return  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              onlineCommunicationLabelView("assets/images/emailIcon.png",provider.communicationList[index].numberOrId,provider,index,label: provider.communicationList[index].platform)
                            ],);
                        }),
                    provider.showAddSection_communication?Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Platform',
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
                              color: AppColors.transparent, // Set the border color here
                              width: 1, // You can adjust the width of the border
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: DropdownButton<dynamic>(
                              value: provider.platform,
                              isExpanded: true,
                              underline: SizedBox(),
                              hint: Text('Select Platform'),
                              onChanged: (dynamic newValue) {
                                setState(() {
                                  provider.platform = newValue!;
                                });
                              },
                              items: platformList.map((value) {
                                return DropdownMenuItem<dynamic>(
                                    value: value["key"],
                                    child: Text(
                                      // value.Type!,
                                      value["value"].toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ));
                              }).toList(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Number or ID',
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
                          controller: provider.NumberOrIDController,
                          hintText: 'Number or ID',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          voidCallback: (value){ return;},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: provider.NumberOrIdFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.NumberOrIdFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA,
                          onFieldSubmitted: (value) {
                          },
                        ),

                        Align(alignment: Alignment.centerRight,
                          child: Container(
                            // height: 9.h,
                            // width: 30.w,
                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                            child: customButton(
                              voidCallback: () {
                                // Validate fields
                                if (provider.NumberOrIDController.text.isNotEmpty &&
                                    provider.platform != null) {
                                  if(!provider.communication_IsEdit){
                                  provider.addCommunicationChannel(PlatformEntry(platform: provider.platform!, numberOrId: provider.NumberOrIDController.text));
                                  }else{
                                    provider.updateCommunicationChannel(provider.communication_Edit_Index!, PlatformEntry(platform: provider.platform!, numberOrId: provider.NumberOrIDController.text));
                                  }
                                  provider.platform=null;
                                  provider.NumberOrIDController.clear();
                                  provider.communication_Edit_Index=null;
                                  provider.communication_IsEdit=false;
                                  provider.setcommunicationVisibility(!provider.showAddSection_communication);
                                }
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please fill platform and number or Id'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              buttonText: provider.communication_IsEdit?"Update":"Add",
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
                    ):Container(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Marital Status',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                    ),
                    // Marital Status and Children Number (Dropdown)
                    Container(
                      width: 90.w,
                      padding: EdgeInsets.symmetric(horizontal: 0.1.w),
                      decoration: BoxDecoration(
                        color: AppColors.Color_FAFAFA,
                        borderRadius: BorderRadius.circular(2.h),
                        border: Border.all(
                          color: AppColors.transparent, // Set the border color here
                          width: 1, // You can adjust the width of the border
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: DropdownButton<dynamic>(
                          value: provider.maritalStatus,
                          isExpanded: true,
                          underline: SizedBox(),
                          onChanged: (dynamic newValue) {
                            setState(() {
                              provider.maritalStatus = newValue!;
                            });
                          },
                          items: maritalStatusList.map((value) {
                            return DropdownMenuItem<dynamic>(
                                value: value["key"],
                                child: Text(
                                  // value.Type!,
                                  value["value"].toString(),
                                  overflow: TextOverflow.ellipsis,
                                ));
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text(
                        'Number of Children',
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
                          color: AppColors.transparent, // Set the border color here
                          width: 1, // You can adjust the width of the border
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: DropdownButton<int>(
                          value: provider.numberOfChildren,
                          isExpanded: true,
                          underline: SizedBox(),
                          onChanged: (int? newValue) {
                            setState(() {
                              provider.numberOfChildren = newValue!;
                            });
                          },
                          items: <int>[0, 1, 2, 3, 4, 5]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  onlineCommunicationLabelView(String IconPath, String LabelValue,PersonalInformationProvider provider,int index,{String? label}){
    return   Padding(
      padding:  EdgeInsets.only(top:1.5.h,right: 1.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset(IconPath,
          //   height: 2.h,
          // ),
          // SizedBox(width: 3.w),
          label!=null?Text("  "+label,
            style: TextStyle(
                fontSize: AppFontSize.fontSize16,
                fontWeight: FontWeight.bold,
                color: AppColors.Color_212121,
                fontFamily:
                AppColors.fontFamilyMedium),
          ):Container(),
          Expanded(
            child: Text(": "+LabelValue,
              maxLines: 2,
              style: TextStyle(
                  fontSize: AppFontSize.fontSize16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.Color_212121,
                  fontFamily:
                  AppColors.fontFamilyMedium),
            ),
          ),
          GestureDetector(
            onTap: (){
              provider.communication_Edit_Index=index;
              provider.communication_IsEdit=true;
              provider.platform=label;
              provider.NumberOrIDController.text=LabelValue;
              provider.setcommunicationVisibility(true);
            },
            child: Image.asset(
              "assets/images/Edit.png",
              height: 2.5.h,
              color: AppColors.buttonColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: GestureDetector(
              onTap: (){
                provider.removeCommunicationChannel(index);
              },
              child: Image.asset(
                "assets/images/Delete.png",
                height: 2.5.h,
                color: AppColors.buttonColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  showChooseFile(PersonalInformationProvider profile) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      // isDismissible: false,
      // barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 20.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 2.h,
                left: 5.w,
                right: 5.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile photo",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize:  AppFontSize.fontSize16,
                          color: Colors.black),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close,
                            size: 3.h, color: Colors.black)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                            profile.pickProfileImage(ImageSource.camera);
                          },
                          child: Image.asset(
                            "assets/images/camera_icon.png",
                            width: 10.w,
                          )),
                      SizedBox(
                        width: 9.w,
                      ),
                      GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                            profile.pickProfileImage(ImageSource.gallery);
                          },
                          child: Image.asset(
                            "assets/images/gallery_icon.png",
                            width: 10.w,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


}
