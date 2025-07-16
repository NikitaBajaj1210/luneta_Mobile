import 'package:flutter/material.dart';
import 'package:luneta/UI/account-screens/choose_country_screen.dart';
import 'package:luneta/UI/account-screens/choose_rank_screen.dart';
import 'package:luneta/UI/account-screens/choose_role_screen.dart';
import 'package:luneta/UI/account-screens/create_pin_screen.dart';
import 'package:luneta/UI/account-screens/profile_screen.dart';
import 'package:luneta/UI/authentication-screen/create_password_screen.dart';
import 'package:luneta/UI/authentication-screen/forgot_password.dart';
import 'package:luneta/UI/authentication-screen/otp_screen.dart';
import 'package:luneta/UI/authentication-screen/signup_screen.dart';
import 'package:luneta/UI/authentication-screen/login_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_bar.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/affiliations_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/certification_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/personal_information_.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/cv_resume_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/edit_profile_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/education_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/expected_salary_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/projects_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/summary_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/volunteering_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/work_experience_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/professionalExam_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/awards_achievements_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/seminars_trainings_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/organization_activities_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/languages_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/skills_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/references_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/Setting-Screens/deactivate_account_screen.dart';
import 'package:luneta/UI/bottom_menu/filter_screen.dart';
import 'package:luneta/UI/bottom_menu/notification_screen.dart';
import 'package:luneta/UI/bottom_menu/recent_job_screen.dart';
import 'package:luneta/UI/bottom_menu/search_screen.dart';
import 'package:luneta/UI/job-deatils-application-screens/apply_job_cv_screen.dart';
import 'package:luneta/UI/job-deatils-application-screens/apply_job_profile_screen.dart';
import 'package:luneta/UI/job-deatils-application-screens/job_details_screen.dart';
import 'package:luneta/UI/landing-screen/LandingScreen.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/professional_exam_provider.dart';
import 'package:luneta/route/route_constants.dart';

import '../UI/bottom_menu/bottom_menu_screens/09-profile-screens/professional_experience.dart';
import '../UI/bottom_menu/bottom_menu_screens/09-profile-screens/travel_document.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/help_center_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/job_seeking_status_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/language_settings_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/linked_accounts_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/notification_settings_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/personal_information_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/security_settings_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/settings_screen.dart';
import '../UI/intro/IntroScreen.dart';
import '../UI/splash/SplashScreen.dart';
import '../UI/welcomeScreen/WelcomeScreen.dart';
import 'package:provider/provider.dart';
import '../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/certification_provider.dart';
import '../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/personal_information_provider.dart';
import '../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/education_screen_provider.dart';
import '../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/projects_screen_provider.dart';
import '../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';
import '../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/volunteering_provider.dart';
import '../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/work_experience_provider.dart';

class NavRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const Splashscreen(),
        );
      case welcome:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );
      case intro:
        return MaterialPageRoute(
          builder: (context) => const IntroScreen(),
        );
      case landing:
        return MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        );
      case signUp:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case chooseCountry:
        return MaterialPageRoute(
          builder: (context) => const ChooseCountryScreen(),
        );
        case chooseRole:
        return MaterialPageRoute(
          builder: (context) => const ChooseRoleScreen(),
        );
        case chooseRank:
        return MaterialPageRoute(
          builder: (context) => const ChooseRankScreen(),
        );
        case profile:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      case createPin:
        return MaterialPageRoute(
          builder: (context) => const CreatePinScreen(),
        );
        case forgotPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgotPassword(),
        );

      case otpScreen:
        return MaterialPageRoute(
          builder: (context) => const OtpScreen(),
        );
        case travelDocument:
        return MaterialPageRoute(
          builder: (context) => const TravelDocumentScreen(),
        );
        case createPassword:
        return MaterialPageRoute(
          builder: (context) => const CreatePasswordScreen(),
        );
      case bottomMenu:
        return MaterialPageRoute(
          builder: (context) => const BottomMenuBar(),
        );
      // case jobDetails:
      //   return MaterialPageRoute(
      //     builder: (context) => const JobDetailsScreen(),
      //   );
      case jobDetails:
        return MaterialPageRoute(
          builder: (context) {
            if (settings.arguments == null) {
              return const JobDetailsScreen(
                jobTitle: 'Unknown Job',
                companyName: 'Unknown Company',
                salaryRange: 'N/A',
              );
            }

            final args = settings.arguments as Map<dynamic, dynamic>;
            final jobTitle = args['jobTitle'] as String? ?? 'Unknown Job';
            final companyName = args['companyName'] as String? ?? 'Unknown Company';
            final salaryRange = args['salaryRange'] as String? ?? 'N/A';

            return JobDetailsScreen(
              jobTitle: jobTitle,
              companyName: companyName,
              salaryRange: salaryRange,
            );
          },
        );
        case notification:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );
        case recentJobs:
        return MaterialPageRoute(
          builder: (context) => const RecentJobScreen(),
        );
        case searchScreen:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );
        case filterScreen:
        return MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        );
        case applyJobCv:
        return MaterialPageRoute(
          builder: (context) => const ApplyJobCvScreen(),
        );
        case applyJobProfile:
        return MaterialPageRoute(
          builder: (context) => const ApplyJobProfileScreen(),
        );
        case editProfile:
        return MaterialPageRoute(
          builder: (context) => const ProfileEditScreen(),
        );
      case personalInfo:
        return MaterialPageRoute(
          builder: (context) => const PersonalInfoScreen(),
        );
        // return MaterialPageRoute(
        //   builder: (context) => MultiProvider(
        //     providers: [
        //       ChangeNotifierProvider.value(value: Provider.of<PersonalInfoProvider>(context, listen: false)),
        //     ],
        //     child: PersonalInfoScreen(),
        //   ),
        // );

      case ProfessionalExperience:
        return MaterialPageRoute(
          builder: (context) => const ProfessionalExperienceScreen(),
        );
        case expectedSalaryScreen:
        return MaterialPageRoute(
          builder: (context) => const ExpectedSalaryScreen(),
        );
        case workExperienceScreen:
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: Provider.of<WorkExperienceProvider>(context, listen: false)),
              ChangeNotifierProvider.value(value: Provider.of<ProfileBottommenuProvider>(context, listen: false)),
            ],
            child: const WorkExperienceScreen(),
          ),
        );
        case educationScreen:
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: Provider.of<EducationScreenProvider>(context, listen: false)),
              ChangeNotifierProvider.value(value: Provider.of<ProfileBottommenuProvider>(context, listen: false)),
            ],
            child: const EducationScreen(),
          ),
        );
        case projectScreen:
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: Provider.of<ProjectsProfileScreenProvider>(context, listen: false)),
              ChangeNotifierProvider.value(value: Provider.of<ProfileBottommenuProvider>(context, listen: false)),
            ],
            child: const ProjectsScreen(),
          ),
        );
        case certificationScreen:
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: Provider.of<CertificationProvider>(context, listen: false)),
              ChangeNotifierProvider.value(value: Provider.of<ProfileBottommenuProvider>(context, listen: false)),
            ],
            child: const CertificationScreen(),
          ),
        );
        case volunteeringScreen:
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: Provider.of<VolunteeringProvider>(context, listen: false)),
              ChangeNotifierProvider.value(value: Provider.of<ProfileBottommenuProvider>(context, listen: false)),
            ],
            child: const VolunteeringScreen(),
          ),
        );
        case professionalExamScreen:
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: Provider.of<ProfessionalExamProvider>(context, listen: false)),
              ChangeNotifierProvider.value(value: Provider.of<ProfileBottommenuProvider>(context, listen: false)),
            ],
            child: const ProfessionalExamScreen(),
          ),
        );
        case awardsAchievementsScreen:
        return MaterialPageRoute(
          builder: (context) => const AwardsAchievementsScreen(),
        );
        case seminarsTrainingsScreen:
        return MaterialPageRoute(
          builder: (context) => const SeminarsTrainingsScreen(),
        );
        case organizationActivitiesScreen:
        return MaterialPageRoute(
          builder: (context) => const OrganizationActivitiesScreen(),
        );
        case languagesScreen:
        return MaterialPageRoute(
          builder: (context) => const LanguagesScreen(),
        );
        case skillsScreen:
        return MaterialPageRoute(
          builder: (context) => const SkillsScreen(),
        );
        case affiliationsScreen:
        return MaterialPageRoute(
          builder: (context) => const AffiliationsScreen(),
        );
        case referencesScreen:
        return MaterialPageRoute(
          builder: (context) => const ReferencesScreen(),
        );
        case cvResumeScreen:
        return MaterialPageRoute(
          builder: (context) => const CVResumeScreen(),
        );
        case settingsScreen:
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        );
        case jobSeekingStatusScreen:
        return MaterialPageRoute(
          builder: (context) => const JobSeekingStatusScreen(),
        );
        // case personalInformationScreen:
        // return MaterialPageRoute(
        //   builder: (context) => const PersonalInformationScreen(),
        // );
        case linkedAccountsScreen:
        return MaterialPageRoute(
          builder: (context) => const LinkedAccountsScreen(),
        );
        case notificationSettingsScreen:
        return MaterialPageRoute(
          builder: (context) => const NotificationSettingsScreen(),
        );
        case security:
        return MaterialPageRoute(
          builder: (context) => const SecuritySettingsScreen(),
        );
        case languageSettingsScreen:
        return MaterialPageRoute(
          builder: (context) => const LanguageSettingsScreen(),
        );
        case helpCenterScreen:
        return MaterialPageRoute(
          builder: (context) => const HelpCenterScreen(),
        );
        case deactivateAccountScreen:
          return MaterialPageRoute(
            builder: (context) => const DeactivateAccountScreen(),
          );
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
