import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../route/route_constants.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

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
        Navigator.of(context).pushReplacementNamed(welcome);
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
