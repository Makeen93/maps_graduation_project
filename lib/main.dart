import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lingo_hunter/lingo_hunter.dart';
import 'package:maps_graduation_project/core/services/localization_service.dart';
import 'package:maps_graduation_project/features/home/BL/controllers/theme_service_controller.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';

import 'core/services/shared_preferences_singletone.dart';
import 'core/widgets/app_error_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await LingoHunter.extractAndCreateTranslationFiles(
  //   baseLang: 'en',
  //   langs: ['ar', 'tr'],
  //   // projectDirectory: ' H:/Maps/2025/maps_graduation_project',
  //   outputDirectory: 'H:/Maps/2025/maps_graduation_project/lib',
  //   // additionalRegExps: [
  //   //   RegExp(r'translate\("([^\"]+)"\)'), // Custom regex pattern
  //   // ],
  // );
  // print("🚀 Custom translation files generated successfully!");
  await Firebase.initializeApp();
  await Prefs.init(); // Initialize SharedPreferences
  Get.lazyPut(() => ThemeServiceController());
  Get.lazyPut(() => LocalizationService());

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
    final localizationService = Get.find<LocalizationService>();
    return Obx(() {
      return GetMaterialApp(
        translations: LocalizationService(),
        locale: Locale('${localizationService.loadLocaleFromPreferences()}'),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.splash,
        getPages: AppRouter.routes,
      );
    });
  }
}
