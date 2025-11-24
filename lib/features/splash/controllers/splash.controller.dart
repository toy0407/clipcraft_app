import 'package:clipcraft/core/constants/shared_prefs.constants.dart';
import 'package:clipcraft/core/router/router.dart';
import 'package:clipcraft/core/utils/shared_prefs.utils.dart';
import 'package:clipcraft/features/auth/controllers/auth.contoller.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initApp();
  }

  Future<void> _initApp() async {
    bool isFirstTime = SharedPrefsUtil.getBool(SharedPrefsConstants.IS_FIRST_TIME, defaultValue: true);
    final authService = Get.find<AuthController>();
    final isLoggedIn = await authService.isLoggedIn();

    // Delay for 1000ms
    await Future.delayed(const Duration(milliseconds: 1000));

    if (isFirstTime) {
      await SharedPrefsUtil.setBool(SharedPrefsConstants.IS_FIRST_TIME, false);
      Get.offAllNamed(AppRoutes.onboarding);
    } else if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
