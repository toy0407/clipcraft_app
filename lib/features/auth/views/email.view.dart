import 'package:clipcraft/core/theme/app_text_styles.dart';
import 'package:clipcraft/features/auth/controllers/auth.contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailView extends StatelessWidget {
  const EmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final auth = Get.find<AuthController>();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Hero(
              tag: 'app_logo_hero',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: colorScheme.primary.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 6))],
                  ),
                  child: Icon(Icons.check, color: colorScheme.primary, size: 36),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              'Enter your email',
              style: AppTextStyles.headlineLarge.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 8),

          Center(
            child: Text(
              'We will send a one-time password (OTP) to your email to continue.',
              style: AppTextStyles.bodyMedium.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7), height: 1.4),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 24),

          Obx(
            () => TextField(
              controller: auth.emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined, color: colorScheme.onSurface.withValues(alpha: 0.7)),
                labelText: 'Email',
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(36)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
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

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            child: Obx(
              () => SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: auth.isSubmitOtpButtonLoading.value
                      ? null
                      : () {
                          FocusScope.of(context).unfocus();
                          auth.sendOtp();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    shadowColor: colorScheme.primary.withValues(alpha: 0.2),
                    elevation: 12,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  child: auth.isSubmitOtpButtonLoading.value
                      ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: colorScheme.onPrimary, strokeWidth: 2.4))
                      : Text(
                          'Send OTP',
                          style: AppTextStyles.buttonText.copyWith(fontSize: 18, fontWeight: FontWeight.w700, color: colorScheme.onPrimary),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
