import 'package:clipcraft/features/auth/controllers/auth.contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OTPView extends StatelessWidget {
  OTPView({super.key});

  final AuthController auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 6)),
                ],
              ),
              child: Icon(Icons.lock_outline, color: Theme.of(context).colorScheme.primary, size: 36),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text('Enter OTP', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'We sent a 6-digit code to your email',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(180)),
            ),
          ),

          const SizedBox(height: 18),

          _buildEmailInfo(),

          const SizedBox(height: 12),

          _buildOtpInput(),

          const SizedBox(height: 24),

          _buildVerifyButton(),

          const SizedBox(height: 8),

          _buildResendButton(),
        ],
      ),
    );
  }

  Widget _buildEmailInfo() {
    return Column(
      children: [
        Text('We have sent an OTP to ${auth.emailController.text}', style: const TextStyle(fontSize: 12)),
        TextButton(onPressed: auth.backToEmailPage, child: const Text('Change Email')),
      ],
    );
  }

  Widget _buildOtpInput() {
    // Get current theme properties
    final colorScheme = Theme.of(Get.context!).colorScheme;
    final textTheme = Theme.of(Get.context!).textTheme;

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

    // GlobalKey to force rebuilds when error state changes
    final pinputKey = ValueKey(auth.otpError.value);

    return Obx(() {
      return Pinput(
        key: pinputKey,
        length: 6,
        controller: auth.otpController,
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

  Widget _buildVerifyButton() {
    return Obx(() {
      final colorScheme = Theme.of(Get.context!).colorScheme;
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: auth.isVerifyOtpButtonLoading.value ? null : auth.verifyOTP,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            shadowColor: colorScheme.primary.withValues(alpha: 0.2),
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: auth.isVerifyOtpButtonLoading.value
              ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: colorScheme.onPrimary, strokeWidth: 2.4))
              : Text(
                  'Verify',
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.w700, fontSize: 18),
                ),
        ),
      );
    });
  }

  Widget _buildResendButton() {
    return Obx(() {
      final enabled = auth.resendOtpButtonEnabled.value;
      return TextButton(
        onPressed: enabled ? auth.resendOtp : null,
        child: Text(
          'Resend OTP',
          style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(color: enabled ? Theme.of(Get.context!).colorScheme.primary : null),
        ),
      );
    });
  }
}
