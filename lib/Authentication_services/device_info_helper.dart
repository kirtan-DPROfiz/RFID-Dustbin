/*

import 'package:flutter/foundation.dart'; // For kIsWeb
import 'dart:io' show Platform;


class DeviceInfoHelper {
  static final Logger _logger = Logger(); // Initialize Logger

  static Future<String?> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      _logger.d('Starting device info retrieval');

      if (kIsWeb) {
        // For web platform
        _logger.d('Platform detected: Web');
        final WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
        String info = 'Web Browser: ${webInfo.browserName.name}, Version: ${webInfo.appVersion}';
        _logger.i('Device Info: $info');
        return info;
      } else if (Platform.isAndroid) {
        // For Android
        _logger.d('Platform detected: Android');
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        String info = 'Android Device: ${androidInfo.model}, SDK: ${androidInfo.version.sdkInt}';
        _logger.i('Device Info: $info');
        return info;
      } else if (Platform.isIOS) {
        // For iOS
        _logger.d('Platform detected: iOS');
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        String info = 'iOS Device: ${iosInfo.utsname.machine}, System: ${iosInfo.systemName} ${iosInfo.systemVersion}';
        _logger.i('Device Info: $info');
        return info;
      } else {
        _logger.w('Unsupported Platform');
      }
    } catch (e, stackTrace) {
      _logger.e('Error retrieving device info', e, stackTrace);
    }

    _logger.w('Device info not available');
    return null;
  }
}*/
