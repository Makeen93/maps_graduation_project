import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:maps_graduation_project/features/auth/DL/domain/entites/user_entity.dart';

import '../widgets/pick_image_widget.dart';

class RegisterScreen extends GetView<RegisterController> {
  final storage = Get.put(StorageService());
  final userData = Get.put(FirebaseAuthService());

  var appMethods = Get.find<MyAppMethods>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitlesTextWidget(label: 'Welcome'),
                        SubtitleTextWidget(label: 'Your welcome message'),
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
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.nameController,
                          focusNode: _nameFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: 'Full name',
                            prefixIcon: Icon(IconlyLight.message),
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
                          decoration: const InputDecoration(
                            hintText: 'Email address',
                            prefixIcon: Icon(IconlyLight.message),
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
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: '*********',
                            prefixIcon: const Icon(IconlyLight.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                // Toggle obscureText
                              },
                              icon: const Icon(Icons.visibility),
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
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: '*********',
                            prefixIcon: const Icon(IconlyLight.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                // Toggle obscureText
                              },
                              icon: const Icon(Icons.visibility),
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
                            label: const Text(
                              'Sign up',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              print('MAeelmasdddddddd');
                              // print(userData.user!.uid)
                              controller.registerUser(
                                email: controller.emailController.text.trim(),
                                name: controller.nameController.text.trim(),
                                // user: UserEntity(
                                //   userCart: [],
                                //   userWish: [],
                                //   // userId: userData.user!.uid,
                                //   userImage: storage.url ?? '',
                                //   createdAt: Timestamp.now(),
                                //   userEmail: _emailController.text.trim(),
                                //   userName: _nameController.text.trim(),
                                //   userId: userData.userId ?? '',
                                // ),
                                filePath: controller.pickedImage.value,
                                password:
                                    controller.passwordController.text.trim(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
