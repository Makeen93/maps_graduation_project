import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/firebase_auth_service.dart';
import 'package:maps_graduation_project/features/splash/BL/controller/splash_controller.dart';

import '../../../../core/services/assets_manager.dart';

class SplashScreen extends StatelessWidget {
  final SplashController controller = Get.put(
      SplashController(firebaseAuthService: Get.find<FirebaseAuthService>()));

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.shoppingCart), // Your splash logo
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Loading indicator
          ],
        ),
      ),
    );
  }
}
