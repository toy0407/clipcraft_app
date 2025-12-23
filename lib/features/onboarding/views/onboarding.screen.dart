import 'package:clipcraft/core/router/router.dart';
import 'package:clipcraft/core/theme/app_text_styles.dart';
import 'package:clipcraft/features/onboarding/widgets/video_bg.dart';
import 'package:clipcraft/features/splash/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: VideoBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppLogo(),
                SizedBox(height: 24),
                Text('ClipCraft', style: theme.textTheme.headlineLarge?.copyWith(fontSize: 32)),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [colorScheme.primary, colorScheme.secondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Text('Ideate. Create. Share.', style: theme.textTheme.headlineLarge?.copyWith(fontSize: 24)),
                ),
                SizedBox(height: 32),
                Text(
                  'From a simple thought to a scroll-stopping video - \nfast, easy, and magical.',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    child: Text('Start Creating', style: AppTextStyles.buttonText),
                  ),
                ),
                SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
