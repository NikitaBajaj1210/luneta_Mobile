import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Utils/helper.dart';
import '../route/route_constants.dart';
import 'app_url.dart';
import 'network_helper.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
class NetworkService {
  static int loading = 0;

  // loading 0 => InScreen loader
  // loading 1 => Tap to try again
  // loading 2 => screen main content

  Future<bool> refreshToken(BuildContext context) async {
    //   try {
    //     var data = {
    //       "refreshToken": NetworkHelper.refreshToken,
    //     };
    //     var body = jsonEncode(data);
    //     Map<String, dynamic> response = await NetworkService()
    //         .postResponse(refreshTokenUrl, body, true, context, () {});
    //     final refreshToken = RefreshTokenModel.fromJson(response);
    //     if (refreshToken.statusCode == 200) {
    //       NetworkHelper.token = refreshToken.data!.accessToken!;
    //
    //       // loggedInUserId
    //       // SharedPreferences prefs = await SharedPreferences.getInstance();
    //       // prefs.setString('access_token', NetworkHelper.token);
    //       NetworkHelper.header = {
    //         "Content-Type": "application/json",
    //         "Authorization": "Bearer ${NetworkHelper.token}",
    //       };
    return true;
    //     } else {
    //       return false;
    //     }
    //   } catch (error) {
    //     ShowSnackBar("Error", 'something_went_wrong'.tr);
    //     return false;
    //   }
  }

  // Future<Map<String, dynamic>> postResponse(
  //     String urlPath,
  //     Object? data,
  //     bool showLoading,
  //     BuildContext context,
  //     VoidCallback notify,
  //     {bool isShowWarning = true}) async {
  //   loading = 0;
  //   notify();
  //   if (showLoading && context.mounted) startLoading(context);
  //
  //   try {
  //     var header = {
  //       "Content-Type": "application/json",
  //       "Accept": "application/json",
  //       "Language": "en"
  //     };
  //
  //     print("Request URL: $urlPath");
  //     print("Request Body: $data");
  //
  //     var response = await http.post(
  //       Uri.parse(urlPath),
  //       headers: urlPath == signupUrl ? header : NetworkHelper.header,
  //       body: data,
  //     );
  //
  //     print("HTTP Status Code: ${response.statusCode}");
  //     print("Response Body: ${response.body}");
  //
  //     var res = jsonDecode(response.body);
  //     print("Decoded Response: $res");
  //
  //     // Check HTTP status code first
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // Check the responseCode in the body for errors
  //       if (res['statusCode'] != null && res['statusCode'] == 400) {
  //         loading = 2;
  //         if (showLoading && context.mounted) stopLoading(context);
  //         if (context.mounted) {
  //           ShowToast( "Error", res['message'] ?? "An error occurred");
  //         }
  //         return res; // Return the error response for further handling
  //       }
  //       // Success case
  //       loading = 2;
  //       if (showLoading && context.mounted) stopLoading(context);
  //       return res;
  //     } else if (res['statusCode'] == 400 || res['statusCode'] == 404 || res['statusCode'] == 403) {
  //       loading = 2;
  //       if (showLoading && context.mounted) stopLoading(context);
  //       print(res['message'].toString());
  //       if (context.mounted) {
  //         ShowToast( "Error", res['message'] ?? "An error occurred");
  //       }
  //       return res;
  //     } else if (res['statusCode'] == 401) {
  //       bool tokenRefreshed = await refreshToken(context);
  //       if (tokenRefreshed) {
  //         return await postResponse(urlPath, data, showLoading, context, notify);
  //       } else {
  //         if (isShowWarning && context.mounted) {
  //           ShowToast( "Error", "Session expired");
  //         }
  //         NetworkHelper().removeToken(context);
  //         if (context.mounted) {
  //           Navigator.of(context).pushReplacementNamed(login);
  //         }
  //         return {};
  //       }
  //     } else if (res['statusCode'] == 500) {
  //       loading = 1;
  //       if (showLoading && context.mounted) stopLoading(context);
  //       if (context.mounted) {
  //         ShowToast( "Error", res['message'] ?? "Server error");
  //       }
  //       notify();
  //       return {};
  //     } else if (res['statusCode'] == 409) {
  //       loading = 1;
  //       if (showLoading && context.mounted) stopLoading(context);
  //       if (context.mounted) {
  //         ShowToast( "Error", "Record already exists");
  //       }
  //       notify();
  //       return {};
  //     } else {
  //       loading = 1;
  //       if (showLoading && context.mounted) stopLoading(context);
  //       if (context.mounted) {
  //         ShowToast( "Error", "Something went wrong (Status: ${response.statusCode})");
  //       }
  //       notify();
  //       return {};
  //     }
  //   } on SocketException {
  //     loading = 1;
  //     if (showLoading && context.mounted) stopLoading(context);
  //     if (context.mounted) {
  //       ShowToast("Error", "Check your internet connection");
  //     }
  //     notify();
  //     return {};
  //   } catch (e) {
  //     loading = 1;
  //     if (showLoading && context.mounted) stopLoading(context);
  //     print("Error in postResponse: $e");
  //     if (context.mounted) {
  //       ShowToast( "Error", "Something went wrong: $e");
  //     }
  //     notify();
  //     return {};
  //   }
  // }

