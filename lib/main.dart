import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';

import 'app_error_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ErrorWidget.builder = (FlutterErrorDetails details) => AppErrorWidget(
        errorDetails: details,
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.splash,
      getPages: AppRouter.routes,
    );
  }
}
