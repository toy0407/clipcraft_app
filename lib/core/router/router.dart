import 'package:clipcraft/features/auth/views/login.screen.dart';
import 'package:clipcraft/features/auth/views/register.screen.dart';
import 'package:clipcraft/features/onboarding/views/onboarding.screen.dart';
import 'package:clipcraft/features/splash/views/splash.screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const profile = '/profile';
  static const settings = '/settings';
  static const notifications = '/notifications';
  static const help = '/help';
  static const about = '/about';
}

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => OnboardingScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => RegisterScreen()),
    // GetPage(name: AppRoutes.home, page: () => HomeScreen()),
  ];
}
