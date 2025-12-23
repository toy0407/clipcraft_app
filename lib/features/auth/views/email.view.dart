import 'package:clipcraft/core/theme/app_text_styles.dart';
import 'package:clipcraft/features/auth/controllers/auth.contoller.dart';
import 'package:clipcraft/features/splash/widgets/app_logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailView extends StatelessWidget {
  const EmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final auth = Get.find<AuthController>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            AppLogo(height: 72, width: 72),
            const SizedBox(height: 32),
            Text('Turn text into', style: theme.textTheme.headlineLarge),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text('video magic.', style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 48),
            Text('Login to start creating instantly', style: theme.textTheme.bodyLarge, textAlign: TextAlign.start),
            const SizedBox(height: 16),
            Text('We will send a one-time password (OTP) to your email to continue.', style: theme.textTheme.bodyMedium, textAlign: TextAlign.start),
            const SizedBox(height: 24),
            Obx(
              () => TextField(
                controller: auth.emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enabled: !auth.isSubmitOtpButtonLoading.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  labelText: 'Email',
                  errorText: auth.emailError.value.isEmpty ? null : auth.emailError.value,
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                ),
                onChanged: (value) {
                  if (auth.emailError.value.isNotEmpty) {
                    auth.emailError.value = '';
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Obx(
                () => ElevatedButton(
                  onPressed: auth.isSubmitOtpButtonLoading.value
                      ? null
                      : () {
                          FocusScope.of(context).unfocus();
                          auth.sendOtp();
                        },
                  child: auth.isSubmitOtpButtonLoading.value
                      ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: colorScheme.onPrimary, strokeWidth: 2.4))
                      : Text('Send OTP', style: AppTextStyles.buttonText),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: theme.textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: Navigate to Terms of Service page
                          debugPrint('Navigate to Terms of Service');
                        },
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: Navigate to Privacy Policy page
                          debugPrint('Navigate to Privacy Policy');
                        },
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
