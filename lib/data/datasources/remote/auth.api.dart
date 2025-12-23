import 'package:clipcraft/core/utils/network.util.dart';

class AuthApi {
  AuthApi._internal();
  static final AuthApi _instance = AuthApi._internal();
  factory AuthApi() => _instance;

  Future<bool> sendOtp(String email) async {
    return await NetworkUtil.post('/auth/send-otp', body: {'email': email});
  }
}
