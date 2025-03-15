import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/subtitle_text.dart';
import '../widgets/title_text.dart';
import 'assets_manager.dart';

class MyAppMethods extends GetxController {
  /// Shows an error or warning dialog.
  Future<void> showErrorOrWarningDialog({
    required String subtitle,
    required Function fct,
    bool isError = true,
  }) async {
    await Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetsManager.warning,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 16.0),
            SubtitleTextWidget(
              label: subtitle,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: !isError,
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: SubtitleTextWidget(
                      label: 'Cancel'.tr,
                      color: Colors.green,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    fct();
                    Get.back();
                  },
                  child: SubtitleTextWidget(
                    label: 'OK'.tr,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Shows an image picker dialog.
  Future<void> imagePickerDialog({
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await Get.dialog(
      AlertDialog(
        title: Center(
          child: TitlesTextWidget(
            label: 'Choose option'.tr,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              TextButton.icon(
                onPressed: () {
                  cameraFCT();
                  if (Get.isDialogOpen!) Get.back();
                },
                icon: const Icon(Icons.camera),
                label: Text('Camera'.tr),
              ),
              TextButton.icon(
                onPressed: () {
                  galleryFCT();
                  if (Get.isDialogOpen!) Get.back();
                },
                icon: const Icon(Icons.image),
                label: Text('Gallery'.tr),
              ),
              TextButton.icon(
                onPressed: () {
                  removeFCT();
                  if (Get.isDialogOpen!) Get.back();
                },
                icon: const Icon(Icons.remove),
                label: Text('Remove'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
