import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:luneta/const/color.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CountryDropdown extends StatelessWidget {
  final String? selectedCountry;
  final Function(Country) onCountryChanged;

  const CountryDropdown({
    Key? key,
    required this.selectedCountry,
    required this.onCountryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          onSelect: (Country country) {
            onCountryChanged(country);
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppColors.Color_FAFAFA,
          borderRadius: BorderRadius.circular(2.h),
          border: Border.all(
            color: AppColors.buttonColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedCountry ?? 'Select Country'),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
