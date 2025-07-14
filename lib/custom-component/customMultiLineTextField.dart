import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luneta/const/font_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../const/color.dart';

Widget customMultilineTextField({


  required BuildContext context,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required String hintText,
  int? maxLength,
  bool? isEditable,
  TextInputAction? textInputAction,
  required TextInputType textInputType,
  List<TextInputFormatter>? inputFormatter,
  Function(String)? onChange,
  Color? backgroundColor,
  double? width,
  int? maxLines,
  Widget? suffixIcon,
  VoidCallback? onSuffixIconPressed,
  double? fontSize,
  double? inputFontSize,
  Color? borderColor,
  Color? textColor,
  Color? labelColor,
  Color? cursorColor,
  FocusNode? focusNode,
  required Color fillColor,
  required Function(String)? onFieldSubmitted,
}) {
  final FocusNode _focusNode = focusNode ?? FocusNode();

  return Container(
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2.h),
    ),
    child: TextFormField(
      controller: controller,
      enabled: isEditable ?? true,
      cursorColor: cursorColor ?? AppColors.Color_212121,
      textInputAction: textInputAction ?? TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLength: maxLength,
      maxLines: maxLines, // Allow multiline
      minLines: 4, // Minimum lines to start with
      validator: validator,
      inputFormatters: inputFormatter,
      onChanged: onChange,
      focusNode: _focusNode,
      onFieldSubmitted: onFieldSubmitted,
      style: TextStyle(
        fontSize: fontSize ?? AppFontSize.fontSize16,
        color: textColor ?? AppColors.buttonColor,
        fontFamily: AppColors.fontFamily,
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
          color: AppColors.buttonColor,
          fontSize: AppFontSize.fontSize16,
        ),
        hintStyle: TextStyle(
          color: labelColor ?? AppColors.Color_9E9E9E,
          fontSize: AppFontSize.fontSize16,
          fontWeight: FontWeight.w400,
          fontFamily: AppColors.fontFamily,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide(color: borderColor ?? AppColors.buttonColor, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide(color: borderColor ?? AppColors.buttonColor, width: 0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.h),
          borderSide: BorderSide(color: borderColor ?? AppColors.buttonColor, width: 0),
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: suffixIcon,
          onPressed: onSuffixIconPressed,
        )
            : null,
      ),
    ),
  );
}
