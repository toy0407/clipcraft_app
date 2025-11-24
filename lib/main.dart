import 'package:clipcraft/core/router/router.dart';
import 'package:clipcraft/core/theme/app_theme.dart';
import 'package:clipcraft/core/utils/shared_prefs.utils.dart';
import 'package:clipcraft/features/auth/controllers/auth.contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStorage();
  await initServices();
  runApp(const MyApp());
}

Future<void> initStorage() async {
  await SharedPrefsUtil.init();
}

Future<void> initServices() async {
  Get.put(AuthController(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ClipCraft',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
