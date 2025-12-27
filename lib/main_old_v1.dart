import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'v2/core/theme/theme_config.dart';
import 'v2/features/auth/presentation/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: GonanaV2App(),
    ),
  );
}

class GonanaV2App extends StatelessWidget {
  const GonanaV2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gonana',
      debugShowCheckedModeBanner: false,
      theme: AppThemeConfig.lightTheme,
      darkTheme: AppThemeConfig.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
