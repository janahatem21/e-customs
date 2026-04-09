import 'package:flutter/material.dart';

import '../../features/auth/login/forgot_password_screen.dart';
import '../../features/auth/login/login_screen.dart';
import '../../features/auth/register/register_screen.dart';
import '../../features/customs/customs_form_screen.dart';
import '../../features/documents/screens/upload_documents_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/payments/screens/fees_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/tracking/screens/track_shipment_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String forgotPassword = '/forgot-password';
  static const String notifications = '/notifications';
  static const String track = '/track';
  static const String profile = '/profile';
  static const String customs = '/customs';
  static const String documents = '/documents';
  static const String fees = '/fees';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    notifications: (context) => const NotificationsScreen(),
    track: (context) => const TrackShipmentScreen(),
    profile: (context) => const ProfileScreen(),
    customs: (context) => const CustomsFormScreen(),
    documents: (context) => const UploadDocumentsScreen(),
    fees: (context) => const FeesScreen(),
  };
}