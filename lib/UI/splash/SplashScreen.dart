import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../route/route_constants.dart';
import '../../network/network_helper.dart';
import '../../network/network_services.dart';
import '../../network/app_url.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  // Method to check if user is already logged in
  Future<void> _checkAutoLogin() async {
    try {
      // Use NetworkHelper data which is already synced in main.dart
      bool isLoggedIn = NetworkHelper.isLoggedIn;
      String userId = NetworkHelper.loggedInUserId;
      String token = NetworkHelper.token;
      
      print("SplashScreen - Auto Login Check - isLoggedIn: $isLoggedIn, userId: $userId, token: ${token.isNotEmpty ? '[EXISTS]' : '[EMPTY]'}");
      
      // Check if user is logged in and has valid credentials
      if (isLoggedIn && userId.isNotEmpty && token.isNotEmpty) {
        print("SplashScreen - User is already logged in, checking profile completion");
        
        // Check user's profile completion status
        bool isProfileComplete = await _checkProfileCompletion(userId, token, context);
        
        if (context.mounted) {
          if (isProfileComplete) {
            print("SplashScreen - Profile is complete, navigating to home");
            Navigator.of(context).pushReplacementNamed(bottomMenu);
          } else {
            print("SplashScreen - Profile is incomplete, navigating to choose country");
            Navigator.of(context).pushReplacementNamed(chooseCountry);
          }
        }
      } else {
        print("SplashScreen - No auto login, navigating to welcome");
        // Navigate to welcome screen
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed(welcome);
        }
      }
    } catch (e) {
      print("SplashScreen - Auto Login Error: $e");
      // Navigate to welcome screen on error
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(welcome);
      }
    }
  }

  // Method to check if user's profile is complete
  Future<bool> _checkProfileCompletion(String userId, String token, BuildContext context) async {
    try {
      // Make API call to get user's complete profile
      final response = await NetworkService().getResponse(
        getSeafarerCompleteProfile + userId,
        false, // showLoading
        context, // context
        () => {}, // callback
      );
      
      print("SplashScreen - Profile completion check response: $response");
      
      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        // Check if the response contains profile data
        if (response['data'] != null && response['data']['seafarerProfile'] != null) {
          bool isCompletedMobile = response['data']['seafarerProfile']['isCompletedMobile'] ?? false;
          print("SplashScreen - Profile completion status: $isCompletedMobile");
          return isCompletedMobile;
        }
      }
      
      // Default to false if API call fails or data is missing
      print("SplashScreen - Could not determine profile completion, defaulting to false");
      return false;
    } catch (e) {
      print("SplashScreen - Profile completion check error: $e");
      // Default to false on error
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      _controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      );
      _animation = CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      );

      _controller!.forward();
      Future.delayed(const Duration(seconds: 3), () {
        _checkAutoLogin(); // Check for auto-login instead of directly navigating
      });
    });
    // Start the animation
  }

  @override
  void dispose() {
    _controller?.dispose(); // Dispose the controller properly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your background color
      body: SizedBox(
        height: 100.h, // Ensure the container takes up the full screen height
        child: Column(
          children: [
            // Upper content with logo and subtitle
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated logo with zoom-out effect
                  AnimatedBuilder(
                    animation: _controller ?? AlwaysStoppedAnimation(0),
                    builder: (context, child) {
                      // Ensure _controller is not null
                      return Transform.scale(
                        scale: _animation?.value ?? 1,  // Default to 1 if animation is null
                        child: child,
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/LunetaLogo.png', // Replace with your logo path
                          width: 75.w, // Adjust size to fit your needs
                        ),
                        SizedBox(height: 1.5.h), // Adjust space between logo and subtitle

                        // Subtitle logo
                        SizedBox(
                          width: 70.w,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              'assets/images/LogoSubTitle.png',
                              width: 35.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Gradient loader using ShaderMask positioned at the bottom
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Color(0xFF607D8B), // First color
                  Color(0xFF90A4AE), // Second color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: LoadingAnimationWidget.hexagonDots(
                color: Colors.white, // Apply gradient through ShaderMask
                size: 5.5.h, // Adjust size to ensure visibility
              ),
            ),
            SizedBox(height: 3.h), // Optional spacing below the loader
          ],
        ),
      ),
    );
  }
}
