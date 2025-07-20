import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../const/color.dart';
import '../const/font_size.dart';

Widget countryPhoneInput({
  required PhoneNumber phoneNumber,
  required Function(PhoneNumber) onPhoneChanged,
  required TextEditingController controller,
  int maxLength = 10,
  Color? backgroundColor,
  Color? borderColor,
  bool? isEditable,
  FocusNode? focusNode,
  double? width,
  Color? labelColor,
  Color? iconColor,
  required Function(String)? onFieldSubmitted,
  String? Function(String?)? validator,
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      PhoneNumber currentPhoneNumber = phoneNumber;
      bool _isSubmitted = false;

      // Listen to text changes
      void _onTextChange() {
        setState(() {});
      }

      // Add listener for text changes
      controller.addListener(_onTextChange);

      void _selectCountry() {
        showCountryPicker(
          context: context,
          showPhoneCode: true,

          onSelect: (Country country) {
            setState(() {
              currentPhoneNumber = PhoneNumber(
                isoCode: country.countryCode,
                dialCode: "+${country.phoneCode}",
                phoneNumber: controller.text,
              );
            });
            onPhoneChanged(currentPhoneNumber);
          },
        );
      }

      // Determine if the border should be shown
      bool showBorder = (focusNode?.hasFocus ?? false) || (controller.text.isNotEmpty && !_isSubmitted);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            // height: 7.28.h, // Match the height of other fields
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.Color_FAFAFA,
              borderRadius: BorderRadius.circular(2.h),
              border: Border.all(
                width: 1,
                color: showBorder ? (borderColor ?? AppColors.buttonColor) : Colors.transparent,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _selectCountry,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentPhoneNumber.isoCode != null
                              ? CountryParser.parse(currentPhoneNumber.isoCode!)?.flagEmoji ?? '🌍'
                              : '🌍',
                          style: TextStyle(fontSize: AppFontSize.fontSize20), // Slightly smaller flag for better fit
                        ),
                        SizedBox(width: 1.w),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: iconColor ?? AppColors.Color_212121,
                          size: 2.5.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InternationalPhoneNumberInput(
                    validator: validator,
                    cursorColor: AppColors.Color_212121,
                    textStyle: TextStyle(
                      fontSize: AppFontSize.fontSize16,
                      color: AppColors.Color_212121,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppColors.fontFamilySemiBold,
                    ),
                    textFieldController: controller,
                    focusNode: focusNode,
                    onInputChanged: (PhoneNumber number) {
                      setState(() {
                        currentPhoneNumber = number;
                      });
                      onPhoneChanged(number);
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        _isSubmitted = true;
                      });
                      if (onFieldSubmitted != null) {
                        onFieldSubmitted(value);
                      }
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      showFlags: false,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: autovalidateMode,
                    initialValue: currentPhoneNumber,
                    formatInput: false,
                    keyboardType: TextInputType.number,
                    maxLength: maxLength,
                    inputDecoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: labelColor ?? AppColors.Color_9E9E9E, // Match customTextField hint color
                        fontSize: AppFontSize.fontSize16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppColors.fontFamilyRegular,
                      ),
                      hintText: '123 456 7890',
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 0.w),
                      errorStyle: TextStyle(
                        height: 0,
                        fontSize: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}