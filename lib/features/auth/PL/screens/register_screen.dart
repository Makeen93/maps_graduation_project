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

import '../widgets/pick_image_widget.dart';

class RegisterScreen extends GetView<RegisterController> {
  final storage = Get.put(StorageService());
  final userData = Get.put(FirebaseAuthService());

  var appMethods = Get.find<MyAppMethods>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final RxBool obscureText1 = true.obs;
  final RxBool obscureText2 = true.obs;
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return LoadingWidget(
          isLoading: controller.isLoading.value,
          child: Padding(
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
                    child: PickImageWidget(
                      pickedImage: controller.pickedImage.value,
                      function: () async {
                        await controller.pickImage();
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Form(
                    // key: _formKey,
                    child: Obx(() {
                      return Column(
                        children: [
                          TextFormField(
                            controller: controller.nameController,
                            focusNode: _nameFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Full name'.tr,
                              prefixIcon: const Icon(IconlyLight.profile),
                            ),
                            validator: (value) {
                              return MyValidators.displayNamevalidator(value);
                            },
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_emailFocusNode);
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: controller.emailController,
                            focusNode: _emailFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email address'.tr,
                              prefixIcon: const Icon(IconlyLight.message),
                            ),
                            validator: (value) {
                              return MyValidators.emailValidator(value);
                            },
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: controller.passwordController,
                            focusNode: _passwordFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscureText1.value,
                            decoration: InputDecoration(
                              hintText: '*********',
                              prefixIcon: const Icon(IconlyLight.lock),
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
                            ),
                            validator: (value) {
                              return MyValidators.passwordValidator(value);
                            },
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_confirmPasswordFocusNode);
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: controller.confirmPasswordController,
                            focusNode: _confirmPasswordFocusNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscureText2.value,
                            decoration: InputDecoration(
                              hintText: '*********',
                              prefixIcon: const Icon(IconlyLight.lock),
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
                            ),
                            validator: (value) {
                              return MyValidators.repeatPasswordValidator(
                                value: value,
                                password: controller.passwordController.text,
                              );
                            },
                            onFieldSubmitted: (value) async {
                              if (true) {
                                if (controller.pickedImage.value == null) {
                                  appMethods.showErrorOrWarningDialog(
                                      subtitle:
                                          'Make sure to pick up an image'.tr,
                                      fct: () {});
                                  return;
                                }
                                controller.registerUser(
                                  email: controller.emailController.text.trim(),
                                  name: controller.nameController.text.trim(),
                                  // user: UserEntity(
                                  //   userCart: [],
                                  //   userWish: [],
                                  //   userId: userData.userId ?? '',
                                  //   userImage: storage.url ?? '',
                                  //   createdAt: Timestamp.now(),
                                  //   userEmail: _emailController.text.trim(),
                                  //   userName: _nameController.text.trim(),
                                  // ),
                                  filePath: controller.pickedImage.value,
                                  password:
                                      controller.passwordController.text.trim(),
                                );
                              }
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
                                controller.registerUser(
                                  email: controller.emailController.text.trim(),
                                  name: controller.nameController.text.trim(),
                                  filePath: controller.pickedImage.value,
                                  password:
                                      controller.passwordController.text.trim(),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
