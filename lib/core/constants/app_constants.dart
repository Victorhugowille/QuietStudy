import 'package:flutter/material.dart';
import 'package:quiet_study/screens/home/home_screen.dart';
import 'package:quiet_study/screens/onboarding/onboarding_screen.dart';
import 'package:quiet_study/screens/policy_viewer/policy_viewer_screen.dart';
import 'package:quiet_study/screens/splash/splash_screen.dart';

class AppKeys {
  static const String policyVersion = 'v1.0';
  static const String keyPrivacyPolicyAccepted = 'privacy_policy_accepted_$policyVersion';
  static const String keyTermsOfUseAccepted = 'terms_of_use_accepted_$policyVersion';
  static const String keyPoliciesVersionAccepted = 'policies_version_accepted';
  static const String keyAcceptedAt = 'accepted_at';
}

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String policyViewer = '/policy-viewer';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      onboarding: (context) => const OnboardingScreen(),
      home: (context) => const HomeScreen(),
      policyViewer: (context) => const PolicyViewerScreen(),
    };
  }
}