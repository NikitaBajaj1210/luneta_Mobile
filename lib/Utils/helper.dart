import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luneta/const/color.dart';

class Helper{
  static bool isLoading = false;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static bool shouldNavigateToNext = true;
  static bool isSalesChatActive = false;
  static bool isGroupChatActive = false;
  static bool isAdminChatActive = false;
  static bool isAdminGroupChatActive = false;
}
//
Future<void> startLoading(BuildContext context) async {
  if(!Helper.isLoading) {
    Helper.isLoading = true;
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(color: AppColors.Color_607D8B),
              )
            ],
          ),
        );
      },
    );
  }
}
//
Future<void> stopLoading(BuildContext context) async {
  if(Helper.isLoading) {
    Helper.isLoading = false;
    Navigator.of(context).pop();
  }
}
//
void showToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.Color_607D8B,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 13
  );
}

// void setStatusBarColor(bool IsIconDark){
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: AppColors.white_statusBar,
//       statusBarIconBrightness: IsIconDark?Brightness.dark:Brightness.light
//   ));
// }
//
// String capitalizeFirstLetter(String input) {
//   if (input.isEmpty) {
//     return input;
//   }
//
//   return "${input[0].toUpperCase()}${input.substring(1)}";
// }
