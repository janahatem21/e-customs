import 'package:flutter/material.dart';
import 'package:e_customs/core/services/shared_preferences_service.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();

  runApp(const ECustomsApp());
}

class ECustomsApp extends StatelessWidget {
  const ECustomsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Customs',
      theme: AppTheme.lightTheme,
      initialRoute: AppRouter.layout,
      routes: AppRouter.routes,
    );
  }
}
