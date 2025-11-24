class AuthRepository {
  AuthRepository._internal();
  static final AuthRepository _instance = AuthRepository._internal();
  factory AuthRepository() => _instance;

  Future<bool> sendOtp(String email) async {
    // TODO: Implementation for sending OTP
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }

  Future<bool> verifyOtp(String email, String otp) async {
    // TODO: Implementation for verifying OTP
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }

  Future<bool> signOut() async {
    // TODO: Implementation for signing out
    return true;
  }
}
