import 'package:flutter/material.dart';
import 'package:luneta/const/color.dart';
import 'package:luneta/const/font_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget customTextField2({
  required TextEditingController controller,
  required String? Function(String? value)? voidCallback,
  String? icon,
  Color? iconColour,
  Function()? callback,
  bool obscureText = false,
  bool isEditable = true,
  TextInputAction? textInputAction,
  Function()? suffixCallback,
  // String? labelText,
  required String hintText,
  TextInputType? textInputType,
  String? Function(String? value)? onFieldSubmittedEvent,
  int? maxLength,
  double? fontSize,
  double? inputFontSize,
  double? iconSize,
  Color? cursorColor,
  Color? textColor,
  Color? labelColor,
  Color? borderColor,
  Color? errorColor,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 8.0),
  Key? key,
  FocusNode? focusNode,
  Color? backgroundColor, // Added backgroundColor parameter
  bool hasBorder = true, // Added hasBorder parameter with default true
  String? FontFamily,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Text(
      //   labelText??'',
      //   style: TextStyle(
      //     fontSize: AppFontSize.fontSize15,
      //     color: labelColor,
      //     fontWeight: FontWeight.w700,
      //     fontFamily: AppColors.fontFamilyMedium,
      //   ),
      // ),
      // SizedBox(height: 1.h),
      TextFormField(
        key: key,
        focusNode: focusNode,
        controller: controller,
        enabled: isEditable,
        cursorColor: cursorColor ?? AppColors.Color_212121,
        textInputAction: textInputAction,
        obscureText: obscureText,
        keyboardType: textInputType,
        onFieldSubmitted: onFieldSubmittedEvent,
        maxLength: maxLength,
        style: TextStyle(
          fontSize: inputFontSize,
          color: textColor,
          fontWeight: FontWeight.w400,
          fontFamily: AppColors.fontFamilyMedium,
        ),

        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: labelColor ?? AppColors.Color_9E9E9E,
            fontSize: AppFontSize.fontSize16,
            fontWeight: FontWeight.w400,
            fontFamily:FontFamily?? AppColors.fontFamilyRegular,
          ),
          counterText: '',
          isDense: true,
          filled: backgroundColor != null, // Enable fill if backgroundColor is provided
          fillColor: backgroundColor, // Use backgroundColor as fillColor
          suffixIcon: icon != null
              ? GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Image.asset(
                icon,
                height: iconSize,
                width: iconSize,
                color: iconColour ?? AppColors.Color_9E9E9E,
              ),
            ),
            onTap: suffixCallback,
          )
              : null,
          suffixIconConstraints: BoxConstraints.loose(const Size.square(30)),
          contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          errorMaxLines: 2,
          errorStyle: TextStyle(
            color: AppColors.errorRedColor,
            fontSize: AppFontSize.fontSize12,
            fontWeight: FontWeight.w400,
            fontFamily: AppColors.fontFamilySemiBold,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hasBorder ? (borderColor ?? AppColors.Color_212121) : Colors.transparent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(1.h),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: hasBorder ? (borderColor ?? AppColors.Color_212121) : Colors.transparent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(1.h),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hasBorder ? (borderColor ?? AppColors.Color_212121) : Colors.transparent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(1.h),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hasBorder ? (errorColor ?? AppColors.errorRedColor) : Colors.transparent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(1.h),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hasBorder ? (errorColor ?? AppColors.errorRedColor) : Colors.transparent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(1.h),
          ),
        ),
        validator: voidCallback,
      ),
    ],
  );
}