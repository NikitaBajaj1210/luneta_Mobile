import 'package:flutter/material.dart';
import 'package:luneta/const/font_size.dart';
import 'package:luneta/route/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../const/color.dart';
import '../../custom-component/back_button_with_title.dart';
import '../../custom-component/custom-button.dart';
import '../../provider/job-details-application-provider/job_details_provider.dart';

class JobDetailsScreen extends StatefulWidget {
  final String jobTitle;
  final String companyName;
  final String salaryRange;

  const JobDetailsScreen({
    super.key,
    required this.jobTitle,
    required this.companyName,
    required this.salaryRange,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {

  @override
  void initState() {
    super.initState();
    // final jobDetailsProvider = Provider.of<JobDetailsProvider>(context, listen: false);
  }


  void _showShareBottomSheet(BuildContext context,JobDetailsProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Transparent background to show rounded corner effect
      builder: (BuildContext context) {
        return Container(
          height: 35.h, // Adjust the height of the bottom sheet
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.h),
              topRight: Radius.circular(5.h),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 1.h,bottom: 1.5.h),
                height: 0.5.h,
                width: 10.w,
                decoration: BoxDecoration(
                    color: AppColors.greyDotColor,
                    borderRadius: BorderRadius.circular(10.h)),
              ),
              // Title of the Bottom Sheet
              Text(
                "Share",
                style: TextStyle(
                  fontSize: AppFontSize.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppColors.fontFamilyBold,
                  color:AppColors.Color_212121,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1.5.h, bottom: 2.5.h),
                height: 0.01.h,
                color: AppColors.Color_EEEEEE,
                width: 100.w,
              ),
              // Share Icons
              Expanded(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: provider.shareOptions.length, // Total items in the grid (icons)
                  itemBuilder: (context, index) {


                    return GestureDetector(
                      onTap: () {
                        // You can add your share logic here
                        print("Sharing via: ${provider.shareOptions[index]['label']}");
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            provider.shareOptions[index]["icon"]!,
                            height: 6.h,
                            width: 6.h,
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            provider.shareOptions[index]["label"]!,
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize12,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppColors.fontFamilyMedium,
                              color:AppColors.Color_212121,
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
  void _showApplyJobBottomSheet(BuildContext context,JobDetailsProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Transparent background to show rounded corner effect
      builder: (BuildContext context) {
        return Container(
          height: 22.h, // Adjust the height of the bottom sheet
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            color: AppColors.Color_FFFFFF,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.h),
              topRight: Radius.circular(5.h),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 1.h,bottom: 1.5.h),
                height: 0.5.h,
                width: 10.w,
                decoration: BoxDecoration(
                    color: AppColors.greyDotColor,
                    borderRadius: BorderRadius.circular(10.h)),
              ),
              // Title of the Bottom Sheet
              Text(
                "Apply Job",
                style: TextStyle(
                  fontSize: AppFontSize.fontSize24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppColors.fontFamilyBold,
                  color:AppColors.Color_212121,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1.5.h, bottom: 2.5.h),
                height: 0.01.h,
                color: AppColors.Color_EEEEEE,
                width: 100.w,
              ),
              // Share Icons
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
               customButton(
                 voidCallback: () async {
                   Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(applyJobCv);

                 },
                 buttonText: "Apply with CV",
                 width: 42.w,
                 height: 7.h,
                 color: AppColors.applyCVButtonColor,
                 buttonTextColor: AppColors.buttonColor,
                 shadowColor: AppColors.buttonBorderColor,
                 fontSize: AppFontSize.fontSize16,
                 showShadow: false,
               ),

               customButton(
                 voidCallback: () async {
                   Navigator.of(context).pop();
                   Navigator.of(context).pushNamed(applyJobProfile);
                 },
                 buttonText: "Apply with Profile",
                 width: 48.w,
                 height: 7.h,
                 color: AppColors.buttonColor,
                 buttonTextColor: AppColors.Color_FFFFFF,
                 shadowColor: AppColors.buttonBorderColor,
                 fontSize: AppFontSize.fontSize16,
                 showShadow: true,
               ),
             ],)
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JobDetailsProvider(),
      child: Consumer<JobDetailsProvider>(
        builder: (context, jobDetailsProvider, child) {
          return SafeArea(
            child: Scaffold(
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
                    _showApplyJobBottomSheet(context,jobDetailsProvider);
                    // Navigator.of(context).pushNamed('');
                    // Handle button click action
                  },
                  buttonText: "Apply",
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
                color:  AppColors.Color_FFFFFF,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h).copyWith(bottom: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header with Back Button and Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          backButtonWithTitle(
                            title: "",
                            onBackPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {

                                    jobDetailsProvider.toggleSaveStatus();
                                  // Show "Job Saved" popup
                                  _showJobSavedPopup(context);
                                },
                                child: Image.asset(
                                  jobDetailsProvider.isSaved
                                      ? "assets/images/saveActive.png"
                                      : "assets/images/saveInactive.png",
                                  height: 2.5.h,
                                  color:!jobDetailsProvider.isSaved?AppColors.Color_212121:AppColors.buttonColor,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              GestureDetector(
                                onTap: (){
                                  _showShareBottomSheet(context,jobDetailsProvider);
                                },
                                child: Image.asset(
                                  "assets/images/shareIcon.png",
                                  height: 2.5.h,
                                  color: AppColors.Color_212121,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      // Job Card
                      Container(
                        padding: EdgeInsets.all(3.h).copyWith(top: 2.5.h,bottom: 2.5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.h),
                          border: Border.all(
                            color: AppColors.Color_BDBDBD,
                            width: 0.8,
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Company Logo
                            Container(
                              padding: EdgeInsets.all(2.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
                                  border: Border.all(
                                    width: 0.1.h,color: AppColors.Color_BDBDBD,
                                  )),
                              child: Image.asset(
                                "assets/images/companyLogo.png",height: 4.5.h,),),
                            SizedBox(height: 1.h),
                            // Job Title
                            Text(
                              // jobDetailsProvider.jobTitle,
                              widget.jobTitle,
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize20,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppColors.fontFamilyBold,
                                color:AppColors.Color_212121,
                              ),
                            ),
                            SizedBox(height: 0.4.h),
                            // Company Name
                            Text(
                              // jobDetailsProvider.companyName,
                              widget.companyName,
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize18,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppColors.fontFamilySemiBold,
                                color: AppColors.blueText,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2.5.h, bottom: 2.4.h),
                              height: 0.01.h,
                              color: AppColors.Color_EEEEEE,
                              width: 100.w,
                            ),
                            // Location
                            Text(
                              jobDetailsProvider.location,
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize18,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppColors.fontFamilyMedium,
                                color: AppColors.Color_616161,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            // Salary Range
                            Text(
                              // jobDetailsProvider.salaryRange,
                              widget.salaryRange,
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize18,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppColors.fontFamilySemiBold,
                                color: AppColors.buttonColor,
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            // Tags
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: jobDetailsProvider.tags
                                  .map(
                                    (tag) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 1.h),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(1.h)),
                                          border: Border.all(
                                            width: 0.1.h,color: AppColors.Color_757575,
                                          )),
                                  child: Text(
                                    tag,
                                    style: TextStyle(
                                      fontSize: AppFontSize.fontSize12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppColors.fontFamilySemiBold,
                                      color: AppColors.Color_757575,
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                            SizedBox(height: (1.5).h),
                            Text(
                              "Posted ${jobDetailsProvider.postDate}, ends in ${jobDetailsProvider.endDate}.",
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize14,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppColors.fontFamilyMedium,
                                color: AppColors.Color_616161,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      _buildFilterTabs(jobDetailsProvider,context),
                      SizedBox(height: 2.h),
                      buildTabContent(jobDetailsProvider)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


Widget _buildFilterTabs(JobDetailsProvider provider,BuildContext context) {
  return SizedBox(
    height: 6.h,
    child: Stack(
      children: [
        Positioned(
          bottom: 1.2.h,
          left: 0,
          right: 0,

          child: Container(
            height: 0.3.h,
            color: AppColors.Color_BDBDBD,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(provider.tabs.length, (index) {
              final isSelected = provider.selectedTabIndex == index;
              return GestureDetector(
                onTap: () {
                  provider.setSelectedTabIndex(index);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Tab Text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w).copyWith(left: 0),
                      child: Text(
                        provider.tabs[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize18,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppColors.fontFamilySemiBold,
                          color: isSelected
                              ? AppColors.buttonColor
                              : AppColors.Color_9E9E9E,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.7.h), // Keeps spacing consistent
                    // Active Tab Underline (Dynamic Width)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: 0.4.h,
                      width: _calculateTextWidth(provider.tabs[index], context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.h),
                        color: isSelected ? AppColors.buttonColor : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );

}


double _calculateTextWidth(String text, BuildContext context) {
  TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: TextStyle(fontSize: AppFontSize.fontSize16, fontWeight: FontWeight.w600)),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.width + 5.w;
}

// Helper Method to Render Tab Content Dynamically
Widget buildTabContent(JobDetailsProvider jobDetailsProvider) {
  switch (jobDetailsProvider.selectedTabIndex) {
    case 0: // Job Description Tab
      return _buildJobDescription(jobDetailsProvider);
    case 1: // Minimum Qualifications Tab
      return _buildMinimumQualifications();
    case 2: // Perks Tab
      return _buildPerks();
    default:
      return Container();
  }
}

Widget _buildJobDescription(JobDetailsProvider jobDetailsProvider) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h).copyWith(top: 0.5.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Job Description:",
          style: TextStyle(
            fontSize: AppFontSize.fontSize20,
            fontFamily: AppColors.fontFamilyBold,
            fontWeight: FontWeight.w700,
            color: AppColors.Color_212121,
          ),
        ),
        SizedBox(height: 0.8.h),
        ...[
          "Able to run design sprint to deliver the best user experience based on research.",
          "Able to lead a team, delegate, and initiate.",
          "Able to mold the junior designer to strategize how certain features need to be collected.",
          "Able to aggregate and be data-minded on the decision that's taking place."
        ].map((point) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0.2.h,horizontal: 3.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.05.h,right: 1.w),
                  child: Text("• ",style: TextStyle(
                    fontSize: AppFontSize.fontSize16,
                    fontFamily: AppColors.fontFamilyMedium,
                    fontWeight: FontWeight.w500,
                    color: AppColors.Color_212121,)),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Add logic for clickable links if needed
                    },
                    child: Text(
                      point,
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize16,
                        fontFamily: AppColors.fontFamilyMedium,
                        fontWeight: FontWeight.w500,
                        color: AppColors.Color_212121,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        SizedBox(height: 2.h,),
        Text(
          "Minimum Qualifications:",
          style: TextStyle(
            fontSize: AppFontSize.fontSize20,
            fontFamily: AppColors.fontFamilyBold,
            fontWeight: FontWeight.w700,
            color: AppColors.Color_212121,
          ),
        ),
        SizedBox(height: 1.h),
        ...[
          "Experience as UI/UX Designer for 2+ years.",
  "Use platform Figma, Sketch, and Miro.",
  "Ability to analyze and convert numerical design sprints into UI/UX.",
  "Have experience in relevant B2C user centric products perviously.",
        ].map((point) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0.2.h,horizontal: 3.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.3.h),
                  child: Text("• ",style: TextStyle(fontSize: AppFontSize.fontSize14,color: AppColors.Color_424242,)),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Add logic for clickable links if needed
                    },
                    child: Text(
                      point,
                      style: TextStyle(
                        fontSize: AppFontSize.fontSize16,
                        fontFamily: AppColors.fontFamilyMedium,
                        fontWeight: FontWeight.w500,
                        color: AppColors.Color_212121,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),

        SizedBox(height: 2.h,),
         _buildPerks(),
         _buildSkills(jobDetailsProvider.requiredSkills),
        _buildJobSummary(jobDetailsProvider),
        SizedBox(height: 2.h,),
        _buildAboutUs(jobDetailsProvider),
      ],
    ),
  );
}

Widget _buildMinimumQualifications() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Minimum Qualifications:",
          style: TextStyle(
            fontSize: AppFontSize.fontSize18,
            fontWeight:FontWeight.w700,
            fontFamily: AppColors.fontFamilyBold,
            color: AppColors.Color_212121,
          ),
        ),
        SizedBox(height: 1.h),
        ...[
          "Experience as UI/UX Designer for 2+ years.",
          "Use platforms such as Figma, Sketch, and Miro.",
          "Ability to analyze and convert numerical design sprints into UI/UX.",
          "Have experience in relevant B2C user-centric products previously."
        ].map((point) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0.2.h,horizontal: 4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• ", style: TextStyle(fontSize: AppFontSize.fontSize16)),
                Expanded(
                  child: Text(
                    point,
                    style: TextStyle(fontSize: AppFontSize.fontSize16, color: AppColors.Color_212121),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    ),
  );
}


Widget _buildPerks() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Perks and Benefits:",
          style: TextStyle(
            fontSize: AppFontSize.fontSize20,
            fontFamily: AppColors.fontFamilyBold,
            fontWeight: FontWeight.w700,
            color: AppColors.Color_212121,
          ),
        ),
        SizedBox(height: 1.h),
        ...[
          {"icon": "assets/images/ShieldDone.png", "text": "Medical / Health Insurance"},
          {"icon": "assets/images/Paper Plus.png", "text": "Medical, Prescription, or Vision Plans"},
          {"icon": "assets/images/Activity.png", "text": "Performance Bonus"},
          {"icon": "assets/images/Heart.png", "text": "Paid Sick Leave"},
          {"icon": "assets/images/Ticket.png", "text": "Paid Vacation Leave"},
          {"icon": "assets/images/Location.png", "text": "Transportation Allowances"},
        ].map((perk) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0.2.h,horizontal: 3.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  perk["icon"]!,
                  width: 3.h,
                  height: 3.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    perk["text"]!,
                    style: TextStyle(
                      fontSize: AppFontSize.fontSize16,
                      fontFamily: AppColors.fontFamilyMedium,
                      fontWeight: FontWeight.w500,
                      color: AppColors.Color_212121,),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    ),
  );
}

// Required Skills Widget
Widget _buildSkills(List<String> skills) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Required Skills:",
          style: TextStyle(
            fontSize: AppFontSize.fontSize20,
            fontFamily: AppColors.fontFamilyBold,
            fontWeight: FontWeight.w700,
            color: AppColors.Color_212121,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 3.5.w,
          runSpacing: 1.5.h,
          children: skills.map((skill) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: .8.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.buttonColor,width: 0.2.h),
                borderRadius: BorderRadius.circular(50.h),
              ),
              child: Text(
                skill,
                style: TextStyle(
                  fontSize: AppFontSize.fontSize14,
                  fontFamily: AppColors.fontFamilySemiBold,
                  fontWeight: FontWeight.w600,
                  color: AppColors.buttonColor,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildJobSummary(JobDetailsProvider jobDetailsProvider) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Job Summary:",
          style: TextStyle(
            fontSize: AppFontSize.fontSize20,
            fontFamily: AppColors.fontFamilyBold,
            fontWeight: FontWeight.w700,
            color: AppColors.Color_212121,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryItem("Job Level", jobDetailsProvider.jobLevel,isLink: true),
                SizedBox(height: 1.5.h),
                _buildSummaryItem("Educational", jobDetailsProvider.education,isLink: true),
                SizedBox(height: 1.5.h),
                _buildSummaryItem("Vacancy", jobDetailsProvider.vacancy,),
              ],
            ),
            // Right Column
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryItem("Job Category", jobDetailsProvider.jobCategory,isLink: true),
                  SizedBox(height: 1.5.h),
                  _buildSummaryItem("Experience", jobDetailsProvider.experience,isLink: true),
                  SizedBox(height: 1.5.h),
                  _buildSummaryItem("Website", jobDetailsProvider.website, isLink: true),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSummaryItem(String title, String value, {bool isLink = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: AppFontSize.fontSize16,
          fontFamily: AppColors.fontFamilyBold,
          fontWeight: FontWeight.w700,
          color: AppColors.Color_212121,
        ),
      ),
      SizedBox(height: 0.5.h),
      GestureDetector(
        onTap: isLink
            ? () {
          // Add logic to open the link
        }
            : null,
        child: Text(
          value,
          style: TextStyle(
            fontSize: AppFontSize.fontSize16,
            fontFamily: AppColors.fontFamilyMedium,
            fontWeight: FontWeight.w500,
            color: isLink ? AppColors.blueText : AppColors.Color_212121,
          ),
        ),
      ),
    ],
  );
}

Widget _buildAboutUs(JobDetailsProvider jobDetailsProvider){
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Text(
         "About:",
         style: TextStyle(
           fontSize: AppFontSize.fontSize20,
           fontFamily: AppColors.fontFamilyBold,
           fontWeight: FontWeight.w700,
           color: AppColors.Color_212121,
         ),
       ),
       SizedBox(height: 2.h),
       Text(
         "Google LLC is an American multinational technology company that focuses on search engine technology, online advertising, cloud computing, computer software, quantum computing, e-commerce, artificial intelligence, and consumer electronics.\n\nGoogle was founded on September 4, 1998, by",
         style: TextStyle(
           fontSize: AppFontSize.fontSize16,
           fontFamily: AppColors.fontFamilyMedium,
           fontWeight: FontWeight.w500,
           color: AppColors.Color_212121,
         ),
       ),

     ],
   );
}

void _showJobSavedPopup(BuildContext context) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.1, // Positioning from the top
      left: MediaQuery.of(context).size.width * 0.30, // Horizontal centering
      child: Material(
        color: AppColors.activeFieldBgColor,
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(seconds: 1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: AppColors.activeFieldBgColor,
              borderRadius: BorderRadius.circular(2.h),
              border: Border.all(color:AppColors.buttonColor , width: 2),
            ),
            child: Row(
              children: [
                Container(
                  height: 2.8.h,
                  width: 2.8.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:  AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(1.h),
                    border: Border.all(
                      color: AppColors.buttonColor,
                      width: 2,
                    ),
                  ),
                  child:Image.asset("assets/images/tickIcon.png",
                      scale: 0.5.h)
                      ,
                ),
                SizedBox(width:2.w),
                Text(
                  "Job Saved!",
                  style: TextStyle(
                    color: AppColors.Color_212121,
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.fontSize20,
                    fontFamily: AppColors.fontFamilyBold
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  // Remove the popup after 2 seconds
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
