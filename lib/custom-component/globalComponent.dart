import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../const/color.dart';
import '../const/font_size.dart';
import '../network/network_helper.dart';
import 'custom-button.dart';


Future<bool> checkPermission(BuildContext context) async {
  print("Inside checkPermission at ${DateTime.now()}");

  try {
    // Request both camera and storage permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage, // For gallery access on Android < 10
      Permission.photos,  // For gallery access on iOS and Android 10+
    ].request();

    // Get individual statuses
    PermissionStatus cameraStatus = statuses[Permission.camera] ?? PermissionStatus.denied;
    PermissionStatus storageStatus = statuses[Permission.storage] ?? PermissionStatus.denied;
    PermissionStatus photosStatus = statuses[Permission.photos] ?? PermissionStatus.denied;

    print("Permission statuses - Camera: $cameraStatus, Storage: $storageStatus, Photos: $photosStatus");

    // Check if all required permissions are granted
    if (cameraStatus.isGranted && (storageStatus.isGranted || photosStatus.isGranted)) {
      print("All required permissions granted");
      return true; // Both camera and at least one storage permission granted
    } else if (cameraStatus.isPermanentlyDenied || storageStatus.isPermanentlyDenied || photosStatus.isPermanentlyDenied) {
      // Open app settings if any permission is permanently denied
      print("Some permissions are permanently denied");
      if (context.mounted) {
        showPermissionDialog(context); // Assuming this function exists to show a dialog
      } else {
        print("Context not mounted, unable to show permission dialog");
      }
      return false;
    } else if (cameraStatus.isDenied || storageStatus.isDenied || photosStatus.isDenied) {
      // Permissions denied but not permanently; request again or inform user
      print('Some permissions denied. Requesting again...');
      statuses = await [
        Permission.camera,
        Permission.storage,
        Permission.photos,
      ].request();

      cameraStatus = statuses[Permission.camera] ?? PermissionStatus.denied;
      storageStatus = statuses[Permission.storage] ?? PermissionStatus.denied;
      photosStatus = statuses[Permission.photos] ?? PermissionStatus.denied;

      if (cameraStatus.isGranted && (storageStatus.isGranted || photosStatus.isGranted)) {
        print("Permissions granted after second attempt");
        return true;
      } else {
        print("Permissions still denied after second attempt");
        if (context.mounted) {
          ShowToast("Warning", "Please allow camera and storage permissions to proceed.");
        }
        return false;
      }
    }
  } catch (e) {
    print('Error checking permission: $e at ${DateTime.now()}');
    if (context.mounted) {
      ShowToast("Error", "Failed to check permissions: $e");
    } else {
      print("Context not mounted, unable to show toast for error");
    }
    return false;
  }

  return false; // Default return (should not reach here due to exhaustive checks)
}

showPermissionDialog(
    BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.Color_212121),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.only(
                    top: 2.h, left: 1.5.w, right: 2.5.w, bottom: 3.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Common/settings.png',height: 10.h,color: AppColors.Color_212121,),
                    SizedBox(height: 2.h,),
                    Container(
                      width: 80.w,
                      child: Text(
                        "This app needs Camera and Storage permission to work properly. Please enable it from settings.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.Color_212121,
                          fontWeight: FontWeight.w500,
                          fontSize:AppFontSize.fontSize15,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w).copyWith(right: 8.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 28.w,
                                child: customButton(
                                  voidCallback: () {
                                    Navigator.of(context).pop();
                                  },
                                  fontSize: AppFontSize.fontSize16,
                                  useGradient: false,
                                  buttonText: "Cancel",
                                  width: 28.w,
                                  height: 4.5.h,
                                  color: AppColors.Color_212121,
                                  shadowColor: AppColors.Color_FFFFFF,
                                  buttonTextColor: AppColors.Color_FFFFFF,
                                  useBorder: false,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 25.w,
                                child: customButton(
                                  voidCallback: ()  async {
                                    Navigator.of(context).pop();
                                    if (context.mounted) {
                                      await openAppSettings();

                                    }

                                  },
                                  fontSize: AppFontSize.fontSize16,
                                  useGradient: true,
                                  buttonText: "Open",
                                  width: 25.w,
                                  height: 4.5.h,
                                  color: AppColors.Color_212121,
                                  shadowColor: AppColors.Color_FFFFFF,
                                  buttonTextColor: AppColors.Color_FFFFFF,
                                  useBorder: false,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

