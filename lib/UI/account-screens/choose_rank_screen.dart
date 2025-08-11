import 'package:flutter/material.dart';
import 'package:luneta/provider/account-provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';
import '../../network/network_services.dart';
import '../../provider/account-provider/choose_country_provider.dart';
import '../../provider/account-provider/choose_rank_provider.dart';
import '../../route/route_constants.dart';

class ChooseRankScreen extends StatefulWidget {
  const ChooseRankScreen({super.key});

  @override
  State<ChooseRankScreen> createState() => _ChooseRankScreenState();
}

class _ChooseRankScreenState extends State<ChooseRankScreen> {

  @override
  void initState() {
    NetworkService.loading = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<ChooseRankProvider>(context, listen: false);
      provider.GetAllRank(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      color: AppColors.Color_FFFFFF,
      alignment: Alignment.center,

      child: Consumer<ChooseRankProvider>(
        builder: (context, provider, child) {
          return
          SafeArea(

            child: Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              bottomNavigationBar:
              Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.bottomNavBorderColor),
                ),
                child: customButton(
                  voidCallback: provider.selectedIndex == null
                      ? null
                      : () async {

                    // Navigate to Profile Screen (country data is already in global provider)

                 //    var prefs = await SharedPreferences.getInstance();
                 //    String? firstName= await prefs.getString('firstName');
                 //   String? lastName= await prefs.getString('lastName');
                 // Provider.of<ProfileProvider>(context, listen: false).initNameControllerWithValue(firstName!);
                 // Provider.of<ProfileProvider>(context, listen: false).nickNameController.text=lastName!;
                    Navigator.of(context).pushNamed(profile);
                  },
                  buttonText: "Continue",
                  width: 90.w,
                  height: 4.h,
                  color: provider.selectedIndex == null
                      ? AppColors.Color_BDBDBD
                      : AppColors.buttonColor,
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: provider.selectedIndex != null,
                ),
              ),
              body: Container(
                height: 100.h,
                width: 100.w,
                color: AppColors.Color_FFFFFF,
                child: NetworkService.loading == 0 ? Center(
                  child: CircularProgressIndicator(color: AppColors.Color_607D8B),
                ) :
                NetworkService.loading == 1 ? Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        NetworkService.loading = 0;
                        provider.GetAllRank(context);
                        setState(() {});
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                              'assets/images/refresh.png',
                              width: 4.5.h,
                              height: 4.5.h,
                              color: AppColors.Color_607D8B
                          ),
                          SizedBox(
                            height:1.h,
                          ),
                          Text(
                            "Tap to Try Again",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: AppColors.fontFamilyBold,
                                fontSize: AppFontSize.fontSize15,
                                color: AppColors.Color_607D8B,
                                decoration: TextDecoration.none
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ): Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      backButtonWithTitle(
                        title: "",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "What is your Rank",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize32,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppColors.fontFamilyBold,
                          color: AppColors.Color_212121,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        alignment: Alignment.center,
                        child: Text(
                          "You can change it later from your profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppFontSize.fontSize18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.Color_212121,
                            fontFamily: AppColors.fontFamilyRegular,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2.h, bottom: 2.5.h),
                        height: 0.1.h,
                        color: AppColors.Color_EEEEEE,
                        width: 100.w,
                      ),
                      // List of ranks with checkboxes
                      Expanded(
                        child: ListView.builder(
                          itemCount: provider.ranks.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                provider.setSelectedRankIndex(index: index);
                              },
                              child: Container(
                                width: 90.w,
                                margin: EdgeInsets.only(bottom: 2.h),
                                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.2.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.5.h),
                                  border: Border.all(
                                    color: provider.selectedIndex == index
                                        ? AppColors.buttonColor
                                        : AppColors.Color_EEEEEE, // Replaced borderColor
                                    width: 0.3.w,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 2.6.h,
                                      width: 2.6.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: provider.selectedIndex == index
                                            ? AppColors.buttonColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(1.h),
                                        border: Border.all(
                                          color: provider.selectedIndex == index
                                              ? AppColors.buttonColor
                                              : AppColors.buttonColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: provider.selectedIndex == index
                                          ? Image.asset("assets/images/tickIcon.png", scale: 0.5.h)
                                          : Container(),
                                    ),
                                    SizedBox(width: 3.w),
                                    Text(
                                      provider.ranks[index].rankName??'',
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}