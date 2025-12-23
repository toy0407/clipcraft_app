import 'package:clipcraft/core/router/router.dart';
import 'package:clipcraft/core/utils/logger.util.dart';
import 'package:clipcraft/core/utils/snackbar.util.dart';
import 'package:clipcraft/core/utils/validator.util.dart';
import 'package:clipcraft/data/repositories/auth.repository.dart';
import 'package:clipcraft/data/repositories/user.repository.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  /// Login screen
  /// Page controller for login flow
  final loginPageController = PageController();
  // Email pageview
  final emailController = TextEditingController();
  final isSubmitOtpButtonLoading = false.obs;
  final RxString emailError = ''.obs;

  /// OTP page view
  // Stores OTP digits
  final isVerifyOtpButtonLoading = false.obs;
  final RxString otpError = ''.obs;
  final resendOtpButtonEnabled = true.obs;
  final resendOtpSecondsRemaining = 0.obs;
  Timer? _resendOtpTimer;
  // OTP Handler
  final otpController = TextEditingController();

  /// Signup screen
  // Page controller for signup flow
  final signupPageController = PageController();
  // User details input controllers
  final nameController = TextEditingController();
  final isSignupButtonLoading = false.obs;
  final RxString nameError = ''.obs;
  final RxnString videoPurpose = RxnString();

  // Navigate to OTP page
  void sendOtp() async {
    // Validate email input
    final email = emailController.text.trim();
    if (!Validator.isValidEmail(email)) {
      emailError.value = 'Please enter valid email address';
      return;
    }
    emailError.value = '';

    // Enable loading state for the button
    isSubmitOtpButtonLoading.value = true;
    // Send OTP to the provided email
    try {
      await _authRepository.sendOtp(email);
      Logger.debug('Sending OTP to email: $email', name: 'AuthController.sendOtp');
    } catch (e) {
      SnackbarUtil.error(e.toString());
      isSubmitOtpButtonLoading.value = false;
      return;
    }

    _startResendOtpCooldown();
    loginPageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    isSubmitOtpButtonLoading.value = false;
  }

  /// Verify OTP
  void verifyOTP() async {
    final otp = otpController.text;
    final email = emailController.text.trim();

    // Validate OTP input
    if (!Validator.isValidOTP(otp)) {
      otpError.value = 'Please enter a valid 6-digit OTP';
      return;
    }
    otpError.value = '';

    // Enable loading state for the button
    isVerifyOtpButtonLoading.value = true;

    // Verify OTP from Supabase
    final verifyOtpResult = await _authRepository.verifyOtp(email, otp);
    if (!verifyOtpResult) {
      isVerifyOtpButtonLoading.value = false;
      otpError.value = 'Invalid OTP. Please try again.';
      return;
    }
    // OTP verified successfully, check if user exists
    dynamic user;
    try {
      user = await _userRepository.getUserDetails();
    } catch (e) {
      SnackbarUtil.error('Error fetching user details: $e');
      isVerifyOtpButtonLoading.value = false;
      return;
    }
    isVerifyOtpButtonLoading.value = false;
    otpController.clear();

    // Check if user is already present in database
    if (user != null) {
      // User exists, redirect to home
      Get.offAllNamed(AppRoutes.home);
    } else {
      // User does not exist, redirect to user creation page
      Get.offAllNamed(AppRoutes.register);
    }
  }

  /// Register new user
  void register() async {
    final name = nameController.text.trim();
    // Validate name input
    if (!Validator.isValidName(name)) {
      nameError.value = 'Please enter a valid name (min 3 characters)';
      return;
    }
    nameError.value = '';
    isSignupButtonLoading.value = true;
    // Create new user in the database
    final createUserResult = await _userRepository.createUser(name: name);
    if (!createUserResult) {
      SnackbarUtil.error('Error creating user');
      isSignupButtonLoading.value = false;
      return;
    }
    isSignupButtonLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
  }

  void backToEmailPage() {
    otpError.value = '';
    otpController.clear();
    loginPageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<bool> resendOtp() async {
    final email = emailController.text.trim();

    if (resendOtpSecondsRemaining.value > 0) {
      return false;
    }

    resendOtpButtonEnabled.value = false;
    final resendOtpResult = await _authRepository.sendOtp(email);
    if (!resendOtpResult) {
      SnackbarUtil.error('Error resending OTP');
      resendOtpButtonEnabled.value = true;
      return false;
    }

    _startResendOtpCooldown();
    return true;
  }

  Future<bool> isLoggedIn() async {
    // TODO: Implement this
    return false;
  }

  void _startResendOtpCooldown({int resendOtpCooldownSeconds = 60}) {
    _resendOtpTimer?.cancel();
    resendOtpSecondsRemaining.value = resendOtpCooldownSeconds;
    resendOtpButtonEnabled.value = false;

    _resendOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final nextValue = resendOtpSecondsRemaining.value - 1;
      if (nextValue <= 0) {
        resendOtpSecondsRemaining.value = 0;
        resendOtpButtonEnabled.value = true;
        timer.cancel();
        return;
      }
      resendOtpSecondsRemaining.value = nextValue;
    });
  }

  @override
  void onClose() {
    _resendOtpTimer?.cancel();
    super.onClose();
  }
}
