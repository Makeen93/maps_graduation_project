import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/shared_preferences_singletone.dart';

class LocallizationController extends GetxController {
  var defaultLocale = const Locale('en').obs;
  Locale fallbackLocale = const Locale('en');
  void changeLocale(String languageCode) {
    defaultLocale.value = Locale(languageCode);
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
      changeLocale(defaultLocale.value.languageCode);
    }
  }
}
