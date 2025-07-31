import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../const/color.dart';
import '../const/font_size.dart';
import '../network/network_helper.dart';
import '../network/app_url.dart';
import '../provider/authentication-provider/login_provider.dart';
import '../route/route_constants.dart';
import 'custom-button.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

/// Global Date Formatting Functions
/// 
/// Usage Examples:
/// 
/// // Format DateTime to "Month Day, Year"
/// DateTime date = DateTime(2025, 1, 15);
/// String formatted = formatToMonthDayYear(date);
/// // Result: "January 15, 2025"
/// 
/// // Format date string (DD/MM/YYYY) to "Month Day, Year"
/// String dateString = "15/01/2025";
/// String formatted = formatDateStringToMonthDayYear(dateString);
/// // Result: "January 15, 2025"
/// 
/// // Format to MM/DD/YYYY
/// String mmddyyyy = formatToMMDDYYYY(date);
/// // Result: "01/15/2025"
/// 
/// // Format date string to MM/DD/YYYY
/// String mmddyyyy = formatDateStringToMMDDYYYY("15/01/2025");
/// // Result: "01/15/2025"

// List of full month names
const List<String> fullMonths = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
];

// List of short month names
const List<String> shortMonths = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
];

/// Format DateTime to "Month Day, Year" (e.g., "January 15, 2025")
String formatToMonthDayYear(DateTime date) {
  String month = fullMonths[date.month - 1];
  String day = date.day.toString();
  String year = date.year.toString();
  
  return '$month $day, $year';
}

/// Format DateTime to "Short Month Day, Year" (e.g., "Jan 15, 2025")
String formatToShortMonthDayYear(DateTime date) {
  String month = shortMonths[date.month - 1];
  String day = date.day.toString();
  String year = date.year.toString();
  
  return '$month $day, $year';
}

/// Format DateTime to MM/DD/YYYY (e.g., "01/15/2025")
String formatToMMDDYYYY(DateTime date) {
  String month = date.month.toString().padLeft(2, '0');
  String day = date.day.toString().padLeft(2, '0');
  String year = date.year.toString();
  
  return '$month/$day/$year';
}

String formatToMMDDYYYYString(String dateString) {
  try {
    DateTime date = DateTime.parse(dateString);
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String year = date.year.toString();

    return '$month/$day/$year';
  } catch (e) {
    return 'Invalid date';
  }
}

/// Format DateTime to DD/MM/YYYY (e.g., "15/01/2025")
String formatToDDMMYYYY(DateTime date) {
  String day = date.day.toString().padLeft(2, '0');
  String month = date.month.toString().padLeft(2, '0');
  String year = date.year.toString();
  
  return '$day/$month/$year';
}

/// Format date string (DD/MM/YYYY) to "Month Day, Year"
String formatDateStringToMonthDayYear(String dateString) {
  try {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      
      DateTime date = DateTime(year, month, day);
      return formatToMonthDayYear(date);
    }
  } catch (e) {
    print('Error formatting date string: $e');
  }
  return dateString; // Return original if parsing fails
}

/// Format date string (DD/MM/YYYY) to "Short Month Day, Year"
String formatDateStringToShortMonthDayYear(String dateString) {
  try {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      
      DateTime date = DateTime(year, month, day);
      return formatToShortMonthDayYear(date);
    }
  } catch (e) {
    print('Error formatting date string: $e');
  }
  return dateString; // Return original if parsing fails
}

/// Format date string (DD/MM/YYYY) to MM/DD/YYYY
String formatDateStringToMMDDYYYY(String dateString) {
  try {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      
      DateTime date = DateTime(year, month, day);
      return formatToMMDDYYYY(date);
    }
  } catch (e) {
    print('Error formatting date string to MM/DD/YYYY: $e');
  }
  return dateString; // Return original if parsing fails
}

/// Parse date string (DD/MM/YYYY) to DateTime
DateTime? parseDateString(String dateString) {
  try {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      
      return DateTime(year, month, day);
    }
  } catch (e) {
    print('Error parsing date string: $e');
  }
  return null;
}

/// Format DateTime to API format (YYYY-MM-DD)
String formatToApiDate(DateTime date) {
  String year = date.year.toString();
  String month = date.month.toString().padLeft(2, '0');
  String day = date.day.toString().padLeft(2, '0');
  
  return '$year-$month-$day';
}

/// Format date string (DD/MM/YYYY) to API format (YYYY-MM-DD)
String formatDateStringToApiDate(String dateString) {
  try {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      
      return formatToApiDate(DateTime(year, month, day));
    }
  } catch (e) {
    print('Error formatting date string to API format: $e');
  }
  return dateString; // Return original if parsing fails
}

/// Get current date in "Month Day, Year" format
String getCurrentDateFormatted() {
  return formatToMonthDayYear(DateTime.now());
}

/// Get current date in MM/DD/YYYY format
String getCurrentDateMMDDYYYY() {
  return formatToMMDDYYYY(DateTime.now());
}

