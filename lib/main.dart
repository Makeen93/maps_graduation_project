import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/localization_service.dart';
import 'package:maps_graduation_project/features/home/BL/controllers/theme_service_controller.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';
import 'core/langs/locallization_controller.dart';
import 'core/services/shared_preferences_singletone.dart';
import 'core/widgets/app_error_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Prefs.init();
  Get.lazyPut(() => ThemeServiceController());
  Get.lazyPut(() => LocallizationController());
  final localizationService = Get.find<LocallizationController>();
  await localizationService.loadLocaleFromPreferences();
  ErrorWidget.builder = (FlutterErrorDetails details) => AppErrorWidget(
        errorDetails: details,
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeServiceController>();
    final localizationService = Get.find<LocallizationController>();
    return Obx(() {
      return GetMaterialApp(
        translations: LocalizationService(),
        locale: localizationService.defaultLocale.value,
        theme: ThemeData.light().copyWith(
            textTheme: ThemeData.light().textTheme.apply(fontFamily: 'LBC')),
        darkTheme: ThemeData.dark().copyWith(
            textTheme: ThemeData.light().textTheme.apply(fontFamily: 'LBC')),
        themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.splash,
        getPages: AppRouter.routes,
      );
    });
  }
}
