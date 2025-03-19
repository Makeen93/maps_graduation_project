import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps_graduation_project/core/widgets/custom_snackbar.dart';
import 'package:maps_graduation_project/features/auth/DL/data/repos/auth_repo_impl.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';

import '../../../../core/services/my_app_method.dart';

class RegisterController extends GetxController {
  final AuthRepositoryImp authRepository;

  RegisterController({required this.authRepository});
  var myAppMethods = Get.find<MyAppMethods>();
  final RxBool isLoading = false.obs;
  final Rx<XFile?> pickedImage = Rx<XFile?>(null);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> registerUser(
      {required String email,
      required String name,
      required XFile? filePath,
      required String password}) async {
    try {
      isLoading.value = true;
      await authRepository.addUser(
          email: email, filePath: filePath, password: password, name: name);
      CustomSnackbar.show(
          title: 'Success'.tr, message: 'User registered successfully'.tr);
      Get.offAllNamed(AppRouter.login);
    } catch (e) {
      Get.snackbar('Error'.tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    await myAppMethods.imagePickerDialog(cameraFCT: () async {
      pickedImage.value = await picker.pickImage(source: ImageSource.camera);
    }, galleryFCT: () async {
      pickedImage.value = await picker.pickImage(source: ImageSource.gallery);
    }, removeFCT: () {
      pickedImage.value = null;
    });
  }
}
