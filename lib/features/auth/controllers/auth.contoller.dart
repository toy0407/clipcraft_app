import 'package:clipcraft/core/router/router.dart';
import 'package:clipcraft/core/utils/snackbar.util.dart';
import 'package:clipcraft/core/utils/validator.util.dart';
import 'package:clipcraft/data/repositories/auth.repository.dart';
import 'package:clipcraft/data/repositories/user.repository.dart';
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
  // OTP Handler
  final otpController = TextEditingController();

  /// Signup screen
  // Page controller for signup flow
  final signupPageController = PageController();
  // User details input controllers
  final nameController = TextEditingController();
  final isSignupButtonLoading = false.obs;

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

    final sendOtpResult = await _authRepository.sendOtp(email);
    if (!sendOtpResult) {
      SnackbarUtil.error('Error sending OTP');
      isSubmitOtpButtonLoading.value = false;
      return;
    }
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
    final user;
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

  void backToEmailPage() {
    otpError.value = '';
    otpController.clear();
    loginPageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<bool> resendOtp() async {
    final email = emailController.text.trim();

    resendOtpButtonEnabled.value = false;
    final resendOtpResult = await _authRepository.sendOtp(email);
    if (!resendOtpResult) {
      SnackbarUtil.error('Error resending OTP');
      resendOtpButtonEnabled.value = true;
      return false;
    }
    resendOtpButtonEnabled.value = true;
    return true;
  }

  Future<bool> isLoggedIn() async {
    // TODO: Implement this
    return false;
  }
}
