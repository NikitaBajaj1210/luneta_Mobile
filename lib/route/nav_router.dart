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
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/personal_information_.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/edit_profile_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/education_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/expected_salary_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/projects_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/09-profile-screens/professional_skills_screen.dart';
import 'package:luneta/UI/bottom_menu/bottom_menu_screens/Setting-Screens/deactivate_account_screen.dart';
import 'package:luneta/UI/bottom_menu/filter_screen.dart';
import 'package:luneta/UI/bottom_menu/notification_screen.dart';
import 'package:luneta/UI/bottom_menu/recent_job_screen.dart';
import 'package:luneta/UI/bottom_menu/search_screen.dart';
import 'package:luneta/UI/job-deatils-application-screens/apply_job_cv_screen.dart';
import 'package:luneta/UI/job-deatils-application-screens/apply_job_profile_screen.dart';
import 'package:luneta/UI/job-deatils-application-screens/job_details_screen.dart';
import 'package:luneta/UI/landing-screen/LandingScreen.dart';
import 'package:luneta/route/route_constants.dart';
import '../UI/bottom_menu/bottom_menu_screens/09-profile-screens/job_conditions_and_preferences_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/09-profile-screens/professional_experience.dart';
import '../UI/bottom_menu/bottom_menu_screens/09-profile-screens/travel_document.dart';
import '../UI/bottom_menu/bottom_menu_screens/09-profile-screens/medical_document.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/help_center_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/job_seeking_status_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/language_settings_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/linked_accounts_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/notification_settings_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/security_settings_screen.dart';
import '../UI/bottom_menu/bottom_menu_screens/Setting-Screens/settings_screen.dart';
import '../UI/intro/IntroScreen.dart';
import '../UI/splash/SplashScreen.dart';
import '../UI/welcomeScreen/WelcomeScreen.dart';
import 'package:provider/provider.dart';
import '../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/education_provider.dart';
import '../provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/projects_screen_provider.dart';
import '../provider/bottom_menu_provider/bottom_menu_screens_provdier/profile_bottommenu_provider.dart';

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
          builder: (context) {
            final args = settings.arguments as Map<dynamic, dynamic>;
            final mobileNumber = args['mobileNumber'];
            final email = args['email'];
            final isFromLogin = args['isFromLogin'] ?? false;
            final rememberMe = args['rememberMe'] ?? false;
            final isFromForgotPassword = args['isFromForgotPassword'] ?? false;

            print("Nav Router - OTP Screen arguments: $args");
            print("Nav Router - rememberMe: $rememberMe");
            print("Nav Router - isFromForgotPassword: $isFromForgotPassword");

            return OtpScreen(
              mobileNumber: mobileNumber,
              email: email,
              isFromLogin: isFromLogin,
              rememberMe: rememberMe,
              isFromForgotPassword: isFromForgotPassword,
            );
          },
        );

      case travelDocument:
        return MaterialPageRoute(
          builder: (context) => const TravelDocumentScreen(),
        );
        case medicalDocument:
        return MaterialPageRoute(
          builder: (context) => const MedicalDocumentScreen(),
        );
        case createPassword:
        return MaterialPageRoute(
          builder: (context) {
            final args = settings.arguments as Map<dynamic, dynamic>?;
            final token = args?['token'] as String?;
            final email = args?['email'] as String?;
            final userId = args?['userId'] as String?;
            final isFromForgotPassword = args?['isFromForgotPassword'] as bool? ?? false;

            return CreatePasswordScreen(
              token: token,
              email: email,
              userId: userId,
              isFromForgotPassword: isFromForgotPassword,
            );
          },
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
        case educationScreen:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => EducationProvider(),
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
      case professionalSkillsScreen:
        return MaterialPageRoute(
          builder: (context) => const ProfessionalSkillsScreen(),
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
      case jobConditionsAndPreferences:
        return MaterialPageRoute(
          builder: (context) => const JobConditionsAndPreferencesScreen(),
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
