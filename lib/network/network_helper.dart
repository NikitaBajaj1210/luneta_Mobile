import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/color.dart';
class NetworkHelper{
  static String loggedInUserId='';
  static String loggedInUserEmail='';
  static String loggedInUserProfilePicURL="";
  static String loggedInUserFullName='';
  static bool isLoggedIn=false;
  static String token = '';
  static String refreshToken = '';
  static String fcmToken = '';

  static var header = {
    "Content-Type": "application/json",
    // "Accept": "application/json",
    "Authorization" : "Bearer $token",
  };

  // Method to store user data after OTP verification
  static Future<void> storeUserData({
    required String userId,
    required String email,
    required String token,
    String? profilePicURL,
    String? fullName,
    String? refreshToken,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      
      // Store in SharedPreferences
      await prefs.setString('userid', userId);
      await prefs.setString('email', email);
      await prefs.setString('token', token);
      if (profilePicURL != null) {
        await prefs.setString('profilePicURL', profilePicURL);
      }
      if (fullName != null) {
        await prefs.setString('fullName', fullName);
      }
      if (refreshToken != null) {
        await prefs.setString('refreshToken', refreshToken);
      }
      await prefs.setBool('isLoggedIn', true);
      
      // Update static variables
      NetworkHelper.loggedInUserId = userId;
      NetworkHelper.loggedInUserEmail = email;
      NetworkHelper.token = token;
      NetworkHelper.loggedInUserProfilePicURL = profilePicURL ?? '';
      NetworkHelper.loggedInUserFullName = fullName ?? '';
      NetworkHelper.refreshToken = refreshToken ?? '';
      NetworkHelper.isLoggedIn = true;
      
      // Update header with new token
      NetworkHelper.header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      
      print("NetworkHelper - User data stored successfully in both NetworkHelper and SharedPreferences");
      print("NetworkHelper - User ID: $userId");
      print("NetworkHelper - Email: $email");
      print("NetworkHelper - Token: $token");
    } catch (e) {
      print("NetworkHelper - Error storing user data: $e");
    }
  }

  // Method to sync data between NetworkHelper and SharedPreferences
  static Future<void> syncUserData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      
      // Load from SharedPreferences to NetworkHelper
      String? userId = prefs.getString('userid');
      String? email = prefs.getString('email');
      String? token = prefs.getString('token');
      String? profilePicURL = prefs.getString('profilePicURL');
      String? fullName = prefs.getString('fullName');
      String? refreshToken = prefs.getString('refreshToken');
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      
      if (userId != null && email != null && token != null && isLoggedIn) {
        NetworkHelper.loggedInUserId = userId;
        NetworkHelper.loggedInUserEmail = email;
        NetworkHelper.token = token;
        NetworkHelper.loggedInUserProfilePicURL = profilePicURL ?? '';
        NetworkHelper.loggedInUserFullName = fullName ?? '';
        NetworkHelper.refreshToken = refreshToken ?? '';
        NetworkHelper.isLoggedIn = true;
        
        // Update header with loaded token
        NetworkHelper.header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };
        
