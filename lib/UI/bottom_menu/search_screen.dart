import 'package:flutter/material.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/customTextField.dart';
import '../../provider/bottom_menu_provider/search_screen_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchScreenProvider(),
      child: Consumer<SearchScreenProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              resizeToAvoidBottomInset: false,
              body: Container(
                color: AppColors.Color_FFFFFF,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        backButtonWithTitle(
                          title: "",
                          onBackPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          width: 79.5.w,
                          child: customTextField(
                            context: context,
                            focusNode: provider.searchFocusNode,
                            controller: provider.searchController,
                            hintText: 'Search for a job or company',
                            textInputType: TextInputType.name,
                            obscureText: false,
                            voidCallback: (_) {},
                            fontSize: AppFontSize.fontSize16,
                            inputFontSize: AppFontSize.fontSize14,
                            iconSize: AppFontSize.fontSize20,
                            backgroundColor: provider.searchFocusNode.hasFocus
                                ? AppColors.activeFieldBgColor
                                : AppColors.bottomNavBorderColor,
                            borderColor: AppColors.buttonColor,
                            textColor: AppColors.Color_212121,
                            labelColor: AppColors.Color_9E9E9E,
                            cursorColor: AppColors.buttonColor,
                            fillColor: provider.searchFocusNode.hasFocus
                                ? AppColors.activeFieldBgColor
                                : AppColors.bottomNavBorderColor,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).unfocus();
                              _search(
                                  value, provider); // Call the search function
                            },
                            onChange: (value) {
                              _search(value,
                                  provider); // Call the search function on text change
                            },
                            suffixIcon: Image.asset(
                              "assets/images/Filter.png",
                              width: 2.h,
                              height: 2.h,
                              color: provider.searchFocusNode.hasFocus
                                  ? AppColors.buttonColor
                                  : (provider.searchController.text.isNotEmpty
                                      ? AppColors.Color_212121
                                      : AppColors.Color_BDBDBD),
                            ),
                            onSuffixIconPressed: () {
                              Navigator.of(context).pushNamed(filterScreen);
                            },
                            prefixIcon: Image.asset(
                              "assets/images/Search.png",
                              width: 2.h,
                              height: 2.h,
                              color: provider.searchFocusNode.hasFocus
                                  ? AppColors.buttonColor
                                  : (provider.searchController.text.isNotEmpty
                                      ? AppColors.Color_212121
                                      : AppColors.Color_BDBDBD),
                            ),
                            onPrefixIconPressed: () {
                              // Handle prefix icon press if needed
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${provider.visibleRecommendations.length} found",
                          // Display the count of found results
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.Color_212121,
                            fontFamily: AppColors.fontFamilyBold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Sort the recommendations
                            showSortPopupMenu(context, provider);
                          },
                          child: Image.asset(
                            "assets/images/Swap.png",
                            height: 2.5.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    provider.visibleRecommendations.length == 0
                        ? Container(
                            height: 75.h,
                            // color: Colors.blue,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    "assets/images/searchListNotFound.png"),
                                SizedBox(height: 2.h),
                                Text("Not Found",
                                    style: TextStyle(
                                      fontSize: AppFontSize.fontSize24,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: AppColors.fontFamilyBold,
                                      color: AppColors.Color_212121,
                                    )),
                                SizedBox(height: 2.h),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 0.5.w, right: 0.5.w),
                                  child: Text(
                                    "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: AppFontSize.fontSize18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: AppColors.fontFamilyRegular,
                                      color: AppColors.Color_212121,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: provider.visibleRecommendations.length,
                              // Use visibleRecommendations
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final item = provider.visibleRecommendations[
                                    index]; // Use visibleRecommendations
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 5.w),
                                  // Adjust spacing between cards
                                  child: Container(
                                    width: 100
                                        .w, // Set width to 90% of screen width
                                    padding: EdgeInsets.all(2.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color:
                                              AppColors.Color_EEEEEE,
                                          width: 0.1.h),
                                      color: AppColors.Color_FFFFFF,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      EdgeInsets.all(1.5.h),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  1.5.h)),
                                                      color: AppColors.Color_FFFFFF,
                                                      border: Border.all(
                                                        width: 0.1.h,
                                                        color: AppColors
                                                            .Color_EEEEEE,
                                                      )),
                                                  child: Image.asset(
                                                    item["companyLogo"],
                                                    height: 4.h,
                                                  ),
                                                ),
                                                SizedBox(width: 2.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item['jobTitle'],
                                                      style: TextStyle(
                                                        fontSize: AppFontSize.fontSize18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: AppColors
                                                            .fontFamilyBold,
                                                        color: AppColors
                                                            .Color_212121,
                                                      ),
                                                    ),
                                                    Text(
                                                      item['companyName'],
                                                      style: TextStyle(
                                                        fontSize: AppFontSize.fontSize14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.Color_616161,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              child: item['isSaved']
                                                  ? Image.asset(
                                                      "assets/images/saveInactive.png",
                                                      height: 2.5.h,
                                                      color:
                                                          AppColors.buttonColor,
                                                    )
                                                  : Image.asset(
                                                      "assets/images/saveActive.png",
                                                      height: 2.5.h),
                                              onTap: () {
                                                provider.toggleSaveStatus(index);
                                              },
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 2.h, bottom: 1.h),
                                          height: 0.05.h,
                                          color:
                                              AppColors.Color_EEEEEE,
                                          width: 100.w,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 16.w),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 1.h),
                                              Text(
                                                item['jobType'],
                                                style: TextStyle(
                                                  fontSize: AppFontSize.fontSize18,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.Color_616161,
                                                  fontFamily:
                                                      AppColors.fontFamilyBold,
                                                ),
                                              ),
                                              SizedBox(height: 1.h),
                                              Text(
                                                item['salaryRange'],
                                                style: TextStyle(
                                                  fontSize: AppFontSize.fontSize18,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.buttonColor,
                                                  fontFamily:
                                                      AppColors.fontFamilyBold,
                                                ),
                                              ),
                                              SizedBox(height: 1.h),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  _buildTag(item['duration']),
                                                  SizedBox(width: 3.w),
                                                  item['requirements'] == null
                                                      ? SizedBox()
                                                      : _buildTag(
                                                          item['requirements']),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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

  void _search(String query, SearchScreenProvider provider) {
    provider.filterJobs(
        query); // Use the filterJobs method to filter recommendations
    setState(() {});
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.8.h)),
          border: Border.all(
            width: 0.1.h,
            color: AppColors.Color_757575,
          )),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppFontSize.fontSize12,
          fontWeight: FontWeight.w500,
          color: AppColors.Color_757575,
        ),
      ),
    );
  }
}

void showSortPopupMenu(BuildContext context, SearchScreenProvider provider) {
  RenderBox renderBox = context.findRenderObject() as RenderBox;
  Offset position = renderBox.localToGlobal(Offset.zero);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Positioned(
            top: position.dy + 3.h,
            right: 4.w,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 55.w,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppColors.Color_FFFFFF,
                  borderRadius: BorderRadius.circular(2.h),
                  boxShadow: [
                    BoxShadow(
                      color:  Color.fromRGBO(4, 6, 15, 0.08),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(provider.sortOptions.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        provider.sortJobs(provider.sortOptions[index]);
                        Navigator.pop(context); // Close menu
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.5.h,),
                            Text(
                              provider.sortOptions[index],
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize16,
                                fontFamily: AppColors.fontFamilySemiBold,
                                fontWeight: FontWeight.w600,
                                color: provider.selectedSortOption ==
                                    provider.sortOptions[index]
                                    ? AppColors.buttonColor
                                    : AppColors.Color_212121,
                              ),
                            ),
                            SizedBox(height: 1.5.h,),
                            if (index != provider.sortOptions.length - 1)
                              Divider(color: AppColors.Color_EEEEEE),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}


