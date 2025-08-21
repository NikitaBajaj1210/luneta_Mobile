import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../Utils/validation.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/back_button_with_title.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/edit_profile_provider.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileEditProvider(),
      child: Consumer<ProfileEditProvider>(
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
                    // Print all field data
                    print('First Name: ${provider.firstNameController.text}');
                    print('Middle Name: ${provider.middleNameController.text}');
                    print('Last Name: ${provider.lastNameController.text}');
                    print('Profile Image: ${provider.profileImage?.path ?? "No image selected"}');
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
                        title: "Profile",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 3.h),
                  
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
                                    provider.pickProfileImage();
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
                      Container(
                        margin: EdgeInsets.only(top: 2.5.h, bottom: 1.h),
                        height: 0.01.h,
                        color: AppColors.Color_EEEEEE,
                        width: 100.w,
                      ),
                      // First Name Input
                      SizedBox(height: 2.h),
                      Text(
                        "First Name",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      customTextField(
                        context: context,
                        focusNode: provider.firstNameFocusNode,
                        controller: provider.firstNameController,
                        hintText: 'First Name',
                        textInputType: TextInputType.name,
                        obscureText: false,
                        voidCallback: validateName,
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        backgroundColor: AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: Colors.black,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.Color_212121,
                        fillColor: AppColors.Color_FAFAFA,
                        activeFillColor: AppColors.activeFieldBgColor,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(provider.firstNameFocusNode);
                        },
                      ),
                      SizedBox(height: 2.h),
                  
                      Text(
                        "Middle Name",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      customTextField(
                        context: context,
                        focusNode: provider.middleNameFocusNode,
                        controller: provider.middleNameController,
                        hintText: 'Middle Name',
                        textInputType: TextInputType.name,
                        obscureText: false,
                        voidCallback: validateName,
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        backgroundColor: AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: Colors.black,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.Color_212121,
                        fillColor: AppColors.Color_FAFAFA,
                        activeFillColor: AppColors.activeFieldBgColor,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(provider.middleNameFocusNode);
                        },
                      ),
                      SizedBox(height: 2.h),
                  
                      Text(
                        "Last Name",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppColors.fontFamilyMedium,
                          color: AppColors.Color_424242,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      customTextField(
                        context: context,
                        focusNode: provider.lastNameFocusNode,
                        controller: provider.lastNameController,
                        hintText: 'Last Name',
                        textInputType: TextInputType.name,
                        obscureText: false,
                        voidCallback: validateName,
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        backgroundColor: AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: Colors.black,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.Color_212121,
                        fillColor: AppColors.Color_FAFAFA,
                        activeFillColor: AppColors.activeFieldBgColor,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(provider.lastNameFocusNode);
                        },
                      ),
                      SizedBox(height: 2.h),
                  
                      // Current Position Dropdown
                      Text("Current Position",
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppColors.fontFamilyMedium,
                            color: AppColors.Color_424242,)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColors.Color_FAFAFA,
                          borderRadius: BorderRadius.circular(2.h),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: Image.asset("assets/images/dropdownIcon.png",height: 2.5.h,),
                            value: provider.currentPosition,
                            items: provider.positions.map((position) {
                              return DropdownMenuItem<String>(
                                value: position,
                                child: Text(position,
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize16)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.setCurrentPosition(value);
                              }
                            },
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
      ),
    );
  }
}
