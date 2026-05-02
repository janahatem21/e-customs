import 'package:e_customs/core/models/user_model.dart';
import 'package:e_customs/features/customs/presentation/provider/add_item_provider.dart';
import 'package:e_customs/features/customs/presentation/provider/declaration_provider.dart';
import 'package:e_customs/features/customs/presentation/screens/create_declaration_screen.dart';
import 'package:e_customs/features/payments/presentation/screens/payment_checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/screens/login/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register/screens/register_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/customs/presentation/screens/customs_form_screen.dart';
import '../../features/layout/providers/layout_provider.dart';
import '../../features/layout/screens/layout_screen.dart';
import '../../features/notifications/presentation/providers/notification_provider.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/onboarding/providers/onboarding_provider.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/tracking/presentation/providers/tracking_provider.dart';
import '../../features/tracking/presentation/screens/detailed_log_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/payments/presentation/provider/fees_provider.dart';
import '../../features/profile/presentation/provider/profile_provider.dart';
import '../../features/customs/presentation/screens/add_item_screen.dart';
import '../../features/customs/presentation/screens/scan_invoice_screen.dart';
import '../../features/customs/presentation/screens/declaration_screen.dart';
import '../../features/customs/presentation/screens/calculate_customs_screen.dart';
import '../../features/payments/presentation/screens/payment_screen.dart';
import '../../features/payments/presentation/screens/payment_success_screen.dart';
import '../../features/payments/presentation/screens/qr_code_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';

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
  static const String checkout = '/checkout';
  static const String addItem = '/add-item';
  static const String createDeclaration = '/create-declaration';
  static const String scanInvoice = '/scan-invoice';
  static const String declaration = '/declaration';
  static const String calculateCustoms = '/calculate-customs';
  static const String payment = '/payment';
  static const String paymentSuccess = '/payment-success';
  static const String qrCode = '/qr-code';
  static const String editProfile = '/edit-profile';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding:
        (context) => ChangeNotifierProvider(
          create: (_) => OnboardingProvider(),
          child: const OnboardingScreen(),
        ),
    login:
        (context) => ChangeNotifierProvider.value(
          value: getIt<AuthProvider>(),
          child: const LoginScreen(),
        ),
    register:
        (context) => ChangeNotifierProvider.value(
          value: getIt<AuthProvider>(),
          child: const RegisterScreen(),
        ),
    layout:
        (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LayoutProvider()),
            ChangeNotifierProvider.value(value: getIt<DeclarationProvider>()),
          ],
          child: const LayoutScreen(),
        ),
    forgotPassword:
        (context) => ChangeNotifierProvider.value(
          value: getIt<AuthProvider>(),
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
    checkout:
        (context) => ChangeNotifierProvider.value(
          value: getIt<FeesProvider>(),
          child: const PaymentCheckoutScreen(),
        ),
    addItem:
        (context) => ChangeNotifierProvider(
          create: (_) => getIt<AddItemProvider>(),
          child: const AddItemScreen(),
        ),
    createDeclaration:
        (context) => ChangeNotifierProvider.value(
          value: getIt<DeclarationProvider>(),
          child: const CreateDeclarationScreen(),
        ),
    scanInvoice: (context) => const ScanInvoiceScreen(),
    declaration: (context) => const DeclarationScreen(),
    calculateCustoms: (context) => const CalculateCustomsScreen(),
    payment: (context) => const PaymentScreen(),
    paymentSuccess: (context) => const PaymentSuccessScreen(),
    qrCode: (context) => const QRCodeScreen(),
    editProfile: (context) {
      final user = ModalRoute.of(context)?.settings.arguments as UserModel?;
      return ChangeNotifierProvider.value(
        value: getIt<ProfileProvider>(),
        child: EditProfileScreen(user: user),
      );
    },
  };
}
