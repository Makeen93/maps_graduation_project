import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/shared_preferences_singletone.dart';

class LocalizationService extends Translations {
  static const Locale defaultLocale = Locale('en', 'US');
  static const Locale fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',
          'welcome': 'Welcome',
        },
        'ar_AR': {
          'hello': '',
          'welcome': '',
        },
      };

  void changeLocale(String languageCode) {
    Get.updateLocale(Locale(languageCode));
    _saveLocaleToPreferences(languageCode);
  }

  void _saveLocaleToPreferences(String languageCode) {
    Prefs.setString('locale', languageCode);
  }

  Future<void> loadLocaleFromPreferences() async {
    String? savedLocale = Prefs.getString('locale');
    if (savedLocale!.isNotEmpty) {
      changeLocale(savedLocale);
    } else {
      changeLocale(defaultLocale.languageCode);
    }
  }
}
