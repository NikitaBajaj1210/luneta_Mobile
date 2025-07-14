import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:another_xlider/another_xlider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../provider/bottom_menu_provider/filter_screen_provider.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FilterScreenProvider(),
      child: Consumer<FilterScreenProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  children: [
                    backButtonWithCrossIcon(
                      title: "Filter Options",
                      onBackPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(height: 2.h),
                    _buildFilterTabs(provider),
                    SizedBox(height: 3.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.filterOptions.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              _buildFilterOption(provider.filterOptions[index], provider, index),
                            ],
                          );
                        },
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

  /// **1. Builds the Filter Tabs**
  Widget _buildFilterTabs(FilterScreenProvider provider) {
    return SizedBox(
      height: 6.h,
      child: Stack(
        children: [
          Positioned(
            bottom: 4,
            left: 0,
            right: 0,
            child: Container(
              height: 0.2.h,
              color: AppColors.Color_BDBDBD,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(provider.tabs.length, (index) {
                final isSelected = provider.selectedTabIndex == index;
                return GestureDetector(
                  onTap: () {
                    provider.setSelectedTabIndex(index);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Tab Text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w).copyWith(left: 0),
                        child: Text(
                          provider.tabs[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize18,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppColors.fontFamilySemiBold,
                            color: isSelected
                                ? AppColors.buttonColor
                                : AppColors.Color_9E9E9E,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.7.h), // Keeps spacing consistent
                      // Active Tab Underline (Dynamic Width)
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: 0.4.h,
                        width: _calculateTextWidth(provider.tabs[index], context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.h),
                          color: isSelected ? AppColors.buttonColor : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );

  }

  /// **2. Dropdown UI for Filter Options**
  Widget _buildFilterOption(String title, FilterScreenProvider provider, int index) {
    bool isExpanded = provider.expandedIndexes.contains(index);

    return Column(
      children: [
        GestureDetector(
          onTap: () => provider.toggleExpandedIndex(index),
          child: Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.Color_FFFFFF,
              borderRadius: BorderRadius.circular(2.5.h),
              border: Border.all(color: AppColors.Color_EEEEEE, width: 0.1.h),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Title & Expand Icon**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.Color_212121,
                        fontFamily: AppColors.fontFamilyBold
                      ),
                    ),
                    Image.asset(
                      isExpanded ? "assets/images/ArrowUp.png" : "assets/images/ArrowDown.png",
                      height: 2.5.h,
                    ),
                  ],
                ),

                /// **Expanded Content (Only visible when expanded)**
                if (isExpanded) ...[
                  SizedBox(height: 1.h),
                  if (title == "Location & Salary") _buildLocationSalary(provider),
                  if (title == "Work Type") _buildWorkType(provider),
                  if (title == "Job Level") _buildJobLevelDropdown(provider),
                  if (title == "Employment Type") _buildDropdown(provider, title, provider.employmentTypes, false),
                  if (title == "Experience") _buildDropdown(provider, title, provider.experienceLevels, false),
                  if (title == "Education") _buildDropdown(provider, title, provider.educationLevels, true),
                  if (title == "Job Function") _buildDropdown(provider, title, provider.jobFunctions, true),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  /// **3. Location & Salary UI**
  Widget _buildLocationSalary(FilterScreenProvider provider) {
    return Column(
      children: [
        /// **Location Selection Field**
         Container(
                  margin: EdgeInsets.only(bottom: 3.h,top: 2.h),
                  height: 0.05.h,
                  color: AppColors.Color_EEEEEE,
                  width: 100.w,
                ),
        GestureDetector(
          onTap: () {
            // Handle location selection logic here
          },
          child: Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.Color_FAFAFA,
              borderRadius: BorderRadius.circular(2.h),
            ),
            child: Row(
              children: [
                Image.asset("assets/images/Location.png",
                    color: AppColors.Color_212121, height: 2.5.h),
                SizedBox(width: 2.w),
                Text(
                  "United States",
                  style: TextStyle(
                      fontSize: AppFontSize.fontSize16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.Color_212121,
                      fontFamily: AppColors.fontFamilySemiBold),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 4.h),

        /// **Salary Range Slider**
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              left: ((provider.lowerValue / 500) * 85.w) - 5.5.w,
              top: -2.h,
              child: _buildTooltip("\$${provider.lowerValue.toInt()}k"),
            ),
            Positioned(
              left: ((provider.upperValue / 500) * 85.w) - 11.5.w,
              top: -2.h,
              child: _buildTooltip("\$${provider.upperValue.toInt()}k"),
            ),
            FlutterSlider(
              values: [provider.lowerValue, provider.upperValue],
              rangeSlider: true,
              max: 500,
              min: 0,
              handler: FlutterSliderHandler(
                decoration: BoxDecoration(),
                child: _customThumb(size: 20),
              ),
              rightHandler: FlutterSliderHandler(
                decoration: BoxDecoration(),
                child: _customThumb(size: 20),
              ),
              trackBar: FlutterSliderTrackBar(
                activeTrackBarHeight: 0.4.h,
                inactiveTrackBarHeight: 0.4.h,
                activeTrackBar: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(1.h),
                ),
                inactiveTrackBar: BoxDecoration(
                  color: AppColors.Color_EEEEEE,
                  borderRadius: BorderRadius.circular(1.h),
                ),
              ),
              tooltip: FlutterSliderTooltip(disabled: true),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                provider.lowerValue = lowerValue;
                provider.upperValue = upperValue;
                provider.notifyListeners();
              },
            ),
          ],
        ),

        SizedBox(height: 1.5.h),

        /// **Per Month Dropdown**
        Container(
          decoration: BoxDecoration(
            color: AppColors.Color_FAFAFA,
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
            value: provider.selectedMonth,
            onChanged: (String? newValue) {
              provider.selectedMonth = newValue!;
            },
            items: <String>['per month', 'January', 'February', 'Other']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,style: TextStyle(fontFamily: AppColors.fontFamilySemiBold,fontSize: AppFontSize.fontSize16,color: AppColors.Color_212121,fontWeight: FontWeight.w600),),
              );
            }).toList(),
            icon: Image.asset(
              'assets/images/dropdownIcon.png', // Path to your custom icon
             height: 2.5.h,
            ),
          ),
        ),
        SizedBox(height: 1.h),
      ],
    );
  }


  /// **4. Custom Thumb (Image Only)**
  Widget _customThumb({double size = 30}) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        "assets/images/Ellipse.png",
        fit: BoxFit.contain,
      ),
    );
  }

  /// **5. Tooltip UI**
  Widget _buildTooltip(String text) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(0.5.h),
          ),
          child: Text(text, style: TextStyle(color: AppColors.Color_FFFFFF, fontSize: AppFontSize.fontSize12, fontWeight: FontWeight.w500)),
        ),
        ClipPath(
          clipper: TriangleClipper(),
          child: Container(width: 2.5.w, height: 1.h, color: AppColors.buttonColor),
        ),
      ],
    );
  }

  /// **6. Calculate Text Width**
  double _calculateTextWidth(String text, BuildContext context) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(fontSize: AppFontSize.fontSize18, fontWeight: FontWeight.w600)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width + 6.w;
  }

  Widget _buildWorkType(FilterScreenProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// **Divider Line**
        Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          height: 0.05.h,
          color: AppColors.Color_EEEEEE,
          width: 100.w,
        ),

        /// **Work Type Selection**
        Container(
          height: 12.h, // Adjust this value to fit your needs
          child: ListView.builder(
            itemCount: provider.filteredCountries.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // Ensures scrolling is allowed
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Container(
                height: 6.h,
                child: GestureDetector(
                  onTap: () => provider.updateSelectedCountry(index),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.5.h),
                    child: Row(
                      children: [
                        Radio<int>(
                          fillColor: MaterialStateProperty.all(AppColors.buttonColor),
                          value: index,
                          groupValue: provider.selectedCountryIndex,
                          onChanged: (value) {
                            provider.updateSelectedCountry(value);
                          },
                        ),
                        Text(
                          provider.filteredCountries[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: AppColors.fontFamilySemiBold,
                            color: AppColors.Color_212121,
                            fontSize: AppFontSize.fontSize16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),


      ],
    );
  }

  /// **Dropdown UI for Job Level**
  /// **Dropdown UI for Job Level with Custom Checkbox**
  Widget _buildJobLevelDropdown(FilterScreenProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// **Divider Line**
        Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          height: 0.05.h,
          color: AppColors.Color_EEEEEE,
          width: 100.w,
        ),

        /// **Job Level Selection**
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Prevents independent scrolling
          itemCount: provider.jobLevels.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            bool isSelected = provider.selectedJobLevels.contains(index);

            return GestureDetector(
              onTap: () {
                provider.toggleJobLevelSelection(index);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.8.h).copyWith(bottom: 2.h),
                child: Row(
                  children: [
                    /// **Custom Checkbox**
                    Container(
                      height: 2.8.h,
                      width: 2.8.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.buttonColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(1.h),
                        border: Border.all(
                          color: AppColors.buttonColor,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Image.asset("assets/images/tickIcon.png",
                          scale: 0.5.h)
                          : Container(),
                    ),
                    SizedBox(width: 3.w),
                    /// **Job Level Text**
                    Text(
                      provider.jobLevels[index],
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.Color_212121,
                        fontFamily: AppColors.fontFamilySemiBold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  /// **Dropdown UI for Filter Categories**
  Widget _buildDropdown(FilterScreenProvider provider, String title, List<String> options, bool isCheckbox) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// **Divider Line**
        Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          height: 0.05.h,
          color: AppColors.Color_EEEEEE,
          width: 100.w,
        ),

        /// **ListView for Selection Options**
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Prevents independent scrolling
          itemCount: options.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            bool isSelected = isCheckbox
                ? provider.selectedCheckboxOptions.contains(index) // For checkboxes
                : provider.selectedRadioOption == index; // For radio buttons

            return GestureDetector(
              onTap: () {
                isCheckbox
                    ? provider.toggleCheckboxSelection(index) // Multiple selection
                    : provider.updateSelectedRadio(index); // Single selection
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.8.h).copyWith(bottom: 2.h),
                child: Row(
                  children: [
                    /// **Custom Checkbox or Radio Button**
                    Container(
                      height: 2.8.h,
                      width: 2.8.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.buttonColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(1.h),
                        border: Border.all(
                          color: AppColors.buttonColor,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Image.asset("assets/images/tickIcon.png",
                          scale: 0.5.h)
                          : Container(),
                    ),

                    SizedBox(width: 3.w),
                    /// **Option Text**
                    Text(
                      options[index],
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.Color_212121,
                        fontFamily: AppColors.fontFamilySemiBold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }


}
/// **7. Triangle Clipper for Tooltip Arrow**
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(size.width / 2, size.height)..lineTo(0, 0)..lineTo(size.width, 0)..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