        print("NetworkHelper - User data synced successfully");
        print("NetworkHelper - User ID: $userId");
        print("NetworkHelper - Email: $email");
        print("NetworkHelper - Token: $token");
      } else {
        print("NetworkHelper - No valid user data found for sync");
      }
    } catch (e) {
      print("NetworkHelper - Error syncing user data: $e");
    }
  }

  // Method to load user data from SharedPreferences on app start
  static Future<void> loadUserData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      
      String? userId = prefs.getString('userid');
      String? email = prefs.getString('email');
      String? token = prefs.getString('token');
      String? profilePicURL = prefs.getString('profilePicURL');
      String? fullName = prefs.getString('fullName');
      String? refreshToken = prefs.getString('refreshToken');
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      
      if (userId != null && email != null && token != null && isLoggedIn) {
        NetworkHelper.loggedInUserId = userId;
        NetworkHelper.loggedInUserEmail = email;
        NetworkHelper.token = token;
        NetworkHelper.loggedInUserProfilePicURL = profilePicURL ?? '';
        NetworkHelper.loggedInUserFullName = fullName ?? '';
        NetworkHelper.refreshToken = refreshToken ?? '';
        NetworkHelper.isLoggedIn = true;
        
        // Update header with loaded token
        NetworkHelper.header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };
        
        print("NetworkHelper - User data loaded successfully");
        print("NetworkHelper - User ID: $userId");
        print("NetworkHelper - Email: $email");
        print("NetworkHelper - Token: $token");
      } else {
        print("NetworkHelper - No valid user data found");
      }
    } catch (e) {
      print("NetworkHelper - Error loading user data: $e");
    }
  }

  // Method to clear user data on logout
  static Future<void> clearUserData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      
      // Clear SharedPreferences
      await prefs.remove('userid');
      await prefs.remove('email');
      await prefs.remove('token');
      await prefs.remove('profilePicURL');
      await prefs.remove('fullName');
      await prefs.remove('refreshToken');
      await prefs.remove('isLoggedIn');
      await prefs.remove('rememberMe');
      
      // Clear static variables
      NetworkHelper.loggedInUserId = '';
      NetworkHelper.loggedInUserEmail = '';
      NetworkHelper.token = '';
      NetworkHelper.loggedInUserProfilePicURL = '';
      NetworkHelper.loggedInUserFullName = '';
      NetworkHelper.refreshToken = '';
      NetworkHelper.isLoggedIn = false;
      
      // Update header
      NetworkHelper.header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ",
      };
      
      print("NetworkHelper - User data cleared successfully from both NetworkHelper and SharedPreferences");
    } catch (e) {
      print("NetworkHelper - Error clearing user data: $e");
    }
  }

  // Method to get current user data
  static Map<String, dynamic> getCurrentUserData() {
    return {
      'userId': loggedInUserId,
      'email': loggedInUserEmail,
      'token': token,
      'profilePicURL': loggedInUserProfilePicURL,
      'fullName': loggedInUserFullName,
      'refreshToken': refreshToken,
      'isLoggedIn': isLoggedIn,
    };
  }

  // Method to check if user is logged in
  static bool isUserLoggedIn() {
    return isLoggedIn && token.isNotEmpty;
  }

  // Method to check if token is expired
  static bool isTokenExpired() {
    if (token.isEmpty) return true;
    
    try {
      // Decode the JWT token to check expiration
      Map<String, dynamic> decodedToken = decodeToken(token);
      int? exp = decodedToken['exp'];
      
      if (exp != null) {
        int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        return currentTime >= exp;
      }
      
      return false;
    } catch (e) {
      print("NetworkHelper - Error checking token expiration: $e");
      return true;
    }
  }

  // Method to refresh token if expired
  static Future<bool> refreshTokenIfNeeded() async {
    if (isTokenExpired()) {
      print("NetworkHelper - Token is expired, attempting to refresh");
      
      // For now, clear the expired token and require re-login
      // In a real app, you would call a refresh token API here
      await clearUserData();
      return false;
    }
    
    return true;
  }

  // Method to validate current session
  static Future<bool> validateSession() async {
    if (!isUserLoggedIn()) {
      print("NetworkHelper - User not logged in");
      return false;
    }
    
    if (isTokenExpired()) {
      print("NetworkHelper - Token is expired");
      await clearUserData();
      return false;
    }
    
    print("NetworkHelper - Session is valid");
    return true;
  }

  // Method to debug current token status
  static void debugTokenStatus() {
    print("=== NetworkHelper Token Debug ===");
    print("isLoggedIn: $isLoggedIn");
    print("token: ${token.isNotEmpty ? '[EXISTS]' : '[EMPTY]'}");
    print("loggedInUserId: $loggedInUserId");
    print("loggedInUserEmail: $loggedInUserEmail");
    
    if (token.isNotEmpty) {
      try {
        Map<String, dynamic> decodedToken = decodeToken(token);
        print("Token payload: $decodedToken");
        
        int? exp = decodedToken['exp'];
        int? iat = decodedToken['iat'];
        
        if (exp != null) {
          int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
          int timeUntilExpiry = exp - currentTime;
          print("Token expires at: $exp (${DateTime.fromMillisecondsSinceEpoch(exp * 1000)})");
          print("Current time: $currentTime (${DateTime.fromMillisecondsSinceEpoch(currentTime * 1000)})");
          print("Time until expiry: ${timeUntilExpiry} seconds");
          print("Token is expired: ${isTokenExpired()}");
        }
        
        if (iat != null) {
          print("Token issued at: $iat (${DateTime.fromMillisecondsSinceEpoch(iat * 1000)})");
        }
      } catch (e) {
        print("Error decoding token: $e");
      }
    }
    print("=== End Token Debug ===");
  }

  removeToken(BuildContext context) async {
    await clearUserData();
  }

  static Map<String, dynamic> decodeToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw const FormatException('Invalid token');
    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));

    return jsonDecode(decoded) as Map<String, dynamic>;
  }



  sendFcmTokenToServer() async {
    // for get device id
    // String id = await FlutterUdid.udid;
// for API call for send the FCM token to server
    // if(id.isNotEmpty && token.isNotEmpty && fcmToken.isNotEmpty){
    //   try {
    //     var data = {
    //       "deviceId": id,
    //       "fcmToken": fcmToken,
    //       "isAndroid": Platform.isAndroid,
    //     };
    //
    //     var body = jsonEncode(data);
    //
    //     await post(
    //       Uri.parse(addFcmTokenUrl),
    //       headers: NetworkHelper.header,
    //       body: body,
    //     );
    //
    //   } catch (e) {}
    // }
  }

  // Method to force sync data from SharedPreferences
  static Future<void> forceSyncUserData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      
      print("=== Force Sync Debug ===");
      print("SharedPreferences - userid: ${prefs.getString('userid')}");
      print("SharedPreferences - email: ${prefs.getString('email')}");
      print("SharedPreferences - token: ${prefs.getString('token')?.isNotEmpty == true ? '[EXISTS]' : '[EMPTY]'}");
      print("SharedPreferences - isLoggedIn: ${prefs.getBool('isLoggedIn')}");
      print("SharedPreferences - rememberMe: ${prefs.getBool('rememberMe')}");
      
      // Load from SharedPreferences to NetworkHelper
      String? userId = prefs.getString('userid');
      String? email = prefs.getString('email');
      String? token = prefs.getString('token');
      String? profilePicURL = prefs.getString('profilePicURL');
      String? fullName = prefs.getString('fullName');
      String? refreshToken = prefs.getString('refreshToken');
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      
      if (userId != null && email != null && token != null && isLoggedIn) {
        NetworkHelper.loggedInUserId = userId;
        NetworkHelper.loggedInUserEmail = email;
        NetworkHelper.token = token;
        NetworkHelper.loggedInUserProfilePicURL = profilePicURL ?? '';
        NetworkHelper.loggedInUserFullName = fullName ?? '';
        NetworkHelper.refreshToken = refreshToken ?? '';
        NetworkHelper.isLoggedIn = true;
        
        // Update header with loaded token
        NetworkHelper.header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };
      } else {
      }
    } catch (e) {
      print("NetworkHelper - Error force syncing user data: $e");
    }
  }

}

