import 'package:flutter/material.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/Summary_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../const/color.dart';
import '../../../const/font_size.dart';
import '../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/expected_salary_provider.dart';
import '../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/references_provider.dart';
import '../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/skills_provider.dart';
import '../../../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';
import 'package:luneta/route/route_constants.dart';

class ProfileScreenBottomMenu extends StatefulWidget {
  const ProfileScreenBottomMenu({super.key});

  @override
  State<ProfileScreenBottomMenu> createState() =>
      _ProfileScreenBottomMenuState();
}

class _ProfileScreenBottomMenuState extends State<ProfileScreenBottomMenu> {

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileBottommenuProvider>(
        context,
        listen: false).getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileBottommenuProvider>(
      builder: (context, profileProvider, child) {
        return Container(
          width: 100.w,
          color: AppColors.Color_FFFFFF,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // **Header Section**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/LunetaLogo.png",
                        height: 0.8.h,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: AppFontSize.fontSize24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.Color_212121,
                            fontFamily: AppColors.fontFamilyBold),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(settingsScreen);
                      },
                      child: Image.asset("assets/images/SettingIcon.png",
                          height: AppFontSize.fontSize24))
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              // **Profile Information**
              _buildProfileSection(profileProvider, context),
              Container(
                margin: EdgeInsets.only(top: 2.5.h, bottom: 1.h),
                height: 0.01.h,
                color: AppColors.Color_EEEEEE,
                width: 100.w,
              ),
              // **Profile Sections List**
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profileProvider.profileSections.length,
                  itemBuilder: (context, index) {
                    final section = profileProvider.profileSections[index];
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      margin: EdgeInsets.only(bottom: 1.5.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.h),
                          color: AppColors.Color_FFFFFF,
                          border: Border.all(
                              width: 0.1.h,
                              color: AppColors.Color_EEEEEE)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(section["icon"],
                                      height: 2.5.h, width: 2.5.h),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    section["title"],
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize20,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyBold),
                                  ),
                                ],
                              ),
                              index != 7?GestureDetector(
                                onTap: () {

                                  bool curentFlag = profileProvider.getSectionStatus(section["title"]);


                                  switch (index) {
                                    case 0:
                                      Navigator.of(context).pushNamed(personalInfo);
                                      break;
                                    case 1:
                                      // final contactProvider =
                                      //     Provider.of<SummaryProvider>(context,
                                      //         listen: false);
                                      // // Set the values directly in the provider
                                      // contactProvider.summaryController.text =
                                      //     profileProvider.summary ?? '';
                                      // profileProvider.setSectionStatus(section["title"],!curentFlag);
                                      Navigator.of(context).pushNamed(ProfessionalExperience);
                                      break;
                                    case 2:
                                      Navigator.of(context)
                                          .pushNamed(travelDocument);
                                      break;
                                    case 3:
                                      profileProvider.setSectionStatus(section["title"],!curentFlag);
                                      Navigator.of(context)
                                          .pushNamed(workExperienceScreen);
                                      break;
                                    case 4:
                                      profileProvider.setSectionStatus(section["title"],!curentFlag);
                                      Navigator.of(context)
                                          .pushNamed(educationScreen);
                                      break;
                                    case 5:
                                      profileProvider.setSectionStatus(section["title"],!curentFlag);
                                      Navigator.of(context)
                                          .pushNamed(projectScreen);
                                      break;
                                    case 6:
                                      profileProvider.setSectionStatus(section["title"],!curentFlag);
                                      Navigator.of(context)
                                          .pushNamed(certificationScreen);
                                      break;
                                    case 7:
                                      profileProvider.setSectionStatus(section["title"],!curentFlag);
                                      Navigator.of(context)
                                          .pushNamed(volunteeringScreen);
                                      break;
                                    case 8:
                                      profileProvider.setSectionStatus(section["title"],!curentFlag);
                                      Navigator.of(context)
                                          .pushNamed(professionalExamScreen);
                                      break;
                                    default:
                                      print("No action defined for this section");
                                  }
                                },
                                child: profileProvider
                                            .getSectionStatus(section["title"])
                                        ? Image.asset(
                                            "assets/images/Edit.png",
                                            // Show image instead of icon
                                            height: 2.5.h,
                                          )
                                        : Icon(
                                            Icons.add,
                                            size: 2.5.h,
                                            color: AppColors.buttonColor,
                                          )
                              ):Container()
                            ],
                          ),

                          if (index == 0 && profileProvider.ContactInfo!=null && profileProvider.getSectionStatus(section["title"]))
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    dividerRow(),
                                    Padding(
                                    padding: EdgeInsets.only(top:2.h),
                                    child: Text("Contact Information",
                                      style: TextStyle(
                                          fontSize: AppFontSize.fontSize18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.Color_212121,
                                          fontFamily:
                                          AppColors.fontFamilyMedium),
                                    ),
                                  ),
                                  LabelView("assets/images/emailIcon.png", profileProvider.ContactInfo!.contactInfo["email"],label: "  Email: "),
                                  LabelView("assets/images/emailIcon.png", profileProvider.ContactInfo!.contactInfo["mobilePhone"],label: "  Mobile Phone: "),
                                  LabelView("assets/images/emailIcon.png", profileProvider.ContactInfo!.contactInfo["directLinePhone"],label: "  Direct Line Phone: "),
                                  LabelView("assets/images/emailIcon.png", profileProvider.ContactInfo!.contactInfo["homeAddress"],label: "  Home Address: "),
                                  ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: profileProvider.ContactInfo!.onlineCommunication.length,
                                  itemBuilder: (context, index) {
                                    return  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      index==0?Padding(
                                        padding: EdgeInsets.only(top:2.h),
                                        child: Text("Online Communication",
                                          style: TextStyle(
                                              fontSize: AppFontSize.fontSize18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.Color_212121,
                                              fontFamily:
                                              AppColors.fontFamilyMedium),
                                        ),
                                      ):Container(),
                                      LabelView("assets/images/emailIcon.png", profileProvider.ContactInfo!.onlineCommunication[index]["id"]!,label: "  "+profileProvider.ContactInfo!.onlineCommunication[index]["platform"]!+": ")
                                    ],);
                                  }),
                                ],
                              ),
                            ),

                          if (index == 1 && profileProvider.experienceInfo != null && profileProvider.getSectionStatus(section["title"]))
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dividerRow(),
                                  // Positions Held
                                  LabelView(
                                      "assets/images/WorkActive.png",
                                      profileProvider.experienceInfo!.positionsHeld.join(', '),
                                      label: "Positions Held: "
                                  ),
                                  // Vessel Type Experience
                                  LabelView(
                                      "assets/images/DocumentIcon.png",
                                      profileProvider.experienceInfo!.vesselTypeExperience.join(', '),
                                      label: "Vessel Type Experience: "
                                  ),
                                  // Employment History
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Employment History",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.experienceInfo!.employmentHistory.length,
                                    itemBuilder: (context, index) {
                                      var employment = profileProvider.experienceInfo!.employmentHistory[index];
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.1.h,
                                                          color: AppColors
                                                              .Color_EEEEEE),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          2.h)),
                                                  padding: EdgeInsets.all(1.2.h),
                                                  child: Image.asset(
                                                    "assets/images/companyLogo.png",
                                                    height: 5.h,
                                                    width: 5.h,
                                                  ),
                                                ),
                                                SizedBox(width: 3.w),
                                                Container(
                                                  // color:Colors.red,
                                                  width: 64.w,
                                                  margin:
                                                  EdgeInsets.only(bottom: 2.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(employment.position,
                                                            style: TextStyle(
                                                              fontSize: AppFontSize
                                                                  .fontSize20,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              color: AppColors
                                                                  .Color_212121,
                                                              fontFamily: AppColors
                                                                  .fontFamilyBold,
                                                            ),
                                                          ),
                                                          // GestureDetector(
                                                          //   // onTap: () {
                                                          //   //   final provider = Provider
                                                          //   //       .of<WorkExperienceProvider>(
                                                          //   //       context,
                                                          //   //       listen:
                                                          //   //       false);
                                                          //   //
                                                          //   //   // Parse dates
                                                          //   //   DateTime? startDate;
                                                          //   //   DateTime? endDate;
                                                          //   //
                                                          //   //   if (experience[
                                                          //   //   'startDate'] !=
                                                          //   //       null) {
                                                          //   //     try {
                                                          //   //       startDate = DateFormat(
                                                          //   //           'MM/yyyy')
                                                          //   //           .parse(experience[
                                                          //   //       'startDate']);
                                                          //   //     } catch (e) {
                                                          //   //       print(
                                                          //   //           'Error parsing start date: $e');
                                                          //   //     }
                                                          //   //   }
                                                          //   //
                                                          //   //   if (experience[
                                                          //   //   'endDate'] !=
                                                          //   //       null &&
                                                          //   //       experience[
                                                          //   //       'endDate'] !=
                                                          //   //           'Present') {
                                                          //   //     try {
                                                          //   //       endDate = DateFormat(
                                                          //   //           'MM/yyyy')
                                                          //   //           .parse(experience[
                                                          //   //       'endDate']);
                                                          //   //     } catch (e) {
                                                          //   //       print(
                                                          //   //           'Error parsing end date: $e');
                                                          //   //     }
                                                          //   //   }
                                                          //   //
                                                          //   //   // Initialize provider with work experience data
                                                          //   //   provider
                                                          //   //       .initializeWithData(
                                                          //   //     title: experience[
                                                          //   //     'title'] ??
                                                          //   //         '',
                                                          //   //     company: experience[
                                                          //   //     'company'] ??
                                                          //   //         '',
                                                          //   //     location:
                                                          //   //     experience[
                                                          //   //     'location'],
                                                          //   //     description:
                                                          //   //     experience[
                                                          //   //     'description'],
                                                          //   //     employmentType:
                                                          //   //     experience[
                                                          //   //     'employmentType'],
                                                          //   //     jobLevel:
                                                          //   //     experience[
                                                          //   //     'jobLevel'],
                                                          //   //     jobFunction:
                                                          //   //     experience[
                                                          //   //     'jobFunction'],
                                                          //   //     startDate:
                                                          //   //     startDate,
                                                          //   //     endDate: endDate,
                                                          //   //     isCurrentlyWorking:
                                                          //   //     experience[
                                                          //   //     'endDate'] ==
                                                          //   //         'Present',
                                                          //   //     index:
                                                          //   //     index, // Pass the index for updating the correct item
                                                          //   //   );
                                                          //   //
                                                          //   //   // Navigate to work experience screen using named route
                                                          //   //   Navigator.push(
                                                          //   //     context,
                                                          //   //     MaterialPageRoute(
                                                          //   //       builder: (context) =>
                                                          //   //           MultiProvider(
                                                          //   //             providers: [
                                                          //   //               ChangeNotifierProvider
                                                          //   //                   .value(
                                                          //   //                   value:
                                                          //   //                   provider),
                                                          //   //               ChangeNotifierProvider.value(
                                                          //   //                   value: Provider.of<
                                                          //   //                       ProfileBottommenuProvider>(
                                                          //   //                       context,
                                                          //   //                       listen:
                                                          //   //                       false)),
                                                          //   //             ],
                                                          //   //             child:
                                                          //   //             const WorkExperienceScreen(),
                                                          //   //           ),
                                                          //   //     ),
                                                          //   //   );
                                                          //   // },
                                                          //   child: Image.asset(
                                                          //     "assets/images/Edit.png",
                                                          //     height: 2.h,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 0.5.h),
                                                      Text(
                                                        employment.position,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize14,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyMedium,
                                                        ),
                                                      ),
                                                      SizedBox(height: 0.5.h),
                                                      Text(employment.startDate +" - "+employment.endDate,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize14,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyMedium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),


                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Image.asset(IconPath,
                                              //   height: 2.h,
                                              // ),
                                              // SizedBox(width: 3.w),
                                              Text("Responsibilities: ",
                                                style: TextStyle(
                                                    fontSize: AppFontSize.fontSize16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.Color_212121,
                                                    fontFamily:
                                                    AppColors.fontFamilyMedium),
                                              ),
                                              Expanded(
                                                child: Text(employment.responsibilities,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: AppFontSize.fontSize16,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.Color_212121,
                                                      fontFamily:
                                                      AppColors.fontFamilyMedium),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 3.h),
                                        ],
                                      );
                                    },
                                  ),
                                  // References Section
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "References",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.experienceInfo!.references.length,
                                    itemBuilder: (context, index) {
                                      var reference = profileProvider.experienceInfo!.references[index];
                                      return Container(
                                          margin: EdgeInsets.only(bottom: 1.h),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 15.w,
                                                height: 15.w,
                                                decoration: BoxDecoration(
                                                  color: AppColors.cardIconBgColour,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/images/profileActive.png",
                                                    height: 6.w,
                                                    width: 6.w,
                                                    color: AppColors.buttonColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 3.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      reference.vesselOrCompanyName,
                                                      style: TextStyle(
                                                        fontSize:
                                                        AppFontSize.fontSize20,
                                                        fontWeight: FontWeight.w700,
                                                        color: AppColors.Color_212121,
                                                        fontFamily: AppColors
                                                            .fontFamilyBold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 0.8.h),
                                                    Text(reference.issuedBy,
                                                      style: TextStyle(
                                                        fontSize:
                                                        AppFontSize.fontSize14,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColors
                                                            .Color_424242,
                                                        fontFamily: AppColors
                                                            .fontFamilyMedium,
                                                      ),
                                                    ),
                                                    SizedBox(height: 0.8.h),
                                                    Text(
                                                      reference.issuingDate,
                                                      style: TextStyle(
                                                        fontSize:
                                                        AppFontSize.fontSize14,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColors
                                                            .Color_424242,
                                                        fontFamily: AppColors
                                                            .fontFamilyMedium,
                                                      ),
                                                    ),
                                                    SizedBox(height: 0.8.h),
                                                    Text(
                                                      reference.documentUrl,
                                                      style: TextStyle(
                                                        fontSize:
                                                        AppFontSize.fontSize14,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColors
                                                            .Color_424242,
                                                        fontFamily: AppColors
                                                            .fontFamilyMedium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     final provider = Provider.of<ReferencesProvider>(context, listen: false);
                                              //     final reference = profileProvider.references[index];
                                              //
                                              //     // Initialize the provider with the reference data
                                              //     provider.initializeWithData(reference);
                                              //
                                              //     // Navigate to References Screen
                                              //     Navigator.of(context).pushNamed(referencesScreen);
                                              //   },
                                              //   child: Image.asset(
                                              //     "assets/images/Edit.png",
                                              //     height: 2.h,
                                              //     color: AppColors.buttonColor,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        );

                                      //   Column(
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: [
                                      //
                                      //
                                      //
                                      //
                                      //     LabelView(
                                      //         "assets/images/DocumentIcon.png",
                                      //         reference.issuedBy,
                                      //         label: "  Issued By: "
                                      //     ),
                                      //     LabelView(
                                      //         "assets/images/Calendar.png",
                                      //         reference.issuingDate.toString().split(" ")[0],
                                      //         label: "  Issuing Date: "
                                      //     ),
                                      //     LabelView(
                                      //         "assets/images/WorkActive.png",
                                      //         reference.vesselOrCompanyName,
                                      //         label: "  Vessel/Company Name: "
                                      //     ),
                                      //     // Display document URL for file (can be a link or button to open the file)
                                      //     LabelView(
                                      //         "assets/images/DocumentIcon.png",
                                      //         reference.documentUrl,
                                      //         label: "  Document: "
                                      //     ),
                                      //   ],
                                      // );
                                    },
                                  ),
                                ],
                              ),
                            ),

                          if (index == 2 && profileProvider.travelDocsInfo != null && profileProvider.getSectionStatus(section["title"]))
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dividerRow(),
                                  // Seafarer Registration No.
                                  LabelView(
                                      "assets/images/LocationBlack.png",
                                      profileProvider.travelDocsInfo!.seafarerRegistrationNo,
                                      label: "Seafarer’s Registration No.: "
                                  ),
                                  // Passport Details
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Passport",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.1.h,
                                                      color: AppColors
                                                          .Color_EEEEEE),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      2.h)),
                                              padding: EdgeInsets.all(1.2.h),
                                              child: Image.asset(
                                                "assets/images/companyLogo.png",
                                                height: 5.h,
                                                width: 5.h,
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Container(
                                              // color:Colors.red,
                                              width: 64.w,
                                              margin:
                                              EdgeInsets.only(bottom: 2.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(profileProvider.travelDocsInfo!.passport.passportNo,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize20,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyBold,
                                                        ),
                                                      ),
                                                      // GestureDetector(
                                                      //   // onTap: () {
                                                      //   //   final provider = Provider
                                                      //   //       .of<WorkExperienceProvider>(
                                                      //   //       context,
                                                      //   //       listen:
                                                      //   //       false);
                                                      //   //
                                                      //   //   // Parse dates
                                                      //   //   DateTime? startDate;
                                                      //   //   DateTime? endDate;
                                                      //   //
                                                      //   //   if (experience[
                                                      //   //   'startDate'] !=
                                                      //   //       null) {
                                                      //   //     try {
                                                      //   //       startDate = DateFormat(
                                                      //   //           'MM/yyyy')
                                                      //   //           .parse(experience[
                                                      //   //       'startDate']);
                                                      //   //     } catch (e) {
                                                      //   //       print(
                                                      //   //           'Error parsing start date: $e');
                                                      //   //     }
                                                      //   //   }
                                                      //   //
                                                      //   //   if (experience[
                                                      //   //   'endDate'] !=
                                                      //   //       null &&
                                                      //   //       experience[
                                                      //   //       'endDate'] !=
                                                      //   //           'Present') {
                                                      //   //     try {
                                                      //   //       endDate = DateFormat(
                                                      //   //           'MM/yyyy')
                                                      //   //           .parse(experience[
                                                      //   //       'endDate']);
                                                      //   //     } catch (e) {
                                                      //   //       print(
                                                      //   //           'Error parsing end date: $e');
                                                      //   //     }
                                                      //   //   }
                                                      //   //
                                                      //   //   // Initialize provider with work experience data
                                                      //   //   provider
                                                      //   //       .initializeWithData(
                                                      //   //     title: experience[
                                                      //   //     'title'] ??
                                                      //   //         '',
                                                      //   //     company: experience[
                                                      //   //     'company'] ??
                                                      //   //         '',
                                                      //   //     location:
                                                      //   //     experience[
                                                      //   //     'location'],
                                                      //   //     description:
                                                      //   //     experience[
                                                      //   //     'description'],
                                                      //   //     employmentType:
                                                      //   //     experience[
                                                      //   //     'employmentType'],
                                                      //   //     jobLevel:
                                                      //   //     experience[
                                                      //   //     'jobLevel'],
                                                      //   //     jobFunction:
                                                      //   //     experience[
                                                      //   //     'jobFunction'],
                                                      //   //     startDate:
                                                      //   //     startDate,
                                                      //   //     endDate: endDate,
                                                      //   //     isCurrentlyWorking:
                                                      //   //     experience[
                                                      //   //     'endDate'] ==
                                                      //   //         'Present',
                                                      //   //     index:
                                                      //   //     index, // Pass the index for updating the correct item
                                                      //   //   );
                                                      //   //
                                                      //   //   // Navigate to work experience screen using named route
                                                      //   //   Navigator.push(
                                                      //   //     context,
                                                      //   //     MaterialPageRoute(
                                                      //   //       builder: (context) =>
                                                      //   //           MultiProvider(
                                                      //   //             providers: [
                                                      //   //               ChangeNotifierProvider
                                                      //   //                   .value(
                                                      //   //                   value:
                                                      //   //                   provider),
                                                      //   //               ChangeNotifierProvider.value(
                                                      //   //                   value: Provider.of<
                                                      //   //                       ProfileBottommenuProvider>(
                                                      //   //                       context,
                                                      //   //                       listen:
                                                      //   //                       false)),
                                                      //   //             ],
                                                      //   //             child:
                                                      //   //             const WorkExperienceScreen(),
                                                      //   //           ),
                                                      //   //     ),
                                                      //   //   );
                                                      //   // },
                                                      //   child: Image.asset(
                                                      //     "assets/images/Edit.png",
                                                      //     height: 2.h,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    profileProvider.travelDocsInfo!.passport.country,
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(profileProvider.travelDocsInfo!.passport.issueDate.toString() +" - "+profileProvider.travelDocsInfo!.passport.expDate.toString(),
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: 3.h),
                                    ],
                                  ),
                                 // Seaman's Book Details
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Seaman’s Book",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.1.h,
                                                      color: AppColors
                                                          .Color_EEEEEE),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      2.h)),
                                              padding: EdgeInsets.all(1.2.h),
                                              child: Image.asset(
                                                "assets/images/companyLogo.png",
                                                height: 5.h,
                                                width: 5.h,
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Container(
                                              // color:Colors.red,
                                              width: 64.w,
                                              margin:
                                              EdgeInsets.only(bottom: 2.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(profileProvider.travelDocsInfo!.seamanBook.seamanBookNo,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize20,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyBold,
                                                        ),
                                                      ),
                                                      // GestureDetector(
                                                      //   // onTap: () {
                                                      //   //   final provider = Provider
                                                      //   //       .of<WorkExperienceProvider>(
                                                      //   //       context,
                                                      //   //       listen:
                                                      //   //       false);
                                                      //   //
                                                      //   //   // Parse dates
                                                      //   //   DateTime? startDate;
                                                      //   //   DateTime? endDate;
                                                      //   //
                                                      //   //   if (experience[
                                                      //   //   'startDate'] !=
                                                      //   //       null) {
                                                      //   //     try {
                                                      //   //       startDate = DateFormat(
                                                      //   //           'MM/yyyy')
                                                      //   //           .parse(experience[
                                                      //   //       'startDate']);
                                                      //   //     } catch (e) {
                                                      //   //       print(
                                                      //   //           'Error parsing start date: $e');
                                                      //   //     }
                                                      //   //   }
                                                      //   //
                                                      //   //   if (experience[
                                                      //   //   'endDate'] !=
                                                      //   //       null &&
                                                      //   //       experience[
                                                      //   //       'endDate'] !=
                                                      //   //           'Present') {
                                                      //   //     try {
                                                      //   //       endDate = DateFormat(
                                                      //   //           'MM/yyyy')
                                                      //   //           .parse(experience[
                                                      //   //       'endDate']);
                                                      //   //     } catch (e) {
                                                      //   //       print(
                                                      //   //           'Error parsing end date: $e');
                                                      //   //     }
                                                      //   //   }
                                                      //   //
                                                      //   //   // Initialize provider with work experience data
                                                      //   //   provider
                                                      //   //       .initializeWithData(
                                                      //   //     title: experience[
                                                      //   //     'title'] ??
                                                      //   //         '',
                                                      //   //     company: experience[
                                                      //   //     'company'] ??
                                                      //   //         '',
                                                      //   //     location:
                                                      //   //     experience[
                                                      //   //     'location'],
                                                      //   //     description:
                                                      //   //     experience[
                                                      //   //     'description'],
                                                      //   //     employmentType:
                                                      //   //     experience[
                                                      //   //     'employmentType'],
                                                      //   //     jobLevel:
                                                      //   //     experience[
                                                      //   //     'jobLevel'],
                                                      //   //     jobFunction:
                                                      //   //     experience[
                                                      //   //     'jobFunction'],
                                                      //   //     startDate:
                                                      //   //     startDate,
                                                      //   //     endDate: endDate,
                                                      //   //     isCurrentlyWorking:
                                                      //   //     experience[
                                                      //   //     'endDate'] ==
                                                      //   //         'Present',
                                                      //   //     index:
                                                      //   //     index, // Pass the index for updating the correct item
                                                      //   //   );
                                                      //   //
                                                      //   //   // Navigate to work experience screen using named route
                                                      //   //   Navigator.push(
                                                      //   //     context,
                                                      //   //     MaterialPageRoute(
                                                      //   //       builder: (context) =>
                                                      //   //           MultiProvider(
                                                      //   //             providers: [
                                                      //   //               ChangeNotifierProvider
                                                      //   //                   .value(
                                                      //   //                   value:
                                                      //   //                   provider),
                                                      //   //               ChangeNotifierProvider.value(
                                                      //   //                   value: Provider.of<
                                                      //   //                       ProfileBottommenuProvider>(
                                                      //   //                       context,
                                                      //   //                       listen:
                                                      //   //                       false)),
                                                      //   //             ],
                                                      //   //             child:
                                                      //   //             const WorkExperienceScreen(),
                                                      //   //           ),
                                                      //   //     ),
                                                      //   //   );
                                                      //   // },
                                                      //   child: Image.asset(
                                                      //     "assets/images/Edit.png",
                                                      //     height: 2.h,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    profileProvider.travelDocsInfo!.seamanBook.issuingCountry,
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    profileProvider.travelDocsInfo!.seamanBook.issuingAuthority,
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(profileProvider.travelDocsInfo!.seamanBook.issueDate.toString() +" - "+profileProvider.travelDocsInfo!.seamanBook.expDate.toString(),
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: 3.h),
                                    ],
                                  ),

                                  // LabelView("assets/images/DocumentIcon.png", profileProvider.travelDocsInfo!.seamanBook.seamanBookNo, label: "Seaman’s Book No.: "),
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.travelDocsInfo!.seamanBook.issuingCountry, label: "Issuing Country: "),
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.travelDocsInfo!.seamanBook.issuingAuthority, label: "Issuing Authority: "),
                                  // LabelView("assets/images/Calendar.png", profileProvider.travelDocsInfo!.seamanBook.issueDate.toString(), label: "Issue Date: "),
                                  // LabelView("assets/images/Calendar.png", profileProvider.travelDocsInfo!.seamanBook.expDate.toString(), label: "Expiry Date: "),
                                  // profileProvider.travelDocsInfo!.seamanBook.neverExpire
                                  //     ? LabelView("assets/images/LocationBlack.png", "Never Expire", label: "Expiry: ")
                                  //     : Container(),
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.travelDocsInfo!.seamanBook.nationality, label: "Nationality: "),
                                  // Seafarer's Visa Details
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Valid Seafarer’s Visa",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.1.h,
                                                      color: AppColors
                                                          .Color_EEEEEE),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      2.h)),
                                              padding: EdgeInsets.all(1.2.h),
                                              child: Image.asset(
                                                "assets/images/companyLogo.png",
                                                height: 5.h,
                                                width: 5.h,
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Container(
                                              // color:Colors.red,
                                              width: 64.w,
                                              margin:
                                              EdgeInsets.only(bottom: 2.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(profileProvider.travelDocsInfo!.validSeafarerVisa.visaNo,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize20,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyBold,
                                                        ),
                                                      ),
                                                      // GestureDetector(
                                                      //   // onTap: () {
                                                      //   //   final provider = Provider
                                                      //   //       .of<WorkExperienceProvider>(
                                                      //   //       context,
                                                      //   //       listen:
                                                      //   //       false);
                                                      //   //
                                                      //   //   // Parse dates
                                                      //   //   DateTime? startDate;
                                                      //   //   DateTime? endDate;
                                                      //   //
                                                      //   //   if (experience[
                                                      //   //   'startDate'] !=
                                                      //   //       null) {
                                                      //   //     try {
                                                      //   //       startDate = DateFormat(
                                                      //   //           'MM/yyyy')
                                                      //   //           .parse(experience[
                                                      //   //       'startDate']);
                                                      //   //     } catch (e) {
                                                      //   //       print(
                                                      //   //           'Error parsing start date: $e');
                                                      //   //     }
                                                      //   //   }
                                                      //   //
                                                      //   //   if (experience[
                                                      //   //   'endDate'] !=
                                                      //   //       null &&
                                                      //   //       experience[
                                                      //   //       'endDate'] !=
                                                      //   //           'Present') {
                                                      //   //     try {
                                                      //   //       endDate = DateFormat(
                                                      //   //           'MM/yyyy')
                                                      //   //           .parse(experience[
                                                      //   //       'endDate']);
                                                      //   //     } catch (e) {
                                                      //   //       print(
                                                      //   //           'Error parsing end date: $e');
                                                      //   //     }
                                                      //   //   }
                                                      //   //
                                                      //   //   // Initialize provider with work experience data
                                                      //   //   provider
                                                      //   //       .initializeWithData(
                                                      //   //     title: experience[
                                                      //   //     'title'] ??
                                                      //   //         '',
                                                      //   //     company: experience[
                                                      //   //     'company'] ??
                                                      //   //         '',
                                                      //   //     location:
                                                      //   //     experience[
                                                      //   //     'location'],
                                                      //   //     description:
                                                      //   //     experience[
                                                      //   //     'description'],
                                                      //   //     employmentType:
                                                      //   //     experience[
                                                      //   //     'employmentType'],
                                                      //   //     jobLevel:
                                                      //   //     experience[
                                                      //   //     'jobLevel'],
                                                      //   //     jobFunction:
                                                      //   //     experience[
                                                      //   //     'jobFunction'],
                                                      //   //     startDate:
                                                      //   //     startDate,
                                                      //   //     endDate: endDate,
                                                      //   //     isCurrentlyWorking:
                                                      //   //     experience[
                                                      //   //     'endDate'] ==
                                                      //   //         'Present',
                                                      //   //     index:
                                                      //   //     index, // Pass the index for updating the correct item
                                                      //   //   );
                                                      //   //
                                                      //   //   // Navigate to work experience screen using named route
                                                      //   //   Navigator.push(
                                                      //   //     context,
                                                      //   //     MaterialPageRoute(
                                                      //   //       builder: (context) =>
                                                      //   //           MultiProvider(
                                                      //   //             providers: [
                                                      //   //               ChangeNotifierProvider
                                                      //   //                   .value(
                                                      //   //                   value:
                                                      //   //                   provider),
                                                      //   //               ChangeNotifierProvider.value(
                                                      //   //                   value: Provider.of<
                                                      //   //                       ProfileBottommenuProvider>(
                                                      //   //                       context,
                                                      //   //                       listen:
                                                      //   //                       false)),
                                                      //   //             ],
                                                      //   //             child:
                                                      //   //             const WorkExperienceScreen(),
                                                      //   //           ),
                                                      //   //     ),
                                                      //   //   );
                                                      //   // },
                                                      //   child: Image.asset(
                                                      //     "assets/images/Edit.png",
                                                      //     height: 2.h,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    profileProvider.travelDocsInfo!.validSeafarerVisa.issuingCountry,
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(profileProvider.travelDocsInfo!.validSeafarerVisa.issuingDate.toString() +" - "+profileProvider.travelDocsInfo!.validSeafarerVisa.expDate.toString(),
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: 3.h),
                                    ],
                                  ),
                                // Visa Details
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Visa",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.1.h,
                                                      color: AppColors
                                                          .Color_EEEEEE),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      2.h)),
                                              padding: EdgeInsets.all(1.2.h),
                                              child: Image.asset(
                                                "assets/images/companyLogo.png",
                                                height: 5.h,
                                                width: 5.h,
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Container(
                                              // color:Colors.red,
                                              width: 64.w,
                                              margin:
                                              EdgeInsets.only(bottom: 2.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(profileProvider.travelDocsInfo!.visa.visaNo,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize20,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyBold,
                                                        ),
                                                      ),
                                                      // GestureDetector(
                                                      //   // onTap: () {
                                                      //   //   final provider = Provider
                                                      //   //       .of<WorkExperienceProvider>(
                                                      //   //       context,
                                                      //   //       listen:
                                                      //   //       false);
                                                      //   //
                                                      //   //   // Parse dates
                                                      //   //   DateTime? startDate;
                                                      //   //   DateTime? endDate;
                                                      //   //
                                                      //   //   if (experience[
                                                      //   //   'startDate'] !=
                                                      //   //       null) {
                                                      //   //     try {
                                                      //   //       startDate = DateFormat(
                                                      //   //           'MM/yyyy')
                                                      //   //           .parse(experience[
                                                      //   //       'startDate']);
                                                      //   //     } catch (e) {
                                                      //   //       print(
                                                      //   //           'Error parsing start date: $e');
                                                      //   //     }
                                                      //   //   }
                                                      //   //
                                                      //   //   if (experience[
                                                      //   //   'endDate'] !=
                                                      //   //       null &&
                                                      //   //       experience[
                                                      //   //       'endDate'] !=
                                                      //   //           'Present') {
                                                      //   //     try {
                                                      //   //       endDate = DateFormat(
                                                      //   //           'MM/yyyy')
                                                      //   //           .parse(experience[
                                                      //   //       'endDate']);
                                                      //   //     } catch (e) {
                                                      //   //       print(
                                                      //   //           'Error parsing end date: $e');
                                                      //   //     }
                                                      //   //   }
                                                      //   //
                                                      //   //   // Initialize provider with work experience data
                                                      //   //   provider
                                                      //   //       .initializeWithData(
                                                      //   //     title: experience[
                                                      //   //     'title'] ??
                                                      //   //         '',
                                                      //   //     company: experience[
                                                      //   //     'company'] ??
                                                      //   //         '',
                                                      //   //     location:
                                                      //   //     experience[
                                                      //   //     'location'],
                                                      //   //     description:
                                                      //   //     experience[
                                                      //   //     'description'],
                                                      //   //     employmentType:
                                                      //   //     experience[
                                                      //   //     'employmentType'],
                                                      //   //     jobLevel:
                                                      //   //     experience[
                                                      //   //     'jobLevel'],
                                                      //   //     jobFunction:
                                                      //   //     experience[
                                                      //   //     'jobFunction'],
                                                      //   //     startDate:
                                                      //   //     startDate,
                                                      //   //     endDate: endDate,
                                                      //   //     isCurrentlyWorking:
                                                      //   //     experience[
                                                      //   //     'endDate'] ==
                                                      //   //         'Present',
                                                      //   //     index:
                                                      //   //     index, // Pass the index for updating the correct item
                                                      //   //   );
                                                      //   //
                                                      //   //   // Navigate to work experience screen using named route
                                                      //   //   Navigator.push(
                                                      //   //     context,
                                                      //   //     MaterialPageRoute(
                                                      //   //       builder: (context) =>
                                                      //   //           MultiProvider(
                                                      //   //             providers: [
                                                      //   //               ChangeNotifierProvider
                                                      //   //                   .value(
                                                      //   //                   value:
                                                      //   //                   provider),
                                                      //   //               ChangeNotifierProvider.value(
                                                      //   //                   value: Provider.of<
                                                      //   //                       ProfileBottommenuProvider>(
                                                      //   //                       context,
                                                      //   //                       listen:
                                                      //   //                       false)),
                                                      //   //             ],
                                                      //   //             child:
                                                      //   //             const WorkExperienceScreen(),
                                                      //   //           ),
                                                      //   //     ),
                                                      //   //   );
                                                      //   // },
                                                      //   child: Image.asset(
                                                      //     "assets/images/Edit.png",
                                                      //     height: 2.h,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    profileProvider.travelDocsInfo!.visa.issuingCountry,
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(profileProvider.travelDocsInfo!.visa.issuingDate.toString() +" - "+profileProvider.travelDocsInfo!.visa.expDate.toString(),
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: 3.h),
                                    ],
                                  ),
                                  // Residence Permit Details
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Residence Permit",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.1.h,
                                                      color: AppColors
                                                          .Color_EEEEEE),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      2.h)),
                                              padding: EdgeInsets.all(1.2.h),
                                              child: Image.asset(
                                                "assets/images/companyLogo.png",
                                                height: 5.h,
                                                width: 5.h,
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Container(
                                              // color:Colors.red,
                                              width: 64.w,
                                              margin:
                                              EdgeInsets.only(bottom: 2.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(profileProvider.travelDocsInfo!.residencePermit.permitNo,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize20,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyBold,
                                                        ),
                                                      ),
                                                      // GestureDetector(
                                                      //   // onTap: () {
                                                      //   //   final provider = Provider
                                                      //   //       .of<WorkExperienceProvider>(
                                                      //   //       context,
                                                      //   //       listen:
                                                      //   //       false);
                                                      //   //
                                                      //   //   // Parse dates
                                                      //   //   DateTime? startDate;
                                                      //   //   DateTime? endDate;
                                                      //   //
                                                      //   //   if (experience[
                                                      //   //   'startDate'] !=
                                                      //   //       null) {
                                                      //   //     try {
                                                      //   //       startDate = DateFormat(
                                                      //   //           'MM/yyyy')
                                                      //   //           .parse(experience[
                                                      //   //       'startDate']);
                                                      //   //     } catch (e) {
                                                      //   //       print(
                                                      //   //           'Error parsing start date: $e');
                                                      //   //     }
                                                      //   //   }
                                                      //   //
                                                      //   //   if (experience[
                                                      //   //   'endDate'] !=
                                                      //   //       null &&
                                                      //   //       experience[
                                                      //   //       'endDate'] !=
                                                      //   //           'Present') {
                                                      //   //     try {
                                                      //   //       endDate = DateFormat(
                                                      //   //           'MM/yyyy')
                                                      //   //           .parse(experience[
                                                      //   //       'endDate']);
                                                      //   //     } catch (e) {
                                                      //   //       print(
                                                      //   //           'Error parsing end date: $e');
                                                      //   //     }
                                                      //   //   }
                                                      //   //
                                                      //   //   // Initialize provider with work experience data
                                                      //   //   provider
                                                      //   //       .initializeWithData(
                                                      //   //     title: experience[
                                                      //   //     'title'] ??
                                                      //   //         '',
                                                      //   //     company: experience[
                                                      //   //     'company'] ??
                                                      //   //         '',
                                                      //   //     location:
                                                      //   //     experience[
                                                      //   //     'location'],
                                                      //   //     description:
                                                      //   //     experience[
                                                      //   //     'description'],
                                                      //   //     employmentType:
                                                      //   //     experience[
                                                      //   //     'employmentType'],
                                                      //   //     jobLevel:
                                                      //   //     experience[
                                                      //   //     'jobLevel'],
                                                      //   //     jobFunction:
                                                      //   //     experience[
                                                      //   //     'jobFunction'],
                                                      //   //     startDate:
                                                      //   //     startDate,
                                                      //   //     endDate: endDate,
                                                      //   //     isCurrentlyWorking:
                                                      //   //     experience[
                                                      //   //     'endDate'] ==
                                                      //   //         'Present',
                                                      //   //     index:
                                                      //   //     index, // Pass the index for updating the correct item
                                                      //   //   );
                                                      //   //
                                                      //   //   // Navigate to work experience screen using named route
                                                      //   //   Navigator.push(
                                                      //   //     context,
                                                      //   //     MaterialPageRoute(
                                                      //   //       builder: (context) =>
                                                      //   //           MultiProvider(
                                                      //   //             providers: [
                                                      //   //               ChangeNotifierProvider
                                                      //   //                   .value(
                                                      //   //                   value:
                                                      //   //                   provider),
                                                      //   //               ChangeNotifierProvider.value(
                                                      //   //                   value: Provider.of<
                                                      //   //                       ProfileBottommenuProvider>(
                                                      //   //                       context,
                                                      //   //                       listen:
                                                      //   //                       false)),
                                                      //   //             ],
                                                      //   //             child:
                                                      //   //             const WorkExperienceScreen(),
                                                      //   //           ),
                                                      //   //     ),
                                                      //   //   );
                                                      //   // },
                                                      //   child: Image.asset(
                                                      //     "assets/images/Edit.png",
                                                      //     height: 2.h,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    profileProvider.travelDocsInfo!.residencePermit.issuingCountry,
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(profileProvider.travelDocsInfo!.residencePermit.issuingDate.toString() +" - "+profileProvider.travelDocsInfo!.residencePermit.expDate.toString(),
                                                    style: TextStyle(
                                                      fontSize: AppFontSize
                                                          .fontSize14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: 3.h),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          if (index == 3 && profileProvider.medicalDocsInfo != null && profileProvider.getSectionStatus(section["title"]))
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dividerRow(),
                                  // Medical Fitness Section
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Medical Fitness",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.medicalDocsInfo!.medicalFitness.length,
                                    itemBuilder: (context, index) {
                                      var medicalFitness = profileProvider.medicalDocsInfo!.medicalFitness[index];
                                      return Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: EdgeInsets.only(top: 1.h),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 0.1.h,
                                                              color: AppColors
                                                                  .Color_EEEEEE),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              2.h)),
                                                      padding: EdgeInsets.all(1.2.h),
                                                      child: Image.asset(
                                                        "assets/images/companyLogo.png",
                                                        height: 5.h,
                                                        width: 5.h,
                                                      ),
                                                    ),
                                                    SizedBox(width: 3.w),
                                                    Container(
                                                      // color:Colors.red,
                                                      width: 64.w,
                                                      margin:
                                                      EdgeInsets.only(bottom: 2.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Text(medicalFitness.documentType,
                                                                style: TextStyle(
                                                                  fontSize: AppFontSize
                                                                      .fontSize20,
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                  color: AppColors
                                                                      .Color_212121,
                                                                  fontFamily: AppColors
                                                                      .fontFamilyBold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 0.5.h),
                                                          Text(
                                                            medicalFitness.issuingClinic,
                                                            style: TextStyle(
                                                              fontSize: AppFontSize
                                                                  .fontSize14,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              color: AppColors
                                                                  .Color_212121,
                                                              fontFamily: AppColors
                                                                  .fontFamilyMedium,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0.5.h),
                                                          Text(medicalFitness.issuingDate +" - "+medicalFitness.expDate,
                                                            style: TextStyle(
                                                              fontSize: AppFontSize
                                                                  .fontSize14,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              color: AppColors
                                                                  .Color_212121,
                                                              fontFamily: AppColors
                                                                  .fontFamilyMedium,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                    },
                                  ),
                                  // Drug & Alcohol Test Section
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Drug & Alcohol Test",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.medicalDocsInfo!.drugAlcoholTest.length,
                                    itemBuilder: (context, index) {
                                      var drugAlcoholTest = profileProvider.medicalDocsInfo!.drugAlcoholTest[index];
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: EdgeInsets.only(top: 1.h),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.1.h,
                                                          color: AppColors
                                                              .Color_EEEEEE),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          2.h)),
                                                  padding: EdgeInsets.all(1.2.h),
                                                  child: Image.asset(
                                                    "assets/images/companyLogo.png",
                                                    height: 5.h,
                                                    width: 5.h,
                                                  ),
                                                ),
                                                SizedBox(width: 3.w),
                                                Container(
                                                  // color:Colors.red,
                                                  width: 64.w,
                                                  margin:
                                                  EdgeInsets.only(bottom: 2.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(drugAlcoholTest.documentType,
                                                            style: TextStyle(
                                                              fontSize: AppFontSize
                                                                  .fontSize20,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              color: AppColors
                                                                  .Color_212121,
                                                              fontFamily: AppColors
                                                                  .fontFamilyBold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 0.5.h),
                                                      Text(
                                                        drugAlcoholTest.issuingClinic,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize14,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyMedium,
                                                        ),
                                                      ),
                                                      SizedBox(height: 0.5.h),
                                                      Text(drugAlcoholTest.issuingDate +" - "+drugAlcoholTest.expDate,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize14,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyMedium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  // Vaccination Certificates Section
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Vaccination Certificates",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.medicalDocsInfo!.vaccinationCertificates.length,
                                    itemBuilder: (context, index) {
                                      var vaccinationCertificate = profileProvider.medicalDocsInfo!.vaccinationCertificates[index];
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: EdgeInsets.only(top: 1.h),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.1.h,
                                                          color: AppColors
                                                              .Color_EEEEEE),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          2.h)),
                                                  padding: EdgeInsets.all(1.2.h),
                                                  child: Image.asset(
                                                    "assets/images/companyLogo.png",
                                                    height: 5.h,
                                                    width: 5.h,
                                                  ),
                                                ),
                                                SizedBox(width: 3.w),
                                                Container(
                                                  // color:Colors.red,
                                                  width: 64.w,
                                                  margin:
                                                  EdgeInsets.only(bottom: 2.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(vaccinationCertificate.documentType,
                                                            style: TextStyle(
                                                              fontSize: AppFontSize
                                                                  .fontSize20,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              color: AppColors
                                                                  .Color_212121,
                                                              fontFamily: AppColors
                                                                  .fontFamilyBold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 0.5.h),
                                                      Text(
                                                        vaccinationCertificate.issuingClinic,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize14,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyMedium,
                                                        ),
                                                      ),
                                                      SizedBox(height: 0.5.h),
                                                      Text(vaccinationCertificate.issuingDate +" - "+vaccinationCertificate.expDate,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize14,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyMedium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                          if (index == 4 && profileProvider.educationInfo != null && profileProvider.getSectionStatus(section["title"]))
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dividerRow(),
                                  // Academic Qualifications
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Academic Qualifications",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.educationInfo!.academicQualifications.length,
                                    itemBuilder: (context, index) {
                                      var academicQualification = profileProvider.educationInfo!.academicQualifications[index];
                                      return Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: EdgeInsets.only(top: 1.h),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 0.1.h,
                                                              color: AppColors
                                                                  .Color_EEEEEE),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              2.h)),
                                                      padding: EdgeInsets.all(1.2.h),
                                                      child: Image.asset(
                                                        "assets/images/companyLogo.png",
                                                        height: 5.h,
                                                        width: 5.h,
                                                      ),
                                                    ),
                                                    SizedBox(width: 3.w),
                                                    Container(
                                                      // color:Colors.red,
                                                      width: 64.w,
                                                      margin:
                                                      EdgeInsets.only(bottom: 2.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(academicQualification.educationalDegree,
                                                                  style: TextStyle(
                                                                    fontSize: AppFontSize
                                                                        .fontSize20,
                                                                    fontWeight:
                                                                    FontWeight.w700,
                                                                    color: AppColors
                                                                        .Color_212121,
                                                                    fontFamily: AppColors
                                                                        .fontFamilyBold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 0.5.h),
                                                          Text(
                                                            academicQualification.educationalInstitution,
                                                            style: TextStyle(
                                                              fontSize: AppFontSize
                                                                  .fontSize14,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              color: AppColors
                                                                  .Color_212121,
                                                              fontFamily: AppColors
                                                                  .fontFamilyMedium,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0.5.h),
                                                          Text(academicQualification.graduationDate,
                                                            style: TextStyle(
                                                              fontSize: AppFontSize
                                                                  .fontSize14,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              color: AppColors
                                                                  .Color_212121,
                                                              fontFamily: AppColors
                                                                  .fontFamilyMedium,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 1.h),
                                            ],
                                          );
                                    },
                                  ),
                                  // Certifications and Trainings
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Certifications and Trainings",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.educationInfo!.certificationsAndTrainings.length,
                                    itemBuilder: (context, index) {
                                      var certificationTraining = profileProvider.educationInfo!.certificationsAndTrainings[index];
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: EdgeInsets.only(top: 1.h),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.1.h,
                                                          color: AppColors
                                                              .Color_EEEEEE),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          2.h)),
                                                  padding: EdgeInsets.all(1.2.h),
                                                  child: Image.asset(
                                                    "assets/images/companyLogo.png",
                                                    height: 5.h,
                                                    width: 5.h,
                                                  ),
                                                ),
                                                SizedBox(width: 3.w),
                                                Container(
                                                  // color:Colors.red,
                                                  width: 64.w,
                                                  margin:
                                                  EdgeInsets.only(bottom: 2.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(certificationTraining.certificationType,
                                                              style: TextStyle(
                                                                fontSize: AppFontSize
                                                                    .fontSize20,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                color: AppColors
                                                                    .Color_212121,
                                                                fontFamily: AppColors
                                                                    .fontFamilyBold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 0.5.h),
                                                      Text(
                                                        certificationTraining.issuingAuthority,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize14,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyMedium,
                                                        ),
                                                      ),
                                                      SizedBox(height: 0.5.h),
                                                      Text(certificationTraining.issueDate +" - "+ certificationTraining.expiryDate,
                                                        style: TextStyle(
                                                          fontSize: AppFontSize
                                                              .fontSize14,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: AppColors
                                                              .Color_212121,
                                                          fontFamily: AppColors
                                                              .fontFamilyMedium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                        ],
                                      );
                                    },
                                  ),
                                  // Languages Spoken
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Languages Spoken",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.educationInfo!.languagesSpoken.length,
                                    itemBuilder: (context, index) {
                                      var language = profileProvider.educationInfo!.languagesSpoken[index];
                                      return Container(
                                                        margin: EdgeInsets.only(top:1.h,bottom: 1.h),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              width: 15.w,
                                                              height: 15.w,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    width: 0.1.h,
                                                                    color: AppColors
                                                                        .Color_EEEEEE),
                                                                borderRadius:
                                                                    BorderRadius.circular(2.h),
                                                              ),
                                                              child: Center(
                                                                child: Image.asset(
                                                                  "assets/images/flag.png",
                                                                  // Replace with appropriate icon
                                                                  width: 8.w,
                                                                  height: 8.w,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 3.w),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    language.language,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          AppFontSize.fontSize16,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: AppColors.Color_212121,
                                                                      fontFamily: AppColors
                                                                          .fontFamilyBold,
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 0.5.h),
                                                                  Text(
                                                                    language.level,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          AppFontSize.fontSize14,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: AppColors.Color_212121,
                                                                      fontFamily: AppColors
                                                                          .fontFamilyMedium,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),


                          if (index == 5 && profileProvider.professionalSkillsInfo != null && profileProvider.getSectionStatus(section["title"]))
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dividerRow(),
                                  // Computer and Software Skills
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Computer and Software Skills",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.professionalSkillsInfo!.computerAndSoftwareSkills.length,
                                    itemBuilder: (context, index) {
                                      var softwareSkill = profileProvider.professionalSkillsInfo!.computerAndSoftwareSkills[index];
                                      return Container(
                                        margin: EdgeInsets.only(top:1.h,bottom: 1.h),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 15.w,
                                              height: 15.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.1.h,
                                                    color: AppColors
                                                        .Color_EEEEEE),
                                                borderRadius:
                                                BorderRadius.circular(2.h),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/images/TicketStar.png",
                                                  // Replace with appropriate icon
                                                  width: 8.w,
                                                  height: 8.w,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    softwareSkill.software,
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize16,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyBold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    softwareSkill.level,
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize14,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  // Cargo Experience
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Cargo Experience",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      LabelView("assets/images/LocationBlack.png", profileProvider.professionalSkillsInfo!.cargoExperience.bulkCargo ? "Yes" : "No", label: "Bulk Cargo: "),
                                      LabelView("assets/images/LocationBlack.png", profileProvider.professionalSkillsInfo!.cargoExperience.tankerCargo ? "Yes" : "No", label: "Tanker Cargo: "),
                                      LabelView("assets/images/LocationBlack.png", profileProvider.professionalSkillsInfo!.cargoExperience.generalCargo ? "Yes" : "No", label: "General Cargo: "),
                                      LabelView("assets/images/LocationBlack.png", profileProvider.professionalSkillsInfo!.cargoExperience.woodProducts ? "Yes" : "No", label: "Wood Products: "),
                                      LabelView("assets/images/LocationBlack.png", profileProvider.professionalSkillsInfo!.cargoExperience.stowageAndLashingExperience ? "Yes" : "No", label: "Stowage and Lashing: "),
                                    ],
                                  ),
                                  // Cargo Gear Experience
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Cargo Gear Experience",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.professionalSkillsInfo!.cargoGearExperience.length,
                                    itemBuilder: (context, index) {
                                      var cargoGear = profileProvider.professionalSkillsInfo!.cargoGearExperience[index];
                                      return Container(
                                        margin: EdgeInsets.only(top: 1.h,bottom: 1.h),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 15.w,
                                              height: 15.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.1.h,
                                                    color: AppColors
                                                        .Color_EEEEEE),
                                                borderRadius:
                                                BorderRadius.circular(2.h),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/images/TicketStar.png",
                                                  // Replace with appropriate icon
                                                  width: 8.w,
                                                  height: 8.w,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cargoGear.type,
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize16,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyBold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    cargoGear.maker,
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize14,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  // Metal Working Skills
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Metal Working Skills",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.professionalSkillsInfo!.metalWorkingSkills.length,
                                    itemBuilder: (context, index) {
                                      var metalSkill = profileProvider.professionalSkillsInfo!.metalWorkingSkills[index];
                                      return Container(
                                        margin: EdgeInsets.only(top: 1.h,bottom: 1.h),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 15.w,
                                              height: 15.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.1.h,
                                                    color: AppColors
                                                        .Color_EEEEEE),
                                                borderRadius:
                                                BorderRadius.circular(2.h),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/images/TicketStar.png",
                                                  // Replace with appropriate icon
                                                  width: 8.w,
                                                  height: 8.w,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    metalSkill.skillSelection,
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize16,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyBold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    metalSkill.level,
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize14,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  // Tank Coating Experience
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Tank Coating Experience",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:1.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Wrap(
                                            spacing: 2.w,
                                            // Space between chips horizontally
                                            runSpacing: 1.h,
                                            // Space between chips vertically
                                            children: profileProvider.professionalSkillsInfo!.tankCoatingExperience
                                                .map((tankCoatingExperience) => Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w, vertical: 1.h),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(50.h),
                                                border: Border.all(
                                                    color: AppColors.buttonColor,
                                                    width: 0.15.h),
                                              ),
                                              child: Text(
                                                tankCoatingExperience.type,
                                                style: TextStyle(
                                                  fontSize:
                                                  AppFontSize.fontSize14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.buttonColor,
                                                  fontFamily: AppColors
                                                      .fontFamilySemiBold,
                                                ),
                                              ),
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Port State Control Experience
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Port State Control Experience",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.professionalSkillsInfo!.portStateControlExperience.length,
                                    itemBuilder: (context, index) {
                                      var portStateControl = profileProvider.professionalSkillsInfo!.portStateControlExperience[index];
                                      return Container(
                                        margin: EdgeInsets.only(top: 1.h,bottom: 1.h),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 15.w,
                                              height: 15.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.1.h,
                                                    color: AppColors
                                                        .Color_EEEEEE),
                                                borderRadius:
                                                BorderRadius.circular(2.h),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/images/TicketStar.png",
                                                  // Replace with appropriate icon
                                                  width: 8.w,
                                                  height: 8.w,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    portStateControl.regionalAgreement,
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize16,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyBold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    portStateControl.port,
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize14,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    portStateControl.date.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize14,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  // Vetting Inspection Experience
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Vetting Inspection Experience",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.professionalSkillsInfo!.vettingInspectionExperience.length,
                                    itemBuilder: (context, index) {
                                      var vettingInspection = profileProvider.professionalSkillsInfo!.vettingInspectionExperience[index];
                                      return Container(
                                        margin: EdgeInsets.only(top: 1.h,bottom: 1.h),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 15.w,
                                              height: 15.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.1.h,
                                                    color: AppColors
                                                        .Color_EEEEEE),
                                                borderRadius:
                                                BorderRadius.circular(2.h),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/images/TicketStar.png",
                                                  // Replace with appropriate icon
                                                  width: 8.w,
                                                  height: 8.w,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    vettingInspection.inspectionBy,
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize16,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyBold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    vettingInspection.port,
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize14,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Text(
                                                    vettingInspection.date.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                      AppFontSize.fontSize14,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.Color_212121,
                                                      fontFamily: AppColors
                                                          .fontFamilyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  // Trading Area Experience
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Trading Area Experience",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:1.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Wrap(
                                            spacing: 2.w,
                                            // Space between chips horizontally
                                            runSpacing: 1.h,
                                            // Space between chips vertically
                                            children: profileProvider.professionalSkillsInfo!.tradingAreaExperience
                                                .map((tradingAreaExperience) => Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w, vertical: 1.h),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(50.h),
                                                border: Border.all(
                                                    color: AppColors.buttonColor,
                                                    width: 0.15.h),
                                              ),
                                              child: Text(
                                                tradingAreaExperience.tradingArea,
                                                style: TextStyle(
                                                  fontSize:
                                                  AppFontSize.fontSize14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.buttonColor,
                                                  fontFamily: AppColors
                                                      .fontFamilySemiBold,
                                                ),
                                              ),
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),


                          if (index == 6 && profileProvider.jobConditionsAndPreferencesInfo != null && profileProvider.getSectionStatus(section["title"]))
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dividerRow(),
                                  // Current Rank / Position
                                  LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.currentRankPosition, label: "Current Rank / Position: "),

                                  // Alternate Rank / Position
                                  LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.alternateRankPosition, label: "Alternate Rank / Position: "),

                                  // Preferred Vessel Type
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Preferred Vessel Type",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:1.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Wrap(
                                            spacing: 2.w,
                                            // Space between chips horizontally
                                            runSpacing: 1.h,
                                            // Space between chips vertically
                                            children: profileProvider.jobConditionsAndPreferencesInfo!.preferredVesselType
                                                .map((Area) => Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w, vertical: 1.h),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(50.h),
                                                border: Border.all(
                                                    color: AppColors.buttonColor,
                                                    width: 0.15.h),
                                              ),
                                              child: Text(
                                                Area,
                                                style: TextStyle(
                                                  fontSize:
                                                  AppFontSize.fontSize14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.buttonColor,
                                                  fontFamily: AppColors
                                                      .fontFamilySemiBold,
                                                ),
                                              ),
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Preferred Contract Type
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.preferredContractType, label: "Preferred Contract Type: "),

                                  // Preferred Position
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.preferredPosition, label: "Preferred Position: "),

                                  // Manning Agency
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.manningAgency, label: "Manning Agency: "),

                                  // Availability Section
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Availability",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.availability.currentAvailabilityStatus, label: "Current Availability Status: "),
                                  // LabelView("assets/images/Calendar.png", profileProvider.jobConditionsAndPreferencesInfo!.availability.availableFrom.toString(), label: "Available From: "),
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.availability.minOnBoardDuration.toString(), label: "Min. Onboard Duration (Months): "),
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.availability.maxOnBoardDuration.toString(), label: "Max. Onboard Duration (Months): "),
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.availability.minAtHomeDuration.toString(), label: "Min. At Home Duration (Months): "),
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.availability.maxAtHomeDuration.toString(), label: "Max. At Home Duration (Months): "),
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.availability.preferredRotationPattern, label: "Preferred Rotation Pattern: "),

                                  // Trading Area Exclusions
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Trading Area Exclusions",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:1.h),
                                    child: Row(
                                      children: [
                                                      Expanded(
                                                        child: Wrap(
                                                          spacing: 2.w,
                                                          // Space between chips horizontally
                                                          runSpacing: 1.h,
                                                          // Space between chips vertically
                                                          children: profileProvider.jobConditionsAndPreferencesInfo!.availability.tradingAreaExclusions
                                                              .map((area) => Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 4.w, vertical: 1.h),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(50.h),
                                                                      border: Border.all(
                                                                          color: AppColors.buttonColor,
                                                                          width: 0.15.h),
                                                                    ),
                                                                    child: Text(
                                                                      area,
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            AppFontSize.fontSize14,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: AppColors.buttonColor,
                                                                        fontFamily: AppColors
                                                                            .fontFamilySemiBold,
                                                                      ),
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                  ),
                                  // Salary Section
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      "Salary",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                  LabelView("assets/images/LocationBlack.png", '${profileProvider.jobConditionsAndPreferencesInfo!.salary.lastJobSalary.toString()} ${profileProvider.jobConditionsAndPreferencesInfo!.salary.currency}', label: "Last Job Salary: "),
                                  LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.salary.lastRankJoined, label: "Last Rank Joined: "),
                                  // LabelView("assets/images/Calendar.png", profileProvider.jobConditionsAndPreferencesInfo!.salary.lastPromotedDate.toString(), label: "Last Promoted Date: "),
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.salary.currency, label: "Currency: "),
                                  // LabelView("assets/images/DocumentIcon.png", profileProvider.jobConditionsAndPreferencesInfo!.salary.justificationDocumentUrl, label: "Justification Document: "),
                                  // LabelView("assets/images/LocationBlack.png", profileProvider.jobConditionsAndPreferencesInfo!.salary.industryStandardSalaryCalculator ? "Available" : "Not Available", label: "Industry Standard Salary Calculator: "),
                                ],
                              ),
                            ),

                          if (index == 7 && profileProvider.securityAndComplianceInfo != null && profileProvider.getSectionStatus(section["title"]))
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dividerRow(),
                                  // Contact Information Sharing Consent Toggle
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: Text(
                                          "Contact Information Sharing",
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.Color_212121,
                                            fontFamily: AppColors.fontFamilyMedium,
                                          ),
                                        ),
                                      ),
                                      Switch(
                                        activeColor: AppColors.buttonColor,
                                        value: profileProvider.securityAndComplianceInfo!.contactInfoSharing,
                                        onChanged: (value) {
                                          setState(() {
                                            profileProvider.securityAndComplianceInfo!.contactInfoSharing = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                  // Data Sharing Consent Toggle
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: Text(
                                          "Data Sharing",
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.Color_212121,
                                            fontFamily: AppColors.fontFamilyMedium,
                                          ),
                                        ),
                                      ),
                                      Switch(
                                        activeColor: AppColors.buttonColor,
                                        value: profileProvider.securityAndComplianceInfo!.dataSharing,
                                        onChanged: (value) {
                                          setState(() {
                                            profileProvider.securityAndComplianceInfo!.dataSharing = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                  // Professional Conduct Declaration Consent Toggle

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: Text(
                                          "Professional Conduct Declaration",
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.Color_212121,
                                            fontFamily: AppColors.fontFamilyMedium,
                                          ),
                                        ),
                                      ),
                                      Switch(
                                        activeColor: AppColors.buttonColor,
                                        value: profileProvider.securityAndComplianceInfo!.professionalConductDeclaration,
                                        onChanged: (value) {
                                          setState(() {
                                            profileProvider.securityAndComplianceInfo!.professionalConductDeclaration = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: .2.h),
                                    child: Text(
                                      "I declare that I have never been dismissed by any of my former employers due to drug or alcohol abuse, discrimination, sexual abuse, or any criminal action.",
                                      style: TextStyle(
                                        fontSize: AppFontSize.fontSize16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color_212121,
                                        fontFamily: AppColors.fontFamilyMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }




  dividerRow(){
    return  Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: 1.h, bottom: 1.h),
          height: 0.01.h,
          color: AppColors.Color_EEEEEE,
          width: 100.w,
        ),
    SizedBox(height: .5.h)
    ],
    );
    }


    LabelView(String IconPath, String LabelValue,{String? label}){
    return   Padding(
      padding:  EdgeInsets.only(top:1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset(IconPath,
          //   height: 2.h,
          // ),
          // SizedBox(width: 3.w),
          label!=null?Text(label,
            style: TextStyle(
                fontSize: AppFontSize.fontSize16,
                fontWeight: FontWeight.bold,
                color: AppColors.Color_212121,
                fontFamily:
                AppColors.fontFamilyMedium),
          ):Container(),
          Expanded(
            child: Text(LabelValue,
              maxLines: 2,
              style: TextStyle(
                  fontSize: AppFontSize.fontSize16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.Color_212121,
                  fontFamily:
                  AppColors.fontFamilyMedium),
            ),
          ),
        ],
      ),
    );
    }

}

// **Profile Section Widget**
Widget _buildProfileSection(
    ProfileBottommenuProvider provider, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          provider.pickProfileImage();
        },
        child: CircleAvatar(
          radius: 4.5.h,
          backgroundImage: provider.profileImage != null
              ? FileImage(provider
                  .profileImage!) // Use FileImage if user selected an image
              : const AssetImage("assets/images/profileImg.png")
                  as ImageProvider,
        ),
      ),
      SizedBox(width: 4.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(provider.userName,
                style: TextStyle(
                    fontSize: AppFontSize.fontSize24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.Color_212121)),
            SizedBox(height: 0.5.h),
            Text(provider.userRole,
                style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.Color_616161)),
          ],
        ),
      ),
      GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(editProfile);
          },
          child: Image.asset("assets/images/Edit.png", height: 2.5.h))
    ],
  );
}

