import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/services/storage_service.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';
import '../../../../core/navigation/main_navigation.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Wait for splash animation
    await Future.delayed(2.seconds);

    if (!mounted) return;

    // Check authentication
    final authState = ref.read(authStateProvider);
    final hasToken = StorageService.instance.hasToken;

    if (hasToken && authState.isAuthenticated) {
      // User is logged in, go to main app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
      );
    } else {
      // User not logged in, go to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.heroGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '🌾',
                    style: context.textTheme.displayLarge,
                  ),
                ),
              )
                  .animate()
                  .scale(
                    duration: AppAnimations.slow,
                    curve: AppAnimations.bounce,
                  )
                  .fadeIn(),

              const SizedBox(height: AppSpacing.xxxl),

              // App Name
              Text(
                'Gonana',
                style: context.textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.3, end: 0),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Agricultural Marketplace',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 0.5,
                ),
              ).animate(delay: 500.ms).fadeIn(),

              const SizedBox(height: AppSpacing.xxxl),

              // Loading Indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ).animate(delay: 700.ms).fadeIn(),
            ],
          ),
        ),
      ),
    );
  }
}
