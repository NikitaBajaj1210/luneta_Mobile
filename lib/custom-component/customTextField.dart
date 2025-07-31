import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../const/color.dart';
import '../const/font_size.dart';

Widget customTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String? Function(String?)? voidCallback,
  TextInputAction? textInputAction,
  required String hintText,
  int? maxLength,
  bool? isEditable,
  required TextInputType textInputType,
  List<TextInputFormatter>? inputFormatter,
  Function(String)? onChange,
  Color? backgroundColor,
  double? width,
  Widget? suffixIcon,
  VoidCallback? onSuffixIconPressed,
  bool obscureText = false,
  double? fontSize,
  double? inputFontSize,
  double? iconSize,
  Color? borderColor,
  Color? textColor,
  Color? labelColor,
  Color? cursorColor,
  Widget? prefixIcon,
  VoidCallback? onPrefixIconPressed,
  FocusNode? focusNode,
  String? FontFamily,
  bool isReadOnly = false, // New optional parameter for read-only
  required Color fillColor,
  required Function(String)? onFieldSubmitted,
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled, // New parameter
}) {
  final FocusNode _focusNode = focusNode ?? FocusNode();
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 0.1.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2.h),
    ),
    child: TextFormField(
      controller: controller,
      enabled: isEditable ?? true,
      readOnly: isReadOnly,
      cursorColor: AppColors.Color_212121,
      textInputAction: textInputAction,
      maxLength: maxLength,
      validator: voidCallback,
      keyboardType: textInputType,
      inputFormatters: inputFormatter,
      onChanged: onChange,
      obscureText: obscureText,
      focusNode: _focusNode,
      onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: autovalidateMode, // Use provided autovalidateMode
      style: TextStyle(
        fontSize: AppFontSize.fontSize16,
        color: textColor ?? AppColors.buttonColor,
        fontFamily:AppColors.fontFamilySemiBold,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        counterText: '',
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 4.w),
        hintText: hintText,
        errorStyle: TextStyle(
          color: AppColors.errorRedColor,
          fontSize: AppFontSize.fontSize12,
        ),
        hintStyle: TextStyle(
          color: labelColor ?? AppColors.Color_9E9E9E,
          fontSize: AppFontSize.fontSize16,
          fontWeight: FontWeight.w400,
          fontFamily:FontFamily?? AppColors.fontFamilyRegular,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent, width: 0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent, width: 0),
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