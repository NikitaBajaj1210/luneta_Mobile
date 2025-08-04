
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';
import '../../provider/account-provider/create_pin_provider.dart';
import '../../provider/bottom_menu_provider/bottom_menu_provider.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  bool _isFromForgotPassword = false;

  @override
  void initState() {
    super.initState();
    // Check if coming from forgot password flow
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          _isFromForgotPassword = args['isFromForgotPassword'] as bool? ?? false;
        });
        print("Create Pin - From Forgot Password: $_isFromForgotPassword");
      }
    });
  }

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
                      "assets/images/CongratsImg.png",
                      height: 20.h,
                      width: 80.w,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      _isFromForgotPassword ? "Password Reset Successful!" : "Congratulations!",
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
                        _isFromForgotPassword 
                            ? "Your password has been reset successfully. You will be redirected to the Login page in a few seconds."
                            : "Your account is ready to use. You will be redirected to the Home page in a few seconds.",
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
      
      if (_isFromForgotPassword) {
        // Navigate back to login screen for forgot password flow
        Navigator.of(context).pushNamedAndRemoveUntil(
          login,
          (route) => false, // Remove all previous routes
        );
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<BottomMenuProvider>(
              context,
              listen: false).updateSelectedIndex(0);
        });
        // Navigate to home screen for normal flow
        Navigator.of(context).pushNamed(bottomMenu);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreatePinProvider(),
      child: Consumer<CreatePinProvider>(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              bottomNavigationBar: Container(
                padding: EdgeInsets.all(2.h),
                height: 11.h,
                child: customButton(
                  voidCallback: model.enteredPin.length < 4
                      ? (){} // Disable button when PIN is empty
                      : () {
                    showCustomDialogWithLoader(context);
                  },
                    buttonText: "Continue",
                    width: 90.w,
                    height: 6.h,
                  color: model.enteredPin.length < 4
                      ? AppColors.Color_BDBDBD // Disabled color
                      : AppColors.buttonColor, // Active color
                    buttonTextColor: AppColors.buttonTextWhiteColor,
                    shadowColor: AppColors.buttonBorderColor,
                    fontSize: AppFontSize.fontSize16,
                    showShadow: model.enteredPin.length < 4
                        ? false // Disabled color
                        : true,
                  ),
              ),
              body: Container(
                color: AppColors.Color_FFFFFF,
                padding: EdgeInsets.symmetric(horizontal: 4.w,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.h),
                    backButtonWithTitle(
                      title: "",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Create New PIN",
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize32,
                        fontWeight:FontWeight.w700,
                        fontFamily: AppColors.fontFamilyBold,
                        color: AppColors.Color_212121,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 1.w),
                      alignment: Alignment.center,
                      child: Text(
                        "Add a PIN number to make your account more secure.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize18,
                          fontWeight: FontWeight.w400,
                          color: AppColors.Color_212121,
                          fontFamily: AppColors.fontFamilyRegular,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      width: 85.w,
                      child: PinCodeTextField(
                        textStyle: TextStyle(
                          fontSize: AppFontSize.fontSize20,
                          color: AppColors.Color_212121,
                          fontFamily: AppColors.fontFamily,
                          fontWeight: FontWeight.w700,
                        ),
                        appContext: context,
                        keyboardType: TextInputType.number,
                        length: 4,
                        cursorColor: Colors.transparent,
                        obscureText: true,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(2.5.h), // Smooth curve
                          fieldHeight: 8.h,
                          fieldWidth: 9.h,
                          activeFillColor: AppColors.activeFieldBgColor,
                          inactiveFillColor: AppColors.Color_FAFAFA,
                          selectedFillColor: AppColors.activeFieldBgColor,
                          activeColor: AppColors.buttonColor,
                          inactiveColor: AppColors.Color_BDBDBD,
                          selectedColor: AppColors.buttonColor,
                        ),
                        enableActiveFill: true, // Enable background color change
                        onChanged: (pin) {
                          model.setEnteredPin(pin);
                        },
                        onCompleted: (pin) {
                          model.setEnteredPin(pin);
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),
                    ),
            
                    SizedBox(height: 5.h),
            
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
