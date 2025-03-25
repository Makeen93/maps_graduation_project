import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:maps_graduation_project/const/my_validator.dart';
import 'package:maps_graduation_project/core/services/firebase_auth_service.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/core/services/storage_service.dart';
import 'package:maps_graduation_project/core/widgets/app_name_text.dart';
import 'package:maps_graduation_project/core/widgets/loading_manger.dart';
import 'package:maps_graduation_project/core/widgets/subtitle_text.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/auth/BL/controllers/register_controller.dart';

import '../widgets/custom_text_form_field.dart';
import '../widgets/pick_image_widget.dart';

class RegisterScreen extends GetView<RegisterController> {
  final storage = Get.put(StorageService());
  final userData = Get.put(FirebaseAuthService());

  var appMethods = Get.find<MyAppMethods>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RxBool obscureText1 = true.obs;
  final RxBool obscureText2 = true.obs;

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60.0),
                const AppNameTextWidget(fontSize: 30),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitlesTextWidget(label: 'Welcome'.tr),
                      SubtitleTextWidget(label: 'Your welcome message'.tr),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Obx(() {
                    return PickImageWidget(
                      pickedImage: controller.pickedImage.value,
                      function: () async {
                        await controller.pickImage();
                      },
                    );
                  }),
                ),
                const SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: Obx(() {
                    return Column(
                      children: [
                        CustomTextFormField(
                          labelText: 'User Name'.tr,
                          hintText: 'Enter User Name..'.tr,
                          prefixIcon: IconlyLight.profile,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            return MyValidators.displayNamevalidator(value);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          labelText: 'Email Address'.tr,
                          hintText: 'Enter Valid Email..'.tr,
                          prefixIcon: IconlyLight.message,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return MyValidators.emailValidator(value);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          labelText: 'Enter Password'.tr,
                          hintText: "*********",
                          prefixIcon: Icons.lock,
                          obscureText: obscureText1.value,
                          controller: passwordController,
                          suffixIcon: IconButton(
                            onPressed: () {
                              obscureText1.value = !obscureText1.value;
                            },
                            icon: Icon(
                              obscureText1.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          labelText: 'Confirm Password'.tr,
                          hintText: "*********",
                          prefixIcon: Icons.lock,
                          obscureText: obscureText2.value,
                          controller: confirmPasswordController,
                          suffixIcon: IconButton(
                            onPressed: () {
                              obscureText2.value = !obscureText2.value;
                            },
                            icon: Icon(
                              obscureText2.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            return MyValidators.repeatPasswordValidator(
                              value: value,
                              password: passwordController.text,
                            );
                          },
                        ),
                        const SizedBox(height: 25.0),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(IconlyLight.add_user),
                              label: Text(
                                'Sign up'.tr,
                                style: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  controller.registerUser(
                                    email: emailController.text.trim(),
                                    name: nameController.text.trim(),
                                    filePath: controller.pickedImage.value,
                                    password: passwordController.text.trim(),
                                  );
                                }
                              },
                            )),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
