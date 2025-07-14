import 'package:flutter/material.dart';

class DeactivateAccountProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _application = [
    {
      "position": "UI/UX Designer",
      "company": "Google LLC",
      "status": "Application Sent",
      "image": "assets/images/GoogleIcon.png",  // Replace with actual path
    },
    {
      "position": "Software Engineer",
      "company": "Paypal",
      "status": "Application Accepted",
      "image": "assets/images/paypal_logo.png",  // Replace with actual path
    },
    {
      "position": "Application Developer",
      "company": "Figma",
      "status": "Application Rejected",
      "image": "assets/images/figma_logo.png",  // Replace with actual path
    },
    {
      "position": "Web Designer",
      "company": "Twitter Inc.",
      "status": "Application Pending",
      "image": "assets/images/bird.png",  // Replace with actual path
    },
  ];

  List<Map<String, dynamic>> get application => _application;

// Optionally, you can have a setter to modify the list or data.
}
