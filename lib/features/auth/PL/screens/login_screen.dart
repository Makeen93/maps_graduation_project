import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/const/my_validator.dart';
import 'package:maps_graduation_project/core/widgets/app_name_text.dart';
import 'package:maps_graduation_project/core/widgets/subtitle_text.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/auth/BL/controllers/auth_controller.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';

import '../widgets/custom_text_form_field.dart';
import '../widgets/google_btn.dart';

class LoginScreen extends GetView<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxBool obscureText = true.obs;
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60.0),
              const AppNameTextWidget(fontSize: 30),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerLeft,
                child: TitlesTextWidget(label: 'Welcome back'.tr),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: 'Email address'.tr,
                      hintText: 'Email address'.tr,
                      prefixIcon: Icons.email,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Obx(() {
                      return CustomTextFormField(
                          labelText: 'Enter Password'.tr,
                          hintText: "*********",
                          prefixIcon: Icons.lock,
                          obscureText: obscureText.value,
                          controller: _passwordController,
                          suffixIcon: IconButton(
                            onPressed: () {
                              obscureText.value = !obscureText.value;
                            },
                            icon: Icon(
                              obscureText.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                          onChanged: (value) {
                            if (_formKey.currentState!.validate()) {
                              controller.login(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                            }
                          });
                    }),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed('');
                        },
                        child: SubtitleTextWidget(
                          label: 'Forgot password'.tr,
                          textDecoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.login),
                        label: Text(
                          'Login'.tr,
                          style: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () async {
                          if (true) {
                            controller.login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SubtitleTextWidget(label: 'OR CONNECT USING'.tr),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: kBottomNavigationBarHeight + 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: kBottomNavigationBarHeight,
                                child: FittedBox(
                                  child: GoogleButton(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SubtitleTextWidget(label: 'Don\'t have an account?'.tr),
                        TextButton(
                          child: SubtitleTextWidget(
                            label: 'Sign up'.tr,
                            textDecoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic,
                          ),
                          onPressed: () {
                            Get.toNamed(AppRouter.register);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
