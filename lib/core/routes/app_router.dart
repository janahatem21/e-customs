import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/auth/login/screens/forgot_password_screen.dart';
import '../../features/auth/login/screens/login_screen.dart';
import '../../features/auth/register/screens/register_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/customs/customs_form_screen.dart';
import '../../features/layout/providers/layout_provider.dart';
import '../../features/layout/screens/layout_screen.dart';
import '../../features/notifications/presentation/providers/notification_provider.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/onboarding/providers/onboarding_provider.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/tracking/presentation/providers/tracking_provider.dart';
import '../../features/tracking/presentation/screens/detailed_log_screen.dart';
import '../../features/splash/splash_screen.dart';

import '../../core/di/service_locator.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String layout = '/layout';
  static const String forgotPassword = '/forgot-password';
  static const String notifications = '/notifications';
  static const String customs = '/customs';
  static const String detailedLog = '/detailed-log';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding:
        (context) => ChangeNotifierProvider(
          create: (_) => OnboardingProvider(),
          child: const OnboardingScreen(),
        ),
    login:
        (context) => ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: const LoginScreen(),
        ),
    register:
        (context) => ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: const RegisterScreen(),
        ),
    layout:
        (context) => ChangeNotifierProvider(
          create: (_) => LayoutProvider(),
          child: const LayoutScreen(),
        ),
    forgotPassword:
        (context) => ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: const ForgotPasswordScreen(),
        ),
    notifications:
        (context) => ChangeNotifierProvider(
          create: (_) => getIt<NotificationProvider>(),
          child: const NotificationsScreen(),
        ),
    customs: (context) => const CustomsFormScreen(),
    detailedLog:
        (context) => ChangeNotifierProvider.value(
          value: getIt<TrackingProvider>(),
          child: const DetailedLogScreen(),
        ),
  };
}
