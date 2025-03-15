import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.transparent, // Default background color
    Color textColor = Colors.black, // Default text color
    Duration duration = const Duration(seconds: 3), // Default duration
    IconData? icon, // Optional icon
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      duration: duration,
      icon: icon != null ? Icon(icon, color: textColor) : null,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
