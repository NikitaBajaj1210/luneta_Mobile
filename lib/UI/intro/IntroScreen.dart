import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luneta/UI/landing-screen/LandingScreen.dart';
import 'package:luneta/const/font_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../const/color.dart';
import '../../custom-component/custom-button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}
class _IntroScreenState extends State<IntroScreen> {
  final PageController _imagePageController = PageController();
  final PageController _textPageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _sliderData = [
    {
      "image": "assets/images/3_Light_walkthrough 3.png",
      "title": "Discover Opportunities",
      "subtitle":
      "Find your next adventure at sea with access to the best jobs tailored for seafarers worldwide",
    },
    {
      "image": "assets/images/3_Light_walkthrough 3.png",
      "title": "Unlock Exclusive Benefits",
      "subtitle":
      "Enjoy perks designed for seafarers, from wellness programs to financial support & more",
    },
    {
      "image": "assets/images/3_Light_walkthrough 3.png",
      "title": "Stay \n\ Connected",
      "subtitle":
      "Join a global network of seafarers, access industry insights, and stay updated",
    },
  ];

  bool _isImagePageChanging = false;
  bool _isTextPageChanging = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Change status bar color
      statusBarIconBrightness: Brightness.dark, // For light or dark icons
    ));
    _imagePageController.addListener(() {
      if (!_isImagePageChanging && _imagePageController.page != null) {
        int newPage = _imagePageController.page!.round();
        if (_currentPage != newPage) {
          if (mounted) {  // ✅ Check if widget is still in the tree
            setState(() {
              _currentPage = newPage;
            });
          }
          _isTextPageChanging = true;
          _textPageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ).then((_) {
            if (mounted) {
              setState(() {
                _isTextPageChanging = false;
              });
            }
          });
        }
      }
    });

    _textPageController.addListener(() {
      if (!_isTextPageChanging && _textPageController.page != null) {
        int newPage = _textPageController.page!.round();
        if (_currentPage != newPage) {
          if (mounted) {
            setState(() {
              _currentPage = newPage;
            });
          }
          _isImagePageChanging = true;
          _imagePageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ).then((_) {
            if (mounted) {
              setState(() {
                _isImagePageChanging = false;
              });
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _imagePageController.removeListener(() {});  // ✅ Remove listeners
    _textPageController.removeListener(() {});

    _imagePageController.dispose();
    _textPageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.introBackgroundColor,
      body: Stack(
        children: [
          // **PageView for Background Image**
          Positioned.fill(
            child: PageView.builder(
              controller: _imagePageController,
              itemCount: _sliderData.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  _sliderData[index]["image"]!,
                  width: 100.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          // **White Card at the Bottom**
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 42.h,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h).copyWith(top: 4.5.h),
              decoration: BoxDecoration(
                color: AppColors.Color_FFFFFF,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.Color_212121.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 1.h,),
                  // **Title and Subtitle Scroll in Sync with Image**
                  Expanded(
                    child: PageView.builder(
                      controller: _textPageController,
                      itemCount: _sliderData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            // **Title**
                            Container(
                              height: 12.h,
                              width: 90.w,
                              child: Text(
                                _sliderData[index]["title"]!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize40,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.Color_607D8B,
                                  fontFamily: AppColors.fontFamilyBold,
                                  height: 1.2, // Adjust this value to control line height
                                ),
                              ),
                            ),

                            Container(
                              // color: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              margin: EdgeInsets.only(top: 1.5.h),
                              child: Text(
                                _sliderData[index]["subtitle"]!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppColors.fontFamilyMedium,
                                  fontSize: AppFontSize.fontSize18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.Color_424242,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // **Page Indicator Dots**
                  Container(
                    // height: 2.h,
                    // color: Colors.red,
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _sliderData.length,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 8.w : 2.w,
                          height: 1.h,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? AppColors.buttonColor
                                : AppColors.greyDotColor,
                            borderRadius: BorderRadius.circular(50.h),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),

                  // **Navigation Button**
                  customButton(
                    voidCallback: () {
                      if (_currentPage == _sliderData.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LandingScreen()),
                        );
                      } else {
                        setState(() {
                          _currentPage++;
                        });

                        // Animate both image and text
                        _imagePageController.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        _textPageController.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    buttonText: _currentPage == _sliderData.length - 1 ? "Get Started" : "Next",
                    width: 90.w,
                    height: 6.h,
                    color: AppColors.buttonColor,
                    buttonTextColor: AppColors.buttonTextWhiteColor,
                    shadowColor: AppColors.buttonBorderColor,
                    fontSize: AppFontSize.fontSize16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
