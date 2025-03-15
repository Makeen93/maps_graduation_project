import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/firebase_auth_service.dart';
import 'package:maps_graduation_project/features/auth/DL/data/repos/auth_repo_impl.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';

class SplashController extends GetxController {
  final FirebaseAuthService firebaseAuthService;

  SplashController({required this.firebaseAuthService});

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    final user = firebaseAuthService.isLoggedIn();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user) {
        Get.toNamed(AppRouter.home);
      } else {
        Get.toNamed(AppRouter.login);
      }
    });
  }
}
