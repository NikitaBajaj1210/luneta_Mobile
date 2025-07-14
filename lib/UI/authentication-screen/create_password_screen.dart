import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:luneta/provider/authentication-provider/create_password_provider.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Utils/validation.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';
import '../../custom-component/customTextField.dart';
class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {

  void showCustomDialogWithLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [

              Container(
                width: 100.w,
                height: 55.h,
                decoration: BoxDecoration(
                  color: AppColors.introBackgroundColor,
                  borderRadius: BorderRadius.circular(8.h),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/verifyPopBg.png",
                      height: 20.h,
                      width: 80.w,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "Congratulations!",
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize20,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppColors.fontFamilyBold,
                        color: AppColors.buttonColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        "Your account is ready to use. You will be redirected to Home in a few seconds",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize16,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppColors.fontFamilyRegular,
                          color: AppColors.Color_212121,
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
              Positioned(
                bottom: 3.h,
                child: LoadingAnimationWidget.hexagonDots(
                  color: AppColors.buttonColor,
                  size: 4.h,
                ),
              ),
            ],
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop(); // Close the dialog
      Navigator.of(context).pushNamed(bottomMenu); // Redirect to the Home page
    });
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<CreatePasswordProvider>(context, listen: false);
      provider.autoValidateMode = AutovalidateMode.disabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreatePasswordProvider(),
      child: Consumer<CreatePasswordProvider>(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              bottomNavigationBar: Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: AppColors.bottomNavBorderColor,
                  ),
                ),
                child: customButton(
                  voidCallback:(){
                    model.autoValidateMode = AutovalidateMode.always;
                    if (model.formKey.currentState!.validate()) {
                      showCustomDialogWithLoader(context);
                      model.autoValidateMode = AutovalidateMode.disabled;
                    }
                  },
                  buttonText: "Continue",
                  width: 90.w,
                  height: 4.h,
                  color: model.formKey.currentState?.validate() ?? false
                      ? AppColors.buttonColor
                      : AppColors.Color_BDBDBD,
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: model.formKey.currentState?.validate() ?? false
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w,),
                  child: Form(
                    key: model.formKey,
                    autovalidateMode: model.autoValidateMode,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      backButtonWithTitle(
                        title: "Create New Password",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 5.h),
                      Image.asset(
                        "assets/images/CreatePasswordBg.png", // Update the path to your logo
                        height: 30.h, // Adjust logo size
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Create Your New Password",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize18,
                          color: AppColors.Color_212121,
                          fontFamily: AppColors.fontFamilyMedium,
                          fontWeight: FontWeight.w500
                      ),
                      ),
                      SizedBox(height: 3.h),
                      customTextField(
                        context: context,
                        focusNode: model.passwordFocusNode,
                        controller: model.passwordController,
                        hintText: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        obscureText: model.obscurePassword,
                        voidCallback: validateSignupPassword,
                        fillColor: model.passwordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onFieldSubmitted: (value) {
                          // Handle password field submitted if needed
                        },
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        iconSize: AppFontSize.fontSize20,
                        backgroundColor: model.passwordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: AppColors.Color_212121,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.buttonColor,
                        prefixIcon: Image.asset(
                          "assets/images/Lock.png",
                          width: 2.h,
                          height: 2.h,
                          color: model.getFieldIconColor(
                              model.passwordFocusNode,
                              model.passwordController),
                        ),
                        onPrefixIconPressed: () {
                          // Handle prefix icon press if needed
                        },
                        suffixIcon: Icon(
                          model.obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: model.passwordFocusNode.hasFocus
                              ? AppColors.buttonColor
                              : (model.passwordController.text.isNotEmpty
                              ? AppColors.Color_212121
                              : AppColors.Color_9E9E9E),
                        ),
                        onSuffixIconPressed: () {
                          model.togglePasswordVisibility();
                        },
                      ),
            
                      SizedBox(height: 2.h),
                      customTextField(
                        context: context,
                        focusNode: model.confirmPasswordFocusNode,
                        controller: model.confirmPasswordController,
                        hintText: 'Confirm Password',
                        textInputType: TextInputType.visiblePassword,
                        obscureText: model.obscureConfirmPassword,
                        voidCallback :(value)=>validateConfirmPassword(value, model.passwordController.text),
                        fillColor: model.confirmPasswordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        onFieldSubmitted: (value) {
                          // Handle confirm password field submitted if needed
                        },
                        fontSize: AppFontSize.fontSize16,
                        inputFontSize: AppFontSize.fontSize16,
                        iconSize: AppFontSize.fontSize20,
                        backgroundColor: model.confirmPasswordFocusNode.hasFocus
                            ? AppColors.activeFieldBgColor
                            : AppColors.Color_FAFAFA,
                        borderColor: AppColors.buttonColor,
                        textColor: AppColors.Color_212121,
                        labelColor: AppColors.Color_9E9E9E,
                        cursorColor: AppColors.buttonColor,
                        prefixIcon: Image.asset(
                          "assets/images/Lock.png",
                          width: 2.h,
                          height: 2.h,
                          color: model.confirmPasswordFocusNode.hasFocus
                              ? AppColors.buttonColor
                              : (model.confirmPasswordController.text.isNotEmpty
                              ? AppColors.Color_212121
                              : AppColors.Color_9E9E9E),
                        ),
                        onPrefixIconPressed: () {
                          // Handle prefix icon press if needed
                        },
                        suffixIcon: Icon(
                          model.obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          color: model.confirmPasswordFocusNode.hasFocus
                              ? AppColors.buttonColor
                              : (model.confirmPasswordController.text.isNotEmpty
                              ? AppColors.Color_212121
                              : AppColors.Color_9E9E9E),
                        ),
                        onSuffixIconPressed: () {
                          model.toggleConfirmPasswordVisibility();
                        },
                      ),
            
            
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
