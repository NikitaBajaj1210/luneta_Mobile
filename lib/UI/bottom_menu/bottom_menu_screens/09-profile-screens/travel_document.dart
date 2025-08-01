import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:search_choices/search_choices.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/travel_document_provider.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../custom-component/custom-button.dart';
import '../../../../network/network_helper.dart';
import '../../../../network/network_services.dart';

class TravelDocumentScreen extends StatefulWidget {
  const TravelDocumentScreen({super.key});

  @override
  State<TravelDocumentScreen> createState() => _TravelDocumentScreenState();
}

class _TravelDocumentScreenState extends State<TravelDocumentScreen> {
  @override
  void initState() {
    super.initState();
    // Call API to fetch travel document data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<TravelDocumentProvider>(context, listen: false);
      
      // Reset form before fetching data
      provider.resetForm();
      
      // Get userId from NetworkHelper or use the hardcoded one for testing
      String userId = NetworkHelper.loggedInUserId.isNotEmpty

          ? NetworkHelper.loggedInUserId 
          :'';
      print("LOGIN USER ID IN THE SCREEN ${NetworkHelper.loggedInUserId}");
      provider.fetchTravelDocuments(userId, context);
    });
  }

  Future<void> _handleSaveButton(TravelDocumentProvider provider) async {
    if (provider.formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            ),
          );
        },
      );

      // Reset form before API call
      provider.resetForm();
      
      // Call the create/update API
      bool success = await provider.createOrUpdateTravelDocumentsAPI(context);
      
      // Hide loading indicator
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      // if (success) {
      //   // Show success message
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Travel documents saved successfully!'),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      //   Navigator.pop(context);
      // } else {
      //   // Show error message
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text(provider.errorMessage),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      // }
    } else {
      setState(() {
        provider.autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TravelDocumentProvider>(
      builder: (context, provider, child) {
        // Show loading indicator
        // if (provider.isLoading) {
        //   return SafeArea(
        //     child: Scaffold(
        //       backgroundColor: AppColors.Color_FFFFFF,
        //       body: Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             CircularProgressIndicator(
        //               color: AppColors.buttonColor,
        //             ),
        //             SizedBox(height: 2.h),
        //             Text(
        //               'Loading travel documents...',
        //               style: TextStyle(
        //                 fontSize: AppFontSize.fontSize16,
        //                 color: AppColors.Color_424242,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   );
        // }

        // Show error message
        // if (provider.hasError) {
        //   return SafeArea(
        //     child: Scaffold(
        //       backgroundColor: AppColors.Color_FFFFFF,
        //       body: Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Icon(
        //               Icons.error_outline,
        //               size: 60,
        //               color: Colors.red,
        //             ),
        //             SizedBox(height: 2.h),
        //             Text(
        //               'Error loading travel documents',
        //               style: TextStyle(
        //                 fontSize: AppFontSize.fontSize18,
        //                 fontWeight: FontWeight.bold,
        //                 color: AppColors.Color_424242,
        //               ),
        //             ),
        //             SizedBox(height: 1.h),
        //             Text(
        //               provider.errorMessage,
        //               style: TextStyle(
        //                 fontSize: AppFontSize.fontSize14,
        //                 color: AppColors.Color_616161,
        //               ),
        //               textAlign: TextAlign.center,
        //             ),
        //             SizedBox(height: 3.h),
        //             ElevatedButton(
        //               onPressed: () {
        //                 String userId = NetworkHelper.loggedInUserId.isNotEmpty
        //                     ? NetworkHelper.loggedInUserId
        //                     : '510aa1e9-32e9-44ab-8b94-7d942c89d3e6';
        //                 provider.fetchTravelDocuments(userId,context);
        //               },
        //               style: ElevatedButton.styleFrom(
        //                 backgroundColor: AppColors.buttonColor,
        //                 padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        //               ),
        //               child: Text(
        //                 'Retry',
        //                 style: TextStyle(
        //                   color: AppColors.buttonTextWhiteColor,
        //                   fontSize: AppFontSize.fontSize16,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   );
        // }

        return SafeArea(
          child:  Container(
            height: 100.h,
            width: 100.w,
            color: AppColors.Color_FFFFFF,
            child: NetworkService.loading == 0 ? Center(
              child: CircularProgressIndicator(color: AppColors.Color_607D8B),
            ) :
            NetworkService.loading == 1 ? Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    NetworkService.loading = 0;
                    String userId = NetworkHelper.loggedInUserId.isNotEmpty
                        ? NetworkHelper.loggedInUserId
                        : '';
                    provider.fetchTravelDocuments(userId,context);
                    setState(() {});
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                          'assets/images/refresh.png',
                          width: 4.5.h,
                          height: 4.5.h,
                          color: AppColors.Color_607D8B
                      ),
                      SizedBox(
                        height:1.h,
                      ),
                      Text(
                        "Tab to Try Again",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: AppColors.fontFamilyBold,
                            fontSize: AppFontSize.fontSize15,
                            color: AppColors.Color_607D8B,
                            decoration: TextDecoration.none
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ):Scaffold(
              backgroundColor: AppColors.Color_FFFFFF,
              bottomNavigationBar: Container(
                height: 11.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.bottomNavBorderColor),
                ),
                child: customButton(
                  voidCallback: () {
                    _handleSaveButton(provider);
                  },
                  buttonText: "Save",
                  width: 90.w,
                  height: 4.h,
                  color: AppColors.buttonColor,
                  buttonTextColor: AppColors.buttonTextWhiteColor,
                  shadowColor: AppColors.buttonBorderColor,
                  fontSize: AppFontSize.fontSize18,
                  showShadow: true,
                ),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: provider.formKey,
                    autovalidateMode: provider.autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Button and Title
                        backButtonWithTitle(
                          title: "Travel Documents & Credentials",
                          onBackPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(height: 2.h),

                        // Seafarer’s Registration No.
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Seafarer’s Registration No.',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        customTextField(
                          context: context,
                          controller: provider.seafarerRegistrationNoController,
                          hintText: 'Enter Seafarer’s Registration No.',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          autovalidateMode: provider.autovalidateMode,
                          voidCallback: (value) {
                          if (value == null || value.isEmpty) {
                          return 'Please enter Seafarer’s Registration No.';
                          }
                          return null;
                          },
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.seafarerRegistrationNoFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),

                        // Passport
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Passport',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        // Passport UI
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Passport No.',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        customTextField(
                          context: context,
                          controller: provider.passportNoController,
                          hintText: 'Enter Passport No.',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          autovalidateMode: provider.autovalidateMode,
                          voidCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Passport No.';
                            }
                            return null;
                          },
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.passportNoFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Country',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.Color_FAFAFA,
                            borderRadius: BorderRadius.circular(2.h),
                          ),
                          child: SearchChoices.single(
                            items: provider.countries.map((country) {
                              return DropdownMenuItem(
                                child: Text(country),
                                value: country,
                              );
                            }).toList(),
                            value: provider.passportCountry,
                            hint: "Select Country",
                            onClear: (){
                              provider.setPassportCountry('');
                            },
                            autovalidateMode: provider.autovalidateMode,
                            validator: (value){
                              if ((value == null || value.isEmpty) &&  provider.autovalidateMode== AutovalidateMode.always) {
                                return '      Please select Country';
                              }
                              return null;
                            },
                            searchHint: "Search for a country",
                            onChanged: (value) {
                              provider.setPassportCountry(value as String);
                            },
                            isExpanded: true,
                            underline: SizedBox(),
                            displayItem: (item, selected) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(2.h),
                                  border: Border.all(
                                    color: AppColors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(item.child.data),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Issue Date',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setPassportIssueDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.passportIssueDateController,
                              hintText: 'Select Issue Date',
                              textInputType: TextInputType.datetime,
                              obscureText: false,
                              autovalidateMode: provider.autovalidateMode,
                              voidCallback: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select Issue Date';
                                }
                                return null;
                              },
                              fontSize: AppFontSize.fontSize16,
                              inputFontSize: AppFontSize.fontSize16,
                              backgroundColor: AppColors.Color_FAFAFA,
                              borderColor: AppColors.buttonColor,
                              textColor: Colors.black,
                              labelColor: AppColors.Color_9E9E9E,
                              cursorColor: AppColors.Color_212121,
                              fillColor: provider.passportIssueDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Expiry Date',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setPassportExpiryDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.passportExpiryDateController,
                              hintText: 'Select Expiry Date',
                              textInputType: TextInputType.datetime,
                              obscureText: false,
                              autovalidateMode: provider.autovalidateMode,
                              voidCallback: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select Expiry Date';
                                }
                                return null;
                              },
                              fontSize: AppFontSize.fontSize16,
                              inputFontSize: AppFontSize.fontSize16,
                              backgroundColor: AppColors.Color_FAFAFA,
                              borderColor: AppColors.buttonColor,
                              textColor: Colors.black,
                              labelColor: AppColors.Color_9E9E9E,
                              cursorColor: AppColors.Color_212121,
                              fillColor: provider.passportExpiryDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Attach Document',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await provider.showAttachmentOptions(context, 'passport');
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            dashPattern: [10, 10],
                            color: AppColors.buttonColor,
                            strokeWidth: 1,
                            child: Container(
                              width: 100.w,
                              padding: EdgeInsets.symmetric(vertical: 3.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.h),
                                color: AppColors.Color_FAFAFA,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/Upload.png", height: 5.h),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "Browse File",
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppColors.fontFamilySemiBold,
                                        color: AppColors.Color_9E9E9E),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (provider.passportDocument == null && !provider.hasExistingPassportDocument && provider.autovalidateMode == AutovalidateMode.always)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 4.w),
                            child: Text("Please select Passport",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: AppFontSize.fontSize12,
                              ),
                            ),
                          ),
                        SizedBox(height: 3.h),
                        // Show existing passport document from API
                        // if (provider.travelDocumentData?.passportDocumentPath.isNotEmpty == true)
                        //   Container(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 4.w, vertical: 2.h),
                        //     decoration: BoxDecoration(
                        //       color: Colors.green.shade100,
                        //       borderRadius: BorderRadius.circular(1.h),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                        //         SizedBox(width: 2.w),
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment:
                        //             CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 provider.travelDocumentData!.passportDocumentOriginalName.isNotEmpty
                        //                     ? provider.travelDocumentData!.passportDocumentOriginalName
                        //                     : "Passport Document",
                        //                 style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize16,
                        //                     fontWeight: FontWeight.w700,
                        //                     color: AppColors.Color_212121,
                        //                     fontFamily:
                        //                     AppColors.fontFamilyBold),
                        //                 overflow: TextOverflow.ellipsis,
                        //               ),
                        //               Text(
                        //                 "Existing document",
                        //                 style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize12,
                        //                     color: Colors.green,
                        //                     fontWeight: FontWeight.w500,
                        //                     fontFamily:
                        //                     AppColors.fontFamilyMedium),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         GestureDetector(
                        //           onTap: () {
                        //             // Open document URL
                        //             // You can implement document viewer here
                        //           },
                        //           child: Icon(
                        //             Icons.open_in_new,
                        //             color: Colors.green,
                        //             size: 24,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        if (provider.passportDocument != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.passportDocument!.path.split('/').last,
                                        style: TextStyle(
                                            fontSize: AppFontSize.fontSize16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.Color_212121,
                                            fontFamily:
                                            AppColors.fontFamilyBold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      FutureBuilder<int>(
                                        future: provider.passportDocument!.length(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                              style: TextStyle(
                                                  fontSize: AppFontSize.fontSize12,
                                                  color: AppColors.Color_616161,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                  AppColors.fontFamilyMedium),
                                            );
                                          }
                                          return SizedBox();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.removeAttachment('passport');
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Seaman’s Book
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Seaman’s Book',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        // Seaman’s Book UI
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Seaman’s Book No.',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        customTextField(
                          context: context,
                          controller: provider.seamanBookNoController,
                          hintText: 'Enter Seaman’s Book No.',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          autovalidateMode: provider.autovalidateMode,
                          voidCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Seaman’s Book No.';
                            }
                            return null;
                          },
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.seamanBookNoFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Issuing Country',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.Color_FAFAFA,
                            borderRadius: BorderRadius.circular(2.h),
                          ),
                          child: SearchChoices.single(
                            items: provider.countries.map((country) {
                              return DropdownMenuItem(
                                child: Text(country),
                                value: country,
                              );
                            }).toList(),
                            value: provider.seamanIssuingCountry,
                            hint: "Select Country",
                            onClear: (){
                              provider.setSeamanIssuingCountry('');
                            },
                            autovalidateMode: provider.autovalidateMode,
                            validator: (value){
                              if ((value == null || value.isEmpty) &&  provider.autovalidateMode== AutovalidateMode.always) {
                                return '      Please select Country';
                              }
                              return null;
                            },
                            searchHint: "Search for a country",
                            onChanged: (value) {
                              provider.setSeamanIssuingCountry(value as String);
                            },
                            isExpanded: true,
                            underline: SizedBox(),
                            displayItem: (item, selected) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(2.h),
                                  border: Border.all(
                                    color: AppColors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(item.child.data),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Issuing Authority',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        customTextField(
                          context: context,
                          controller: provider.seamanIssuingAuthorityController,
                          hintText: 'Enter Issuing Authority',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          autovalidateMode: provider.autovalidateMode,
                          voidCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Issuing Authority';
                            }
                            return null;
                          },
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.seamanIssuingAuthorityFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Issue Date',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setSeamanIssueDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.seamanIssueDateController,
                              hintText: 'Select Issue Date',
                              textInputType: TextInputType.datetime,
                              obscureText: false,
                              autovalidateMode: provider.autovalidateMode,
                              voidCallback: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select Issue Date';
                                }
                                return null;
                              },
                              fontSize: AppFontSize.fontSize16,
                              inputFontSize: AppFontSize.fontSize16,
                              backgroundColor: AppColors.Color_FAFAFA,
                              borderColor: AppColors.buttonColor,
                              textColor: Colors.black,
                              labelColor: AppColors.Color_9E9E9E,
                              cursorColor: AppColors.Color_212121,
                              fillColor: provider.seamanIssueDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Expiry Date',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setSeamanExpiryDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.seamanExpiryDateController,
                              hintText: 'Select Expiry Date',
                              textInputType: TextInputType.datetime,
                              obscureText: false,
                              autovalidateMode: provider.autovalidateMode,
                              voidCallback:  (value) {
                                if ((value == null || value.isEmpty) && !provider.seamanNeverExpire) {
                                  return 'Please select Expiry Date';
                                }
                                return null;
                              },
                              fontSize: AppFontSize.fontSize16,
                              inputFontSize: AppFontSize.fontSize16,
                              backgroundColor: AppColors.Color_FAFAFA,
                              borderColor: AppColors.buttonColor,
                              textColor: Colors.black,
                              labelColor: AppColors.Color_9E9E9E,
                              cursorColor: AppColors.Color_212121,
                              fillColor: provider.seamanExpiryDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Checkbox(
                              value: provider.seamanNeverExpire,
                              onChanged: (value) {
                                provider.setSeamanNeverExpire(value!);
                              },
                            ),
                            Text('Some never expire'),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Nationality',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.Color_FAFAFA,
                            borderRadius: BorderRadius.circular(2.h),
                          ),
                          child: SearchChoices.single(
                            items: provider.countries.map((country) {
                              return DropdownMenuItem(
                                child: Text(country),
                                value: country,
                              );
                            }).toList(),
                            value: provider.seamanNationality,
                            hint: "Select Nationality",
                            onClear: (){
                              provider.setSeamanNationality('');
                            },
                            autovalidateMode: provider.autovalidateMode,
                            validator: (value){
                              if ((value == null || value.isEmpty) &&  provider.autovalidateMode== AutovalidateMode.always) {
                                return '      Please select Nationality';
                              }
                              return null;
                            },
                            searchHint: "Search for a nationality",
                            onChanged: (value) {
                              provider.setSeamanNationality(value as String);
                            },
                            isExpanded: true,
                            underline: SizedBox(),
                            displayItem: (item, selected) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(2.h),
                                  border: Border.all(
                                    color: AppColors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(item.child.data),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Attach Document',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await provider.showAttachmentOptions(context, 'seaman');
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            dashPattern: [10, 10],
                            color: AppColors.buttonColor,
                            strokeWidth: 1,
                            child: Container(
                              width: 100.w,
                              padding: EdgeInsets.symmetric(vertical: 3.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.h),
                                color: AppColors.Color_FAFAFA,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/Upload.png", height: 5.h),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "Browse File",
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppColors.fontFamilySemiBold,
                                        color: AppColors.Color_9E9E9E),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (provider.seamanDocument == null && !provider.hasExistingSeamanDocument && provider.autovalidateMode== AutovalidateMode.always)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 4.w),
                            child: Text("Please select Seaman Document",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: AppFontSize.fontSize12,
                              ),
                            ),
                          ),
                        SizedBox(height: 3.h),
                        // Show existing seaman document from API
                        // if (provider.travelDocumentData?.seamansBookDocumentPath.isNotEmpty == true)
                        //   Container(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 4.w, vertical: 2.h),
                        //     decoration: BoxDecoration(
                        //       color: Colors.green.shade100,
                        //       borderRadius: BorderRadius.circular(1.h),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                        //         SizedBox(width: 2.w),
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment:
                        //             CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 provider.travelDocumentData!.seamansBookDocumentOriginalName.isNotEmpty
                        //                     ? provider.travelDocumentData!.seamansBookDocumentOriginalName
                        //                     : "Seaman's Book Document",
                        //                 style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize16,
                        //                     fontWeight: FontWeight.w700,
                        //                     color: AppColors.Color_212121,
                        //                     fontFamily:
                        //                     AppColors.fontFamilyBold),
                        //                 overflow: TextOverflow.ellipsis,
                        //               ),
                        //               Text(
                        //                 "Existing document",
                        //                 style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize12,
                        //                     color: Colors.green,
                        //                     fontWeight: FontWeight.w500,
                        //                     fontFamily:
                        //                     AppColors.fontFamilyMedium),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         GestureDetector(
                        //           onTap: () {
                        //             // Open document URL
                        //             // You can implement document viewer here
                        //           },
                        //           child: Icon(
                        //             Icons.open_in_new,
                        //             color: Colors.green,
                        //             size: 24,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        if (provider.seamanDocument != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.seamanDocument!.path.split('/').last,
                                        style: TextStyle(
                                            fontSize: AppFontSize.fontSize16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.Color_212121,
                                            fontFamily:
                                            AppColors.fontFamilyBold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      FutureBuilder<int>(
                                        future: provider.seamanDocument!.length(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                              style: TextStyle(
                                                  fontSize: AppFontSize.fontSize12,
                                                  color: AppColors.Color_616161,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                  AppColors.fontFamilyMedium),
                                            );
                                          }
                                          return SizedBox();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.removeAttachment('seaman');
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Valid Seafarer’s Visa
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Valid Seafarer’s Visa',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        // Valid Seafarer’s Visa UI
                        Row(
                          children: [
                            Radio(
                              activeColor: AppColors.buttonColor,
                              value: true,
                              groupValue: provider.validSeafarerVisa,
                              onChanged: (value) {
                                provider.setValidSeafarerVisa(value!);
                              },
                            ),
                            Text('Yes'),
                            Radio(
                              activeColor: AppColors.buttonColor,
                              value: false,
                              groupValue: provider.validSeafarerVisa,
                              onChanged: (value) {
                                provider.setValidSeafarerVisa(value!);
                              },
                            ),
                            Text('No'),
                          ],
                        ),
                        if (provider.validSeafarerVisa)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Issuing Country',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(2.h),
                                ),
                                child: SearchChoices.single(
                                  items: provider.countries.map((country) {
                                    return DropdownMenuItem(
                                      child: Text(country),
                                      value: country,
                                    );
                                  }).toList(),
                                  value: provider.seafarerVisaIssuingCountry,
                                  hint: "Select Country",
                                  onClear: (){
                                    provider.setSeafarerVisaIssuingCountry('');
                                  },
                                  autovalidateMode: provider.autovalidateMode,
                                  validator: (value){
                                    if ((value == null || value.isEmpty) &&  provider.autovalidateMode== AutovalidateMode.always) {
                                      return '      Please select Country';
                                    }
                                    return null;
                                  },
                                  searchHint: "Search for a country",
                                  onChanged: (value) {
                                    provider.setSeafarerVisaIssuingCountry(value as String);
                                  },
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  displayItem: (item, selected) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                        borderRadius: BorderRadius.circular(2.h),
                                        border: Border.all(
                                          color: AppColors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(item.child.data),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Visa No.',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              customTextField(
                                context: context,
                                controller: provider.seafarerVisaNoController,
                                hintText: 'Enter Visa No.',
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autovalidateMode: provider.autovalidateMode,
                                voidCallback: (value) {
                                  if (provider.validSeafarerVisa && (value == null || value.isEmpty)) {
                                    return 'Please enter Visa No.';
                                  }
                                  return null;
                                },
                                fontSize: AppFontSize.fontSize16,
                                inputFontSize: AppFontSize.fontSize16,
                                backgroundColor: AppColors.Color_FAFAFA,
                                borderColor: AppColors.buttonColor,
                                textColor: Colors.black,
                                labelColor: AppColors.Color_9E9E9E,
                                cursorColor: AppColors.Color_212121,
                                fillColor: provider.seafarerVisaNoFocusNode.hasFocus
                                    ? AppColors.activeFieldBgColor
                                    : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Issue Date',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (picked != null) {
                                    provider.setSeafarerVisaIssueDate(picked);
                                  }
                                },
                                child: AbsorbPointer(
                                  child: customTextField(
                                    context: context,
                                    controller: provider.seafarerVisaIssueDateController,
                                    hintText: 'Select Issue Date',
                                    textInputType: TextInputType.datetime,
                                    obscureText: false,
                                    autovalidateMode: provider.autovalidateMode,
                                    voidCallback: (value) {
                                      if (provider.validSeafarerVisa && (value == null || value.isEmpty)) {
                                        return 'Please select Issue Date';
                                      }
                                      return null;
                                    },
                                    fontSize: AppFontSize.fontSize16,
                                    inputFontSize: AppFontSize.fontSize16,
                                    backgroundColor: AppColors.Color_FAFAFA,
                                    borderColor: AppColors.buttonColor,
                                    textColor: Colors.black,
                                    labelColor: AppColors.Color_9E9E9E,
                                    cursorColor: AppColors.Color_212121,
                                    fillColor: provider.seafarerVisaIssueDateFocusNode.hasFocus
                                        ? AppColors.activeFieldBgColor
                                        : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Expiry Date',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (picked != null) {
                                    provider.setSeafarerVisaExpiryDate(picked);
                                  }
                                },
                                child: AbsorbPointer(
                                  child: customTextField(
                                    context: context,
                                    controller: provider.seafarerVisaExpiryDateController,
                                    hintText: 'Select Expiry Date',
                                    textInputType: TextInputType.datetime,
                                    obscureText: false,
                                    autovalidateMode: provider.autovalidateMode,
                                    voidCallback: (value) {
                                      if (provider.validSeafarerVisa && (value == null || value.isEmpty)) {
                                        return 'Please select Expiry Date';
                                      }
                                      return null;
                                    },
                                    fontSize: AppFontSize.fontSize16,
                                    inputFontSize: AppFontSize.fontSize16,
                                    backgroundColor: AppColors.Color_FAFAFA,
                                    borderColor: AppColors.buttonColor,
                                    textColor: Colors.black,
                                    labelColor: AppColors.Color_9E9E9E,
                                    cursorColor: AppColors.Color_212121,
                                    fillColor: provider.seafarerVisaExpiryDateFocusNode.hasFocus
                                        ? AppColors.activeFieldBgColor
                                        : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: Text(
                                  'Attach Document',
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppColors.fontFamilyMedium,
                                    color: AppColors.Color_424242,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await provider.showAttachmentOptions(context, 'seafarer_visa');
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(15),
                                  dashPattern: [10, 10],
                                  color: AppColors.buttonColor,
                                  strokeWidth: 1,
                                  child: Container(
                                    width: 100.w,
                                    padding: EdgeInsets.symmetric(vertical: 3.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1.h),
                                      color: AppColors.Color_FAFAFA,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/images/Upload.png", height: 5.h),
                                        SizedBox(height: 1.h),
                                        Text(
                                          "Browse File",
                                          style: TextStyle(
                                              fontSize: AppFontSize.fontSize14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: AppColors.fontFamilySemiBold,
                                              color: AppColors.Color_9E9E9E),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (provider.seafarerVisaDocument == null && !provider.hasExistingSeafarerVisaDocument && provider.autovalidateMode == AutovalidateMode.always)
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h, left: 4.w),
                                  child: Text("Please select Seafarer Visa Document",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: AppFontSize.fontSize12,
                                    ),
                                  ),
                                ),
                              SizedBox(height: 3.h),
                              // Show existing seafarer visa document from API
                              // if (provider.travelDocumentData?.seafarerVisaDocumentPath.isNotEmpty == true)
                              //   Container(
                              //     padding: EdgeInsets.symmetric(
                              //         horizontal: 4.w, vertical: 2.h),
                              //     decoration: BoxDecoration(
                              //       color: Colors.green.shade100,
                              //       borderRadius: BorderRadius.circular(1.h),
                              //     ),
                              //     child: Row(
                              //       children: [
                              //         Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                              //         SizedBox(width: 2.w),
                              //         Expanded(
                              //           child: Column(
                              //             crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //             children: [
                              //               Text(
                              //                 provider.travelDocumentData!.seafarerVisaDocumentOriginalName.isNotEmpty
                              //                     ? provider.travelDocumentData!.seafarerVisaDocumentOriginalName
                              //                     : "Seafarer Visa Document",
                              //                 style: TextStyle(
                              //                     fontSize: AppFontSize.fontSize16,
                              //                     fontWeight: FontWeight.w700,
                              //                     color: AppColors.Color_212121,
                              //                     fontFamily:
                              //                     AppColors.fontFamilyBold),
                              //                 overflow: TextOverflow.ellipsis,
                              //               ),
                              //               Text(
                              //                 "Existing document",
                              //                 style: TextStyle(
                              //                     fontSize: AppFontSize.fontSize12,
                              //                     color: Colors.green,
                              //                     fontWeight: FontWeight.w500,
                              //                     fontFamily:
                              //                     AppColors.fontFamilyMedium),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         GestureDetector(
                              //           onTap: () {
                              //             // Open document URL
                              //             // You can implement document viewer here
                              //           },
                              //           child: Icon(
                              //             Icons.open_in_new,
                              //             color: Colors.green,
                              //             size: 24,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              if (provider.seafarerVisaDocument != null)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(1.h),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                                      SizedBox(width: 2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              provider.seafarerVisaDocument!.path.split('/').last,
                                              style: TextStyle(
                                                  fontSize: AppFontSize.fontSize16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.Color_212121,
                                                  fontFamily:
                                                  AppColors.fontFamilyBold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            FutureBuilder<int>(
                                              future: provider.seafarerVisaDocument!.length(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                                    style: TextStyle(
                                                        fontSize: AppFontSize.fontSize12,
                                                        color: AppColors.Color_616161,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily:
                                                        AppColors.fontFamilyMedium),
                                                  );
                                                }
                                                return SizedBox();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          provider.removeAttachment('seafarer_visa');
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),

                        // Visa
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Visa',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        // Visa UI
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Issuing Country',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.Color_FAFAFA,
                            borderRadius: BorderRadius.circular(2.h),
                          ),
                          child: SearchChoices.single(
                            items: provider.countries.map((country) {
                              return DropdownMenuItem(
                                child: Text(country),
                                value: country,
                              );
                            }).toList(),
                            value: provider.visaIssuingCountry,
                            hint: "Select Country",
                            onClear: (){
                              provider.setVisaIssuingCountry('');
                            },
                            autovalidateMode: provider.autovalidateMode,
                            validator: (value){
                              if ((value == null || value.isEmpty) &&  provider.autovalidateMode== AutovalidateMode.always) {
                                return '      Please select Country';
                              }
                              return null;
                            },
                            searchHint: "Search for a country",
                            onChanged: (value) {
                              provider.setVisaIssuingCountry(value as String);
                            },
                            isExpanded: true,
                            underline: SizedBox(),
                            displayItem: (item, selected) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(2.h),
                                  border: Border.all(
                                    color: AppColors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(item.child.data),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Visa No.',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        customTextField(
                          context: context,
                          controller: provider.visaNoController,
                          hintText: 'Enter Visa No.',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          autovalidateMode: provider.autovalidateMode,
                          voidCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Visa No.';
                            }
                            return null;
                          },
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.visaNoFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Issue Date',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setVisaIssueDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.visaIssueDateController,
                              hintText: 'Select Issue Date',
                              textInputType: TextInputType.datetime,
                              obscureText: false,
                              autovalidateMode: provider.autovalidateMode,
                              voidCallback: (value) {
                              if (value == null || value.isEmpty) {
                              return 'Please select Issue Date';
                              }
                              return null;
                              },
                              fontSize: AppFontSize.fontSize16,
                              inputFontSize: AppFontSize.fontSize16,
                              backgroundColor: AppColors.Color_FAFAFA,
                              borderColor: AppColors.buttonColor,
                              textColor: Colors.black,
                              labelColor: AppColors.Color_9E9E9E,
                              cursorColor: AppColors.Color_212121,
                              fillColor: provider.visaIssueDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Expiry Date',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setVisaExpiryDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.visaExpiryDateController,
                              hintText: 'Select Expiry Date',
                              textInputType: TextInputType.datetime,
                              obscureText: false,
                              autovalidateMode: provider.autovalidateMode,
                              voidCallback: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select Expiry Date';
                                }
                                return null;
                              },
                              fontSize: AppFontSize.fontSize16,
                              inputFontSize: AppFontSize.fontSize16,
                              backgroundColor: AppColors.Color_FAFAFA,
                              borderColor: AppColors.buttonColor,
                              textColor: Colors.black,
                              labelColor: AppColors.Color_9E9E9E,
                              cursorColor: AppColors.Color_212121,
                              fillColor: provider.visaExpiryDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Attach Document',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await provider.showAttachmentOptions(context, 'visa');
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            dashPattern: [10, 10],
                            color: AppColors.buttonColor,
                            strokeWidth: 1,
                            child: Container(
                              width: 100.w,
                              padding: EdgeInsets.symmetric(vertical: 3.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.h),
                                color: AppColors.Color_FAFAFA,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/Upload.png", height: 5.h),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "Browse File",
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppColors.fontFamilySemiBold,
                                        color: AppColors.Color_9E9E9E),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (provider.visaDocument == null && !provider.hasExistingVisaDocument && provider.autovalidateMode==AutovalidateMode.always)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 4.w),
                            child: Text("Please select Visa Document",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: AppFontSize.fontSize12,
                              ),
                            ),
                          ),
                        SizedBox(height: 3.h),
                        // Show existing visa document from API
                        // if (provider.travelDocumentData?.visaDocumentPath.isNotEmpty == true)
                        //   Container(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 4.w, vertical: 2.h),
                        //     decoration: BoxDecoration(
                        //       color: Colors.green.shade100,
                        //       borderRadius: BorderRadius.circular(1.h),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                        //         SizedBox(width: 2.w),
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment:
                        //             CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 provider.travelDocumentData!.visaDocumentOriginalName.isNotEmpty
                        //                     ? provider.travelDocumentData!.visaDocumentOriginalName
                        //                     : "Visa Document",
                        //                 style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize16,
                        //                     fontWeight: FontWeight.w700,
                        //                     color: AppColors.Color_212121,
                        //                     fontFamily:
                        //                     AppColors.fontFamilyBold),
                        //                 overflow: TextOverflow.ellipsis,
                        //               ),
                        //               Text(
                        //                 "Existing document",
                        //                 style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize12,
                        //                     color: Colors.green,
                        //                     fontWeight: FontWeight.w500,
                        //                     fontFamily:
                        //                     AppColors.fontFamilyMedium),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         GestureDetector(
                        //           onTap: () {
                        //             // Open document URL
                        //             // You can implement document viewer here
                        //           },
                        //           child: Icon(
                        //             Icons.open_in_new,
                        //             color: Colors.green,
                        //             size: 24,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        if (provider.visaDocument != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.visaDocument!.path.split('/').last,
                                        style: TextStyle(
                                            fontSize: AppFontSize.fontSize16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.Color_212121,
                                            fontFamily:
                                            AppColors.fontFamilyBold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      FutureBuilder<int>(
                                        future: provider.visaDocument!.length(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                              style: TextStyle(
                                                  fontSize: AppFontSize.fontSize12,
                                                  color: AppColors.Color_616161,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                  AppColors.fontFamilyMedium),
                                            );
                                          }
                                          return SizedBox();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.removeAttachment('visa');
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Residence Permit
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Residence Permit',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        // Residence Permit UI
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Issuing Country',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.Color_FAFAFA,
                            borderRadius: BorderRadius.circular(2.h),
                          ),
                          child: SearchChoices.single(
                            items: provider.countries.map((country) {
                              return DropdownMenuItem(
                                child: Text(country),
                                value: country,
                              );
                            }).toList(),
                            value: provider.residencePermitIssuingCountry,
                            hint: "Select Country",
                            onClear: (){
                              provider.setResidencePermitIssuingCountry('');
                            },
                             autovalidateMode: provider.autovalidateMode,
                             validator: (value){
                               if ((value == null || value.isEmpty) &&  provider.autovalidateMode== AutovalidateMode.always) {
                              return '      Please select Country';
                              }
                              return null;
                            },
                            // padding:EdgeInsets.only(top: 1.h, left: 4.w),
                            searchHint: "Search for a country",
                            onChanged: (value) {
                              provider.setResidencePermitIssuingCountry(value as String);
                            },
                            isExpanded: true,
                            underline: SizedBox(),
                            displayItem: (item, selected) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: selected ? AppColors.activeFieldBgColor : AppColors.Color_FAFAFA,
                                  borderRadius: BorderRadius.circular(2.h),
                                  border: Border.all(
                                    color: AppColors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(item.child.data),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'No.',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        customTextField(
                          context: context,
                          controller: provider.residencePermitNoController,
                          hintText: 'Enter No.',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          autovalidateMode: provider.autovalidateMode,
                          voidCallback: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter No.';
                            }
                            return null;
                          },
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: provider.residencePermitNoFocusNode.hasFocus
                              ? AppColors.activeFieldBgColor
                              : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Issue Date',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setResidencePermitIssueDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.residencePermitIssueDateController,
                              hintText: 'Select Issue Date',
                              textInputType: TextInputType.datetime,
                              obscureText: false,
                              autovalidateMode: provider.autovalidateMode,
                              voidCallback: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select Issue Date';
                                }
                                return null;
                              },
                              fontSize: AppFontSize.fontSize16,
                              inputFontSize: AppFontSize.fontSize16,
                              backgroundColor: AppColors.Color_FAFAFA,
                              borderColor: AppColors.buttonColor,
                              textColor: Colors.black,
                              labelColor: AppColors.Color_9E9E9E,
                              cursorColor: AppColors.Color_212121,
                              fillColor: provider.residencePermitIssueDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Expiry Date',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              provider.setResidencePermitExpiryDate(picked);
                            }
                          },
                          child: AbsorbPointer(
                            child: customTextField(
                              context: context,
                              controller: provider.residencePermitExpiryDateController,
                              hintText: 'Select Expiry Date',
                              textInputType: TextInputType.datetime,
                              obscureText: false,
                              autovalidateMode: provider.autovalidateMode,
                              voidCallback: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select Expiry Date';
                                }
                                return null;
                              },
                              fontSize: AppFontSize.fontSize16,
                              inputFontSize: AppFontSize.fontSize16,
                              backgroundColor: AppColors.Color_FAFAFA,
                              borderColor: AppColors.buttonColor,
                              textColor: Colors.black,
                              labelColor: AppColors.Color_9E9E9E,
                              cursorColor: AppColors.Color_212121,
                              fillColor: provider.residencePermitExpiryDateFocusNode.hasFocus
                                  ? AppColors.activeFieldBgColor
                                  : AppColors.Color_FAFAFA, onFieldSubmitted: (String ) {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Attach Document',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color: AppColors.Color_424242,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await provider.showAttachmentOptions(context, 'residence_permit');
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            dashPattern: [10, 10],
                            color: AppColors.buttonColor,
                            strokeWidth: 1,
                            child: Container(
                              width: 100.w,
                              padding: EdgeInsets.symmetric(vertical: 3.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.h),
                                color: AppColors.Color_FAFAFA,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/Upload.png", height: 5.h),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "Browse File",
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppColors.fontFamilySemiBold,
                                        color: AppColors.Color_9E9E9E),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (provider.residencePermitDocument == null && !provider.hasExistingResidencePermitDocument && provider.autovalidateMode == AutovalidateMode.always)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 4.w),
                            child: Text("Please select Residence Permit Document",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: AppFontSize.fontSize12,
                              ),
                            ),
                          ),
                        SizedBox(height: 3.h),
                        // Show existing residence permit document from API
                        // if (provider.travelDocumentData?.residencePermitDocumentPath.isNotEmpty == true)
                        //   Container(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 4.w, vertical: 2.h),
                        //     decoration: BoxDecoration(
                        //       color: Colors.green.shade100,
                        //       borderRadius: BorderRadius.circular(1.h),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                        //         SizedBox(width: 2.w),
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment:
                        //             CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 provider.travelDocumentData!.residencePermitDocumentOriginalName.isNotEmpty
                        //                     ? provider.travelDocumentData!.residencePermitDocumentOriginalName
                        //                     : "Residence Permit Document",
                        //                 style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize16,
                        //                     fontWeight: FontWeight.w700,
                        //                     color: AppColors.Color_212121,
                        //                     fontFamily:
                        //                     AppColors.fontFamilyBold),
                        //                 overflow: TextOverflow.ellipsis,
                        //               ),
                        //               Text(
                        //                 "Existing document",
                        //                 style: TextStyle(
                        //                     fontSize: AppFontSize.fontSize12,
                        //                     color: Colors.green,
                        //                     fontWeight: FontWeight.w500,
                        //                     fontFamily:
                        //                     AppColors.fontFamilyMedium),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         GestureDetector(
                        //           onTap: () {
                        //             // Open document URL
                        //             // You can implement document viewer here
                        //           },
                        //           child: Icon(
                        //             Icons.open_in_new,
                        //             color: Colors.green,
                        //             size: 24,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        if (provider.residencePermitDocument != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/images/pdfIcon.png", height: 3.5.h),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.residencePermitDocument!.path.split('/').last,
                                        style: TextStyle(
                                            fontSize: AppFontSize.fontSize16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.Color_212121,
                                            fontFamily:
                                            AppColors.fontFamilyBold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      FutureBuilder<int>(
                                        future: provider.residencePermitDocument!.length(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              "${(snapshot.data! / 1024).toStringAsFixed(2)} KB",
                                              style: TextStyle(
                                                  fontSize: AppFontSize.fontSize12,
                                                  color: AppColors.Color_616161,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                  AppColors.fontFamilyMedium),
                                            );
                                          }
                                          return SizedBox();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.removeAttachment('residence_permit');
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class backButtonWithTitle extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;

  const backButtonWithTitle({
    Key? key,
    required this.title,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
        SizedBox(width: 3.w),
        Text(
          title,
          style: TextStyle(
            fontSize: AppFontSize.fontSize18,
            fontWeight: FontWeight.bold,
            color: AppColors.Color_424242,
          ),
        ),
      ],
    );
  }
}
