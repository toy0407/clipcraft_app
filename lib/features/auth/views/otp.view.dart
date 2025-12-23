import 'package:clipcraft/core/theme/app_text_styles.dart';
import 'package:clipcraft/features/auth/controllers/auth.contoller.dart';
import 'package:clipcraft/features/splash/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OTPView extends StatelessWidget {
  OTPView({super.key});

  final AuthController auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppLogo(),

            const SizedBox(height: 20),
            Center(child: Text('Verify your account', style: Theme.of(context).textTheme.headlineLarge)),
            const SizedBox(height: 32),
            _buildEmailInfo(context),
            const SizedBox(height: 24),
            _buildOtpInput(context),
            Spacer(),
            _buildVerifyButton(context),
            const SizedBox(height: 24),
            _buildResendButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInfo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final email = auth.emailController.text;

    return Column(
      children: [
        Text.rich(
          TextSpan(
            text: 'We sent a 6-digit OTP to ',
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.75)),
            children: [
              TextSpan(
                text: email,
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.secondary, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: auth.backToEmailPage,
          child: Text('Change Email', style: TextStyle(color: colorScheme.secondary)),
        ),
      ],
    );
  }

  Widget _buildOtpInput(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Pin themes: use filled rounded boxes to match EmailView/onboarding
    final defaultPinTheme = PinTheme(
      width: 52,
      height: 56,
      textStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: colorScheme.onSurface),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(border: Border.all(color: colorScheme.primary, width: 2)),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(border: Border.all(color: colorScheme.error, width: 2)),
    );

    return Obx(() {
      // Key to force rebuilds when error state changes
      final pinputKey = ValueKey(auth.otpError.value);
      return Pinput(
        key: pinputKey,
        length: 6,
        controller: auth.otpController,
        enabled: !auth.isVerifyOtpButtonLoading.value,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        errorPinTheme: errorPinTheme,
        errorText: auth.otpError.value.isEmpty ? null : auth.otpError.value,
        errorTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
        onChanged: (value) {
          // Clear error when user starts typing
          if (auth.otpError.value.isNotEmpty) {
            auth.otpError.value = '';
          }
        },
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        keyboardType: TextInputType.number,
        autofocus: true,
        closeKeyboardWhenCompleted: true,
        showCursor: false,
        forceErrorState: auth.otpError.value.isNotEmpty,
      );
    });
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Obx(() {
      final colorScheme = Theme.of(context).colorScheme;
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: auth.isVerifyOtpButtonLoading.value ? null : auth.verifyOTP,
          child: auth.isVerifyOtpButtonLoading.value
              ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: colorScheme.onPrimary, strokeWidth: 2.4))
              : Text('Verify', style: AppTextStyles.buttonText),
        ),
      );
    });
  }

  Widget _buildResendButton(BuildContext context) {
    return Obx(() {
      final enabled = auth.resendOtpButtonEnabled.value && auth.resendOtpSecondsRemaining.value == 0;
      final remaining = auth.resendOtpSecondsRemaining.value;
      return TextButton(
        onPressed: enabled ? auth.resendOtp : null,
        child: Text(
          remaining > 0 ? 'Resend OTP in ${remaining}s' : 'Resend OTP',
          style: AppTextStyles.bodyLarge.copyWith(
            color: enabled ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.onSurface.withAlpha(128),
          ),
        ),
      );
    });
  }
}
