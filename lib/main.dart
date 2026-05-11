import 'package:e_customs/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:e_customs/core/di/service_locator.dart';
import 'package:e_customs/core/services/shared_preferences_service.dart';
import 'package:e_customs/core/services/fcm_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

import 'package:provider/provider.dart';
import 'core/providers/user_provider.dart';
import 'features/notifications/presentation/providers/notification_provider.dart';

import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize(
    serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID'],
  );
  await SharedPreferencesService.init();
  configureDependencies();
  await getIt<FCMService>().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<UserProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<NotificationsProvider>()),
      ],
      child: const ECustomsApp(),
    ),
  );
}

class ECustomsApp extends StatelessWidget {
  const ECustomsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Customs',
      theme: AppTheme.lightTheme,
      initialRoute: AppRouter.splash,
      routes: AppRouter.routes,
    );
  }
}