  Future<Map<String, dynamic>> postResponse(
      String urlPath,
      Object? data,
      bool showLoading,
      BuildContext context,
      VoidCallback notify,
      {bool isShowWarning = true}) async {
    loading = 0;
    notify();
    if (showLoading && context.mounted) startLoading(context);

    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      print("Request URL: $urlPath");
      print("Request Body: $data");

      var response = await http.post(
        Uri.parse(urlPath),
        headers: urlPath == signupUrl ? header : NetworkHelper.header,
        body: data,
      );

      print("HTTP Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      var res = jsonDecode(response.body);
      print("Decoded Response: $res");
      print("response------------>>> $res"); // Extra debug log

      // Check HTTP status code first
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Check the responseCode in the body for errors
        if (res['statusCode'] != null && res['statusCode'] == 400) {
          loading = 2;
          if (showLoading && context.mounted) stopLoading(context);
          if (context.mounted) {
            ShowToast("Error", res['message'] ?? "An error occurred");
          }
          return res;
        } else if (res['statusCode'] != null && res['statusCode'] == 404) {
          loading = 2;
          if (showLoading && context.mounted) stopLoading(context);
          if (context.mounted) {
            ShowToast("Error", res['message'] ?? "An error occurred");
          }
          return res;
        } else if (res['statusCode'] != null && res['statusCode'] == 401) {
          loading = 2;
          if (showLoading && context.mounted) stopLoading(context);
          String errorMessage = res['message'] ?? "An error occurred (Status: ${res['statusCode']})";
          print("Error Message to Show: $errorMessage"); // Debug log
          print("About to show toast for 401 error"); // Debug print
          if (context.mounted) {
            ShowToast("Error", errorMessage);
          }
          return res;
        }
        // Success case
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        return res;
      } else if (response.statusCode == 401) {
        bool tokenRefreshed = await refreshToken(context);
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        String errorMessage = res['message'] ?? "An error occurred (Status: ${res['statusCode']})";
        print("Error Message to Show: $errorMessage"); // Debug log
        if (context.mounted) {
          ShowToast("Error", errorMessage);
        }
        return res;
      } else if (response.statusCode == 500) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        if (context.mounted) {
          ShowToast("Error", res['message'] ?? "Server error");
        }
        notify();
        return {};
      } else if (response.statusCode == 409) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        if (context.mounted) {
          ShowToast("Error", "Record already exists");
        }
        notify();
        return {};
      } else {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        if (context.mounted) {
          ShowToast("Error", "Something went wrong (Status: ${response.statusCode})");
        }
        notify();
        return {};
      }
    } on SocketException {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      if (context.mounted) {
        ShowToast("Error", "Check your internet connection");
      }
      notify();
      return {};
    } catch (e) {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      print("Error in postResponse: $e");
      if (context.mounted) {
        ShowToast("Error", "Something went wrong: $e");
      }
      notify();
      return {};
    }
  }

  Future postCreateResponse(String urlPath, Object? data, bool showLoading,
      BuildContext context, VoidCallback notify) async {
    loading = 0;
    notify();
    if (showLoading && context.mounted) startLoading(context);

    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Language": "en"
      };

      var response = await post(
        Uri.parse(urlPath),
        headers: urlPath == signupUrl ? header : NetworkHelper.header,
        body: data,
      );

      var res = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        return res;
      } else if (response.statusCode == 400 ||
          response.statusCode == 404 ||
          response.statusCode == 403) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message']);
        return res;
      } else if (response.statusCode == 401) {
        bool tokenRefreshed = await refreshToken(context);
        // if (tokenRefreshed == true) {
        //   // if(res['status']==200||res['statusCode']==200){
        //   // if(res['detail']=='Given token not valid for any token type'){
        //
        //   // Retry the original request with the new token
        //   return await getList(urlPath, showLoading, context, notify);
        //   // }
        // } else {
          // ShowSnackBar("Error", 'Session_expired'.tr);
          NetworkHelper().removeToken(context);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            // Provider.of<LoginProvider>(context, listen: false).getEmail();
          });
          Navigator.of(context).pushReplacementNamed(login);
        // }
      } else if (response.statusCode == 409) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", 'Record already exist');
        notify();
      }else if (response.statusCode == 500) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message']);
        notify();
      } else {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", 'something went wrong');
        notify();
      }
    } on SocketException {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'check your internet connection');
      notify();
    } catch (e) {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'something went wrong');
      notify();
    }

    return {};
  }

  Future<Map<String, dynamic>> putResponse(String urlPath, Object? data,
      bool showLoading, BuildContext context, VoidCallback notify) async {
    loading = 0;
    notify();
    if (showLoading && context.mounted) startLoading(context);

    try {
      var request = http.Request('PUT', Uri.parse(urlPath));
      request.body = jsonEncode(data);
      request.headers.addAll(NetworkHelper.header);

      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();

      if (res.isEmpty) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", 'Empty response from server');
        return {};
      }

      print(res);
      var resJson = jsonDecode(res);

      if (response.statusCode == 200 || response.statusCode == 201) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        return resJson;
      } else if (response.statusCode == 400 ||
          response.statusCode == 404 ||
          response.statusCode == 403) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", resJson['message'] ?? 'Error');
        return resJson;
      } else if (response.statusCode == 401) {
        NetworkHelper().removeToken(context);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // Provider.of<LoginProvider>(context, listen: false).getEmail();
        });
        Navigator.of(context).pushReplacementNamed(login);

      }else if(response.statusCode == 500){
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error",resJson['message']);
        notify();
      } else if (response.statusCode == 409) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", 'Record already exist');
        notify();
      } else {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", 'something went wrong');
        notify();
      }
    } on SocketException {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'check your internet connection');
      notify();
    } catch (e) {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'something went wrong');
      notify();
    }

    return {};
  }

  Future getResponse(String urlPath, bool showLoading, BuildContext context,
      VoidCallback notify) async {
    loading = 0;
    notify();

    if (showLoading && context.mounted) startLoading(context);

    try {
      var response = await get(
        Uri.parse(urlPath),
        headers: NetworkHelper.header,
      );
      print(urlPath);
      print(response.statusCode);
      print(response.body);
      var res = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        return res;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        if(response.statusCode == 404 ){
          ShowToast("Error", res['message']);
        }
        return res;
      } else if (response.statusCode == 401) {
        NetworkHelper().removeToken(context);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // Provider.of<LoginProvider>(context, listen: false).getEmail();
        });
        Navigator.of(context).pushReplacementNamed(login);

      }else if(response.statusCode == 500){
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error",res['message']);
        notify();
      } else {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message']);
        notify();
      }
    } on SocketException {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'check your internet connection');
      notify();
    } catch (e) {
      print(e);
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'something went wrong');
      notify();
    }

    return {};
  }


  Future getResponsePage(String urlPath, bool showLoading, BuildContext context,
      VoidCallback notify) async {
    loading = 0;
    notify();

    if (showLoading && context.mounted) startLoading(context);

    try {
      var response = await get(
        Uri.parse(urlPath),
        headers: NetworkHelper.header,
      );

      var res = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        return res;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        if(response.statusCode == 404 ){
            ShowToast("Error", res['message']);
        }

        return res;
      } else if (response.statusCode == 401) {
        if (showLoading && context.mounted) stopLoading(context);


        bool tokenRefreshed = await refreshToken(context);

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // Provider.of<LoginProvider>(context, listen: false).getEmail();
        });
        ShowToast("Error",res['message']);
        NetworkHelper().removeToken(context);
        Navigator.of(context).pushReplacementNamed(login);
        if (tokenRefreshed == true) {
          // if(res['status']==200||res['statusCode']==200){
          // if(res['detail']=='Given token not valid for any token type'){

          notify();
          // Retry the original request with the new token
          return {};
          // }
        }else if(response.statusCode == 500){
          loading = 1;
          if (showLoading && context.mounted) stopLoading(context);
          ShowToast("Error",res['message']);
          notify();
        } else {
          // ShowSnackBar("Error", 'Session_expired'.tr);
          NetworkHelper().removeToken(context);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            // Provider.of<LoginProvider>(context, listen: false).getEmail();
          });
          Navigator.of(context).pushReplacementNamed(login);
        }
      } else {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message']);
        notify();
      }
    } on SocketException {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'check your internet connection');
      notify();
    } catch (e) {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'something went wrong');
      notify();
    }

    return {};
  }


  Future<List> getList(
      String urlPath,
      bool showLoading,
      BuildContext context,
      VoidCallback notify,
      ) async {
    loading = 0;
    notify();

    if (showLoading && context.mounted) startLoading(context);

    try {
      var response = await get(
        Uri.parse(urlPath),
        headers: NetworkHelper.header,
      );
      print(NetworkHelper.token);
      var res = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        return res['data'];
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        var res = jsonDecode(response.body);
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message']);
        return [];
      } else if (response.statusCode == 401) {
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error",res['message']);
        NetworkHelper().removeToken(context);
        Navigator.of(context).pushReplacementNamed(login);
      }else if(response.statusCode == 500){
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error",res['message']);
        notify();
      }else {
        var res = jsonDecode(response.body);
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message']);
        notify();
      }
    } on SocketException {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'check_your internet connection');
      notify();
    } catch (e) {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'something went wrong');
      print(e.toString());
      notify();
    }

    return [];
  }

  Future<Map<String, dynamic>> getAuctionList(
      String urlPath,
      bool showLoading,
      BuildContext context,
      VoidCallback notify,
      ) async {
    loading = 0;
    notify();

    if (showLoading && context.mounted) startLoading(context);

    try {
      var response = await get(
        Uri.parse(urlPath),
        headers: NetworkHelper.header,
      );
      var res = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        return res; // Return the entire response
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        var res = jsonDecode(response.body);
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message']);
        return {};
      }else if(response.statusCode == 500){
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error",res['message']);
        notify();
      }else if(response.statusCode == 401) {
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error",res['message']);
        NetworkHelper().removeToken(context);
        Navigator.of(context).pushReplacementNamed(login);

      }else {
        var res = jsonDecode(response.body);
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message']);
        notify();
      }
    } on SocketException {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'check your internet connection');
      notify();
    } catch (e) {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'something went wrong');
      print(e.toString());
      notify();
    }

    return {};
  }




