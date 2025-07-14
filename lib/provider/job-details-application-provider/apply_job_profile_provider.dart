import 'package:flutter/material.dart';

class ApplyJobProfileProvider with ChangeNotifier {
  String _location = "New York, United States";
  String _phoneNumber = "+1 111 467 378 399";
  String _email = "andrew_ainsley@yourdomain.com";
  String _summary =
      "Hello, I'm Andrew. I am a designer with more than 5 years of experience. My main fields are UI/UX Design, Illustration, and Graphic Design. You can check the portfolio on my profile.";
  String _salaryExpectation = "\$10,000 - \$25,000 /month (only you can see this)";
  String _profileImage = "assets/images/ProfilePic.png";
  String _name = "Andrew Ainsley";
  String _jobTitle = "UI/UX Designer at Paypal Inc.";

  // Getters
  String get location => _location;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get summary => _summary;
  String get salaryExpectation => _salaryExpectation;
  String get profileImage => _profileImage;
  String get name => _name;
  String get jobTitle => _jobTitle;
}
