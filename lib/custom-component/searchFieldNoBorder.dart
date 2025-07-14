import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luneta/const/font_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../const/color.dart';

Widget searchTextField({
  required TextEditingController controller,
  required String? Function(String?)? voidCallback,
  TextInputAction? textInputAction,
  required String hintText,
  int? maxLength,
  bool? isEditable,
  required TextInputType textInputType,
  List<TextInputFormatter>? inputFormatter,
  Function(String)? onChange,
  Color? backgroundColor, // New parameter for background color
  double? width, // New parameter for width
  Widget? suffixIcon, // New parameter for suffix icon
  VoidCallback? onSuffixIconPressed, // New parameter for suffix icon onPress callback
  bool obscureText = false, // For password fields
  double? fontSize, // Font size for the text
  double? inputFontSize, // Font size for the input
  double? iconSize, // Icon size
  Color? borderColor, // Border color
  Color? textColor, // Text color
  Color? labelColor, // Label color
  Color? cursorColor, // Cursor color
  Widget? prefixIcon, // New parameter for prefix icon
  VoidCallback? onPrefixIconPressed, // New parameter for prefix icon onPress callback
  FocusNode? focusNode, // New parameter for focus node
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(0.8.h),
    ),
    child: TextFormField(
      controller: controller,
      enabled: isEditable ?? true,
      cursorColor: cursorColor ?? AppColors.buttonColor,
      textInputAction: textInputAction,
      maxLength: maxLength,
      validator: voidCallback,
      keyboardType: textInputType,
      inputFormatters: inputFormatter,
      onChanged: onChange,
      obscureText: obscureText,
      focusNode: focusNode, // Pass the focus node here
      style: TextStyle(
        fontSize: inputFontSize ?? AppFontSize.fontSize16,
        color: textColor ?? AppColors.buttonColor,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor ?? AppColors.Color_FFFFFF,
        counterText: '',
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 4.w),
        hintText: hintText,
        errorStyle: TextStyle(
          color: AppColors.buttonColor,
          fontSize: AppFontSize.fontSize16,
        ),
        hintStyle: TextStyle(
          color: labelColor ?? AppColors.buttonColor,
          fontSize: fontSize ?? AppFontSize.fontSize16,
          fontWeight: FontWeight.w400,
          fontFamily: AppColors.fontFamilyLight
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: suffixIcon,
          onPressed: onSuffixIconPressed,
        )
            : null,
        prefixIcon: prefixIcon != null
            ? IconButton(
          icon: prefixIcon,
          onPressed: onPrefixIconPressed,
        )
            : null,
      ),
    ),
  );
}
