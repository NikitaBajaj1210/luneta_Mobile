import 'dart:async';

import 'package:flutter/material.dart';
import 'package:luneta/const/font_size.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../const/color.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';
import '../../provider/authentication-provider/otp_screen_provider.dart';

class OtpScreen extends StatefulWidget {
  final String? mobileNumber;
  final String? email;
  final bool isFromLogin;
  
  const OtpScreen({
    super.key, 
    this.mobileNumber,
    this.email,
    this.isFromLogin = false,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _remainingSeconds = 60; // Timer duration
  Timer? _timer;

  String _enteredPin = ""; // To track entered OTP

  @override
  void initState() {
    super.initState();
    // Only start countdown if not coming from login screen
    if (!widget.isFromLogin) {
      _startCountdown();
    }
  }

  @override
  void dispose() {
    if (!widget.isFromLogin && _timer != null) {
      _timer!.cancel(); // Cancel the timer when the widget is disposed
    }
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  bool get _isButtonEnabled => _enteredPin.length == 6;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtpScreenProvider(),
      child: Consumer<OtpScreenProvider>(
        builder: (context, countryProvider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.introBackgroundColor,
              bottomNavigationBar: Container(
                padding: EdgeInsets.all(2.h),
                height: 11.h,
                child: customButton(
                  voidCallback: _isButtonEnabled
                      ? () {
                    // Call verify OTP API
                    countryProvider.verifyOtpApi(
                      context, 
                      widget.email ?? '', 
                      _enteredPin, 
                      true
                    );
                    debugPrint("OTP Verified: $_enteredPin");
                  }
                      : () {
                    debugPrint("Button is disabled");
                  }, // Disable button when not filled
                  buttonText: "Verify",
                  width: 90.w,
                  height: 6.h,
                  color: _isButtonEnabled
                      ?
                  AppColors.buttonColor
                      :
                  AppColors.Color_BDBDBD, // Disable if not filled
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize16,
                  showShadow: _isButtonEnabled,
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w,),
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    // Keep the back button at the top
                    backButtonWithTitle(
                      title: "OTP Code Verification",
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // Center the rest of the UI
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.isFromLogin 
                                    ? "Code has been sent to your email ${widget.email}"
                                    : "Code has been sent to ${widget.mobileNumber}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.Color_212121,
                                  fontFamily: AppColors.fontFamily,
                                ),
                              ),
                              SizedBox(height: 5.h),
                            PinCodeTextField(
                            key: ValueKey( 'otp_6'), // Force rebuild when length changes
                            textStyle: TextStyle(
                              fontSize: AppFontSize.fontSize20,
                              color: AppColors.Color_212121,
                              fontFamily: AppColors.fontFamily,
                              fontWeight: FontWeight.w700,
                            ),
                            appContext: context,
                            keyboardType: TextInputType.number,
                            length: widget.isFromLogin ? 6 : 6,
                            obscureText: true,
                            cursorColor: AppColors.Color_607D8B,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(1.h), // Smooth curve
                              fieldHeight: widget.isFromLogin ? 6.h :  6.h,
                              fieldWidth: widget.isFromLogin ? 6.h :  6.h, // Smaller width for 6 digits
                              activeFillColor: AppColors.activeFieldBgColor,
                              inactiveFillColor: AppColors.Color_FAFAFA,
                              selectedFillColor: AppColors.activeFieldBgColor,
                              activeColor: AppColors.buttonColor,
                              inactiveColor: AppColors.Color_BDBDBD,
                              selectedColor: AppColors.buttonColor,
                            ),
                            enableActiveFill: true, // Enable background color change
                            onChanged: (pin) {
                              setState(() {
                                _enteredPin = pin; // Update the entered PIN
                              });
                              debugPrint('PIN Changed: $pin');
                            },
                            onCompleted: (pin) {
                              setState(() {
                                _enteredPin = pin; // Update the entered PIN
                              });
                              debugPrint('PIN Completed: $pin');
                            },
                            beforeTextPaste: (text) {

                              debugPrint('Text pasted: $text');
                              return true;
                            },
                          ),

                              SizedBox(height: 2.h),
                              if (!widget.isFromLogin && _timer != null) // Only show timer if not coming from login
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Resend code in ',
                                    style: TextStyle(
                                      fontSize: AppFontSize.fontSize16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.Color_212121, // Replace with your desired color
                                      fontFamily: AppColors.fontFamily,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '$_remainingSeconds s',
                                        style: TextStyle(
                                          fontSize: AppFontSize.fontSize16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.buttonColor, // Timer color
                                          fontFamily: AppColors.fontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              // if (!widget.isFromLogin) // Show resend button when coming from login
                              //   GestureDetector(
                              //     onTap: () {
                              //       // TODO: Implement resend OTP functionality
                              //       debugPrint("Resend OTP tapped");
                              //     },
                              //     child: Text(
                              //       "Resend Code",
                              //       style: TextStyle(
                              //         fontSize: AppFontSize.fontSize16,
                              //         fontWeight: FontWeight.w600,
                              //         color: AppColors.buttonColor,
                              //         fontFamily: AppColors.fontFamilySemiBold,
                              //       ),
                              //     ),
                              //   ),

                            ],
                          ),
                        ),
                      ),
                    ),
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
