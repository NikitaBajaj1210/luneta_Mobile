import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/color.dart';
class NetworkHelper{
  static String loggedInUserId='';
  // static String loggedInUserEmail='';
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



  removeToken(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    NetworkHelper.token = '';
    NetworkHelper.refreshToken = '';
    NetworkHelper.loggedInUserId='';
    // NetworkHelper.loggedInUserEmail='';
    NetworkHelper.isLoggedIn=false;
    // prefs.remove(isLoggedInKey);
    // prefs.remove(userIdKey);
    // prefs.remove(userRoleKey);
    // prefs.remove(accessTokenKey);
    // prefs.remove(refreshTokenKey);
    // if(Provider.of<LoginProvider>(context,listen: false).isCheckboxChecked==false){
    //   prefs.remove(userMobileNumberKey);
    //   prefs.remove(userPasswordKey);
    //   prefs.remove(rememberMeKey);
    // }
  }

  Map<String, dynamic> decodeToken(String token) {
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
