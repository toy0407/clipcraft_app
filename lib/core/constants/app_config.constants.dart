import 'package:flutter/foundation.dart';

class AppConfigConstants {
  static const String appName = 'ClipCraft';
  static const String apiBaseUrl = kReleaseMode ? 'https://api.clipcraft.com' : 'http://localhost:4000/api/v1';
}
