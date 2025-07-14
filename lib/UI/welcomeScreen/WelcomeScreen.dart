import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luneta/const/font_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../const/color.dart';
import '../../route/route_constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();


}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(intro);
    });// Start the animation
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w, // Set width to 100% of the screen
        height: 100.h,
        alignment: Alignment.center,// Set height to 100% of the screen
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome_bg.png'), // Use the uploaded background image
            fit: BoxFit.cover, // Ensure the image covers the entire screen
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // You can add content on top of the background image here
            Text(
              'Welcome to \nLuneta 👋',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.Color_FFFFFF, // White text for visibility
                fontSize: AppFontSize.fontSize48,
                fontFamily: AppColors.fontFamilyBold,// Responsive font size
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.5.h),
            Text(
              'The best Job Portal for seafarers.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.Color_FFFFFF, // White text for visibility
                fontSize: AppFontSize.fontSize18,
                fontFamily: AppColors.fontFamilyMedium,// Responsive font size
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Empowering Seafarers, Beyond Careers.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.Color_FFFFFF, // White text for visibility
                fontSize: AppFontSize.fontSize18,
                fontFamily: AppColors.fontFamilyMedium,// Responsive font size
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
