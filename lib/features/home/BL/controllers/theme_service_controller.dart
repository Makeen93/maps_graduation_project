// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../../../../core/services/shared_preferences_singletone.dart';

class ThemeServiceController extends GetxController {
  final _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;
  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Prefs.setBool('isDarkMode', _isDarkMode.value);
  }

  Future<void> _loadTheme() async {
    _isDarkMode.value = await Prefs.getBool('isDarkMode');
  }
}