//   Delete

  Future<dynamic> deleteResponse(String urlPath, bool showLoading, BuildContext context, VoidCallback notify) async {
    loading = 0;
    notify();

    if (showLoading && context.mounted) startLoading(context);

    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var response = await delete(
        Uri.parse(urlPath),
        headers: urlPath == loginUrl || urlPath == signupUrl
            ? header : NetworkHelper.header,
      );
      var res = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        return res;
      } else if (response.statusCode == 400 || response.statusCode == 404 || response.statusCode == 403) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        // showToast('Something went wrong, Please try again');
        ShowToast("Error",res['message']);
        return res;
      } else if (response.statusCode == 401) {
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error",res['message']);
        NetworkHelper().removeToken(context);
        Navigator.of(context).pushReplacementNamed(login);
      }else if (response.statusCode == 500) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message']);
        notify();
      } else {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error",'Something went wrong, Please try again');
        notify();
      }
    } on SocketException {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error",'Please check your internet connection');
      notify();
    } catch (e) {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error",'Something went wrong, Please try again');
      notify();
    }

    return {};
  }



  Future<Map<String, dynamic>> patchResponse(String urlPath, Object? data,
      bool showLoading, BuildContext context, VoidCallback notify) async {
    loading = 0;
    notify();
    if (showLoading && context.mounted) startLoading(context);

    try {
      var request = http.Request('PATCH', Uri.parse(urlPath));
      request.body = jsonEncode(data);
      request.headers.addAll(NetworkHelper.header);

      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();

      if (res.isEmpty) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", 'Empty response from server');
        return {};
      }

      print(res);
      var resJson = jsonDecode(res);

      if (response.statusCode == 200 || response.statusCode == 201) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        return resJson;
      } else if (response.statusCode == 400 ||
          response.statusCode == 404 ||
          response.statusCode == 403) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", resJson['message'] ?? 'Error');
        return resJson;
      } else if (response.statusCode == 401) {
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", resJson['message'] ?? 'Error');
        NetworkHelper().removeToken(context);
        Navigator.of(context).pushReplacementNamed(login);
      } else if (response.statusCode == 409) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", 'Record already exist');
        notify();
      }else if (response.statusCode == 500) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", resJson['message']);
        notify();
      }else {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", 'something went wrong');
        notify();
      }
    } on SocketException {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'check your internet connection');
      notify();
    } catch (e) {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", 'something went wrong');
      notify();
    }

    return {};
  }

  // Future<bool> Post_Multipart_Single(BuildContext context, Map<String, dynamic> formFields, String url) async {
  //   try {
  //     if (context.mounted) startLoading(context);
  //
  //     var headers = {
  //       'Content-Type': 'multipart/form-data',
  //       'Authorization': 'Bearer ${NetworkHelper.token}'
  //     };
  //
  //     var request = http.MultipartRequest('POST', Uri.parse(url));
  //
  //     // Separate text fields and files from formFields
  //     List<http.MultipartFile> files = [];
  //     Map<String, String> textFields = {};
  //
  //     formFields.forEach((key, value) {
  //       if (key == 'files' && value is List) {
  //         // Handle the 'files' key as a list of MultipartFile
  //         files.addAll(value.cast<http.MultipartFile>());
  //       } else if (value is http.MultipartFile) {
  //         files.add(value);
  //       } else {
  //         textFields[key] = value.toString();
  //       }
  //     });
  //
  //     // Add text fields to the request
  //     request.fields.addAll(textFields);
  //
  //     // Add files to the request
  //     request.files.addAll(files);
  //
  //     request.headers.addAll(headers);
  //
  //     print("Multipart Request URL: $url");
  //     print("Text Fields: $textFields");
  //     print("Files: ${files.map((file) => file.filename).toList()}");
  //
  //     var response = await request.send();
  //     var responseBody = await response.stream.bytesToString();
  //
  //     print("Response Status: ${response.statusCode}");
  //     print("Response Body: $responseBody");
  //
  //     // Check if responseBody is empty or not JSON
  //     if (responseBody.isEmpty) {
  //       if (context.mounted) stopLoading(context);
  //       ShowToast( "Error", "Empty response from server");
  //       return false;
  //     }
  //
  //     var res;
  //     try {
  //       res = jsonDecode(responseBody);
  //     } catch (e) {
  //       if (context.mounted) stopLoading(context);
  //       ShowToast( "Error", "Invalid response format: $responseBody");
  //       return false;
  //     }
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       ShowToast( "Success", res['message'] ?? "Profile updated successfully");
  //       if (context.mounted) stopLoading(context);
  //       return true;
  //     } else if (response.statusCode == 400 || response.statusCode == 404) {
  //       if (context.mounted) stopLoading(context);
  //       ShowToast( "Error", res['message'] ?? "Bad request");
  //       return false;
  //     } else if (response.statusCode == 401) {
  //       ShowToast( "Error", res['message'] ?? "Session expired");
  //       if (context.mounted) stopLoading(context);
  //       NetworkHelper().removeToken(context);
  //       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //         // Provider.of<LoginProvider>(context, listen: false).loginInit();
  //       });
  //       Navigator.of(context).pushReplacementNamed(login);
  //       return false;
  //     } else {
  //       if (context.mounted) stopLoading(context);
  //       ShowToast( "Error", res['message'] ?? "Something went wrong");
  //       return false;
  //     }
  //   } catch (e) {
  //     if (context.mounted) stopLoading(context);
  //     ShowToast( "Error", "Something went wrong: $e");
  //     return false;
  //   }
  // }
  Future<Map<String, dynamic>> multipartResponseSurvey(BuildContext context, String url, Map<String, String> fieldData, List<MultipartFile> fileList) async {
    try {
      var headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${NetworkHelper.token}'
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(fieldData);
      request.files.addAll(fileList);
      request.headers.addAll(headers);

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var res = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        return res;
      } else if (response.statusCode == 204) {
        return {'statusCode': 204};
      } else if (response.statusCode == 401) {
        ShowToast("Error",res['message']);
        NetworkHelper().removeToken(context);
        Navigator.of(context).pushReplacementNamed(login);
      }
    } on SocketException {
      showToast('Please check your internet connection');
      return {'statusCode': 503};
    } catch (e) {}
    return {};
  }

  Future<Map<String, dynamic>> multipartSeafarerProfile(BuildContext context, String url, Map<String, String> fieldData, List<http.MultipartFile> fileList, bool showLoading, VoidCallback notify) async {
    loading = 0;
    if (showLoading && context.mounted) startLoading(context);

    try {
      var headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Language': 'en'
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(fieldData);
      request.files.addAll(fileList);
      request.headers.addAll(headers);

      print("Multipart Request URL: $url");
      print("Text Fields: $fieldData");
      print("Files: ${fileList.map((file) => file.filename).toList()}");

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Response Status: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (responseBody.isEmpty) {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", "Empty response from server");
        return {};
      }

      var res = jsonDecode(responseBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        return res;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message'] ?? "Bad request");
        return res;
      } else if (response.statusCode == 401) {
        loading = 2;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message'] ?? "Session expired");
        NetworkHelper().removeToken(context);
        Navigator.of(context).pushReplacementNamed(login);
        return res;
      } else {
        loading = 1;
        if (showLoading && context.mounted) stopLoading(context);
        ShowToast("Error", res['message'] ?? "Something went wrong");
        return res;
      }
    } on SocketException {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", "Check your internet connection");
      return {};
    } catch (e) {
      loading = 1;
      if (showLoading && context.mounted) stopLoading(context);
      ShowToast("Error", "Something went wrong: $e");
      return {};
    }
  }
}

