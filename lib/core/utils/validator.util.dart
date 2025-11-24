import 'package:get/get_utils/get_utils.dart';

class Validator {
  static bool isValidUrl(String? value) {
    if (value == null) return false;
    return GetUtils.isURL(value);
  }

  static bool isPlainText(String? value) {
    if (value == null) return false;
    return !isValidUrl(value);
  }

  // Name should only contain letters and spaces, and length should be 2 and 50 characters
  static bool isValidName(String? value) {
    if (value == null || value.isEmpty) return false;
    final nameRegex = RegExp(r"^(?!.*  )[a-zA-Zà-ÿÀ-ß'.,\- ]{2,50}$");
    return nameRegex.hasMatch(value.trim());
  }

  // Age should be a number between 3 and 100
  static bool isValidAge(String? value) {
    if (value == null || value.isEmpty) return false;
    final age = int.tryParse(value);
    return (age != null && age >= 3 && age <= 100);
  }

  static bool isValidEmail(String? value) {
    if (value == null || value.isEmpty) return false;
    return GetUtils.isEmail(value);
  }

  // OTP should be a 6-digit number
  static bool isValidOTP(String? value) {
    if (value == null || value.isEmpty) return false;
    // OTP should be exactly 6 digits
    return GetUtils.isNumericOnly(value) && value.length == 6;
  }
}