/// Get current date in short format
String getCurrentDateShortFormatted() {
  return formatToShortMonthDayYear(DateTime.now());
}

/// Check if date string is valid
bool isValidDateString(String dateString) {
  try {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      
      // Check if date is valid
      DateTime date = DateTime(year, month, day);
      return date.year == year && date.month == month && date.day == day;
    }
  } catch (e) {
    return false;
  }
  return false;
}

/// Get age from birth date
int calculateAge(DateTime birthDate) {
  DateTime now = DateTime.now();
  int age = now.year - birthDate.year;
  if (now.month < birthDate.month || 
      (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }
  return age;
}

/// Get age from birth date string (DD/MM/YYYY)
int? calculateAgeFromString(String birthDateString) {
  DateTime? birthDate = parseDateString(birthDateString);
  if (birthDate != null) {
    return calculateAge(birthDate);
  }
  return null;
}


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

/// Dio-based multipart function for travel documents
/// This function handles multipart requests using Dio instead of http
/// 
/// Parameters:
/// - context: BuildContext for UI operations
/// - url: API endpoint URL
/// - fieldData: Map containing form fields (JSON data)
/// - fileList: List of file information maps
/// - showLoading: Whether to show loading indicator
/// 
/// Returns: Map<String, dynamic> containing API response
/// 
/// Usage Example:
/// ```dart
/// Map<String, dynamic> fieldData = {
///   'data': jsonEncode([yourDataObject]),
/// };
/// 
/// List<Map<String, dynamic>> fileList = [
///   {
///     'fieldName': 'passportDocument',
///     'filePath': '/path/to/file.pdf',
///     'fileName': 'document.pdf',
///   }
/// ];
/// 
/// final response = await multipartTravelDocumentsDio(
///   context,
///   createOrUpdateTravelDocuments,
///   fieldData,
///   fileList,
///   true,
/// );
/// ```
Future<Map<String, dynamic>> multipartDocumentsDio(BuildContext context, String url, Map<String, dynamic> fieldData, List<Map<String, dynamic>> fileList, bool showLoading) async {
  try {
    var dio = Dio();
    var headers = {
      'Authorization': 'Bearer ${NetworkHelper.token}',
      'Accept': 'application/json',
      'Language': 'en'
    };

    var formData = FormData.fromMap(fieldData);

    // Add files to form data
    for (var fileInfo in fileList) {
      String fieldName = fileInfo['fieldName'];
      String filePath = fileInfo['filePath'];
      String fileName = fileInfo['fileName'];
      String? mimeType = fileInfo['mimeType'];

      if (mimeType != null) {
        formData.files.add(
          MapEntry(
            fieldName,
            await MultipartFile.fromFile(
              filePath,
              filename: fileName,
              contentType: MediaType.parse(mimeType),
            ),
          ),
        );
      } else {
        formData.files.add(
          MapEntry(
            fieldName,
            await MultipartFile.fromFile(
              filePath,
              filename: fileName,
            ),
          ),
        );
      }
    }

    print("Travel Documents Dio Request URL: $url");
    print("Travel Documents Dio Request Headers: $headers");
    print("Travel Documents Dio Request Fields: ${formData.fields}");
    print("Travel Documents Dio Request Files: ${formData.files.map((file) => file.value.filename).toList()}");

    var response = await dio.post(
      url,
      data: formData,
      options: Options(
        headers: headers,
        contentType: 'multipart/form-data',
      ),
    );

    print("Travel Documents Dio Response Status: ${response.statusCode}");
    print("Travel Documents Dio Response: ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      ShowToast("Success", response.data['message'] ?? "Travel documents saved successfully");
      return response.data;
    } else {
      ShowToast("Error", response.data['message'] ?? "Failed to save travel documents");
      return response.data;
    }
  } on DioException catch (e) {
    print("Travel Documents Dio Error: ${e.message}");
    print("Travel Documents Dio Error Type: ${e.type}");
    print("Travel Documents Dio Error Response: ${e.response?.data}");

    if (e.response?.statusCode == 401) {
      ShowToast("Error", "Session expired. Please log in again.");
      var loginProvider = Provider.of<LoginProvider>(context, listen: false);
      await loginProvider.clearStoredLoginData();
      NetworkHelper().removeToken(context);
      Navigator.of(context).pushReplacementNamed(login);
      return e.response?.data ?? {};
    } else if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
      ShowToast("Error", e.response?.data['message'] ?? "Bad request");
      return e.response?.data ?? {};
    } else if (e.response?.statusCode == 403) {
      ShowToast("Error", e.response?.data['message'] ?? "Access forbidden");
      return e.response?.data ?? {};
    } else if (e.response?.statusCode == 500) {
      ShowToast("Error", e.response?.data['message'] ?? "Internal server error");
      return e.response?.data ?? {};
    } else {
      ShowToast("Error", e.response?.data['message'] ?? "Something went wrong");
      return e.response?.data ?? {};
    }
  } catch (e) {
    ShowToast("Error", "Something went wrong: $e");
    return {};
  }
}

