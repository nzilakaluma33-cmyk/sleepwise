import 'package:flutter/material.dart';
import '../presentation/onboarding_welcome/onboarding_welcome.dart';
import '../presentation/personal_information_setup/personal_information_setup.dart';
import '../presentation/sleep_goals_and_targets/sleep_goals_and_targets.dart';
import '../presentation/dashboard/dashboard_screen.dart';
import '../presentation/sleep_analytics_dashboard/sleep_analytics_dashboard.dart';
import '../presentation/relaxation_sleep_sounds/relaxation_sleep_sounds.dart';
import '../presentation/user_profile_settings/user_profile_settings.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String onboardingWelcome = '/onboarding-welcome';
  static const String personalInformationSetup = '/personal-information-setup';
  static const String sleepGoalsAndTargets = '/sleep-goals-and-targets';
  static const String dashboard = '/dashboard';
  static const String sleepAnalyticsDashboard = '/sleep-analytics-dashboard';
  static const String relaxationSleepSounds = '/relaxation-sleep-sounds';
  static const String userProfileSettings = '/user-profile-settings';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const OnboardingWelcome(),
    onboardingWelcome: (context) => const OnboardingWelcome(),
    personalInformationSetup: (context) => const PersonalInformationSetup(),
    sleepGoalsAndTargets: (context) => const SleepGoalsAndTargets(),
    dashboard: (context) => const DashboardScreen(),
    sleepAnalyticsDashboard: (context) => const SleepAnalyticsDashboard(),
    relaxationSleepSounds: (context) => const RelaxationSleepSounds(),
    userProfileSettings: (context) => const UserProfileSettings(),
    // TODO: Add your other routes here
  };
}
