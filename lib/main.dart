import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luneta/provider/Intro_screen_provider.dart';
import 'package:luneta/provider/account-provider/choose_country_provider.dart';
import 'package:luneta/provider/account-provider/create_pin_provider.dart';
import 'package:luneta/provider/account-provider/profile_provider.dart';
import 'package:luneta/provider/authentication-provider/create_password_provider.dart';
import 'package:luneta/provider/authentication-provider/forgot_password_password.dart';
import 'package:luneta/provider/authentication-provider/login_provider.dart';
import 'package:luneta/provider/authentication-provider/otp_screen_provider.dart';
import 'package:luneta/provider/authentication-provider/signup_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/Summary_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/affiliations_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/awards_achievements_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/certification_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/personal_information_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/cv_resume_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/education_screen_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/expected_salary_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/languages_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/organization_activities_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/professional_exam_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/professional_experience_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/projects_screen_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/references_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/seminars_trainings_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/skills_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/volunteering_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/work_experience_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/deactivate_account_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/help_center_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/job_seeking_status_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/language_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/linked_account_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/security_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/Setting-Screen-Provider/settings_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/home_screen_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/filter_screen_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/notification_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/recent_job_provider.dart';
import 'package:luneta/provider/bottom_menu_provider/search_screen_provider.dart';
import 'package:luneta/provider/job-details-application-provider/apply_job_cv_provider.dart';
import 'package:luneta/provider/job-details-application-provider/apply_job_profile_provider.dart';
import 'package:luneta/provider/job-details-application-provider/job_details_provider.dart';
import 'package:luneta/provider/job-details-application-provider/projects_screen_provider.dart';
import 'package:luneta/route/nav_router.dart';
import 'package:luneta/route/route_constants.dart';

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'UI/bottom_menu/bottom_menu_screens/Setting-Screens/language_settings_screen.dart';
import 'Utils/helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Change status bar color
    statusBarIconBrightness: Brightness.dark, // For light or dark icons
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IntroScreenProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => OtpScreenProvider()),
        ChangeNotifierProvider(create: (_) => CreatePasswordProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (_) => ChooseCountryProvider()),
        ChangeNotifierProvider(create: (_) => CreatePinProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => BottomMenuProvider()),
        ChangeNotifierProvider(create: (_) => ProfileBottommenuProvider()),
        ChangeNotifierProvider(create: (_) => WorkExperienceProvider()),
        ChangeNotifierProvider(create: (_) => SummaryProvider()),
        ChangeNotifierProvider(create: (_) => ExpectedSalaryProvider()),
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => JobDetailsProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => RecentJobProvider()),
        ChangeNotifierProvider(create: (_) => SearchScreenProvider()),
        ChangeNotifierProvider(create: (_) => FilterScreenProvider()),
        ChangeNotifierProvider(create: (_) => ApplyJobCvProvider()),
        ChangeNotifierProvider(create: (_) => ApplyJobProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProjectsScreenProvider()),
        ChangeNotifierProvider(create: (_) => CertificationProvider()),
        ChangeNotifierProvider(create: (_) => EducationScreenProvider()),
        ChangeNotifierProvider(create: (_) => VolunteeringProvider()),
        ChangeNotifierProvider(create: (_) => ProfessionalExamProvider()),
        ChangeNotifierProvider(create: (_) => AwardsAchievementsProvider()),
        ChangeNotifierProvider(create: (_) => SeminarsTrainingsProvider()),
        ChangeNotifierProvider(create: (_) => OrganizationActivitiesProvider()),
        ChangeNotifierProvider(create: (_) => LanguagesProvider()),
        ChangeNotifierProvider(create: (_) => SkillsProvider()),
        ChangeNotifierProvider(create: (_) => AffiliationsProvider()),
        ChangeNotifierProvider(create: (_) => ReferencesProvider()),
        ChangeNotifierProvider(create: (_) => CVResumeProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => JobSeekingStatusProvider()),
        ChangeNotifierProvider(create: (_) => LinkedAccountProvider()),
        ChangeNotifierProvider(create: (_) => SecurityProvider()),
        ChangeNotifierProvider(create: (_) => PersonalInformationProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_)=>  HelpCenterProvider()),
        ChangeNotifierProvider(create: (_)=>  DeactivateAccountProvider()),
        ChangeNotifierProvider(create: (_)=>  CertificationProvider()),
        ChangeNotifierProvider(create: (_)=>  ProjectsProfileScreenProvider()),
        ChangeNotifierProvider(create: (_)=>  ProfessionalExperienceProvider()),

      ],
      child:  InitRoutes(),
    ),
  );
}

class InitRoutes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Precache images
    precacheImage(AssetImage("assets/images/LunetaLogo.png"), context);
    precacheImage(AssetImage("assets/images/LogoSubTitle.png"), context);
    precacheImage(AssetImage("assets/images/slider1.png"), context);
    precacheImage(AssetImage("assets/images/slider2.png"), context);
    precacheImage(AssetImage("assets/images/slider3.png"), context);
    precacheImage(AssetImage("assets/images/welcome_bg.png"), context);


    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(.8)),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: NavRouter.generateRoute,
            initialRoute: splash,
            navigatorKey: Helper.navigatorKey,
          ),
        );
      },
    );
  }
}