void ShowToast(String title, String msg) {
  print("ShowToast called with title: $title, msg: $msg"); // Debug print
  int isSuccess = title == "Error" ? 0 : title == "Success" ? 1 : 2;
  Color backgroundColor = isSuccess == 1
      ? AppColors.Color_607D8B
      : isSuccess == 0
      ? AppColors.Color_607D8B
      : AppColors.Color_607D8B;

  // Map the icon to a Unicode character
  // String iconChar = Icon(
  //   isSuccess == 1
  //       ? Icons.check_circle
  //       : isSuccess == 0
  //       ? Icons.error
  //       : Icons.warning_amber,
  //   color: AppColors.color_FFFFFF,
  // ),

  // Combine the icon and message
  String toastMessage = '$msg';
  print("Toast message: $toastMessage"); // Debug print

  Fluttertoast.showToast(
    msg: toastMessage,
    toastLength: Toast.LENGTH_LONG, // Approximates 3 seconds
    gravity: ToastGravity.BOTTOM, // Position at the bottom (like SnackBarBehavior.fixed)
    timeInSecForIosWeb: 3, // Duration for iOS (3 seconds)
    backgroundColor: backgroundColor,
    textColor: AppColors.Color_FFFFFF,
    fontSize: 14.0,
    // Fluttertoast doesn't support padding or shape directly, but we can adjust the appearance
  );
  print("Fluttertoast.showToast called"); // Debug print
}

// void ShowSnackBar(BuildContext context, String title, String msg) {
//   int isSuccess = title == "Error" ? 0 : title == "Success" ? 1 : 2;
//   Color backgroundColor = isSuccess == 1
//       ? AppColors.color_7F0027
//       : isSuccess == 0
//       ? AppColors.color_7F0027
//       : AppColors.color_7F0027;
//
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Row(
//         children: [
//           Icon(
//             isSuccess == 1
//                 ? Icons.check_circle
//                 : isSuccess == 0
//                 ? Icons.error
//                 : Icons.warning_amber,
//             color: AppColors.color_FFFFFF,
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               msg,
//               style:  TextStyle(
//                 color: AppColors.color_FFFFFF,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: backgroundColor,
//       behavior: SnackBarBehavior.fixed,
//       padding: const EdgeInsets.all(15),
//       duration: const Duration(milliseconds: 3000),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//     ),
//   );
// }
// void ShowSnackBar(String title, String msg) {
//   int isSuccess = title == "Error" ? 0 : title == "Success" ? 1 : 2;
//   Color backgroundColor = isSuccess == 1
//       ? AppColors.color_7F0027
//       : isSuccess == 0
//       ? AppColors.color_7F0027
//       : AppColors.color_7F0027;
//
//   ScaffoldMessenger.of(Get.context).showSnackBar(
//     SnackBar(
//       content: Row(
//         children: [
//           Icon(
//             isSuccess == 1
//                 ? Icons.check_circle
//                 : isSuccess == 0
//                 ? Icons.error
//                 : Icons.warning_amber,
//             color: AppColors.color_FFFFFF,
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               msg,
//               style:  TextStyle(
//                 color: AppColors.color_FFFFFF,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: backgroundColor,
//       behavior: SnackBarBehavior.fixed,
//       padding: const EdgeInsets.all(15),
//       duration: const Duration(milliseconds: 3000),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//     ),
//   );
// }
