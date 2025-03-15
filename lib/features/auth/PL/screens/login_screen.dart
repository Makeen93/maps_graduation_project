import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/const/my_validator.dart';
import 'package:maps_graduation_project/core/widgets/app_name_text.dart';
import 'package:maps_graduation_project/core/widgets/subtitle_text.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/auth/BL/controllers/auth_controller.dart';
import 'package:maps_graduation_project/features/auth/PL/screens/register_screen.dart';
import 'package:maps_graduation_project/features/auth/PL/widgets/custom_text_form_field.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';

import '../widgets/google_btn.dart';

class LoginScreen extends GetView<AuthController> {
  // final AuthController _authController = Get.find();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
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
              const Align(
                alignment: Alignment.centerLeft,
                child: TitlesTextWidget(label: 'Welcome back'),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Obx(() {
                      return TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText.value,
                        decoration: InputDecoration(
                          hintText: "*********",
                          prefixIcon: const Icon(Icons.lock),
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
                        ),
                        validator: (value) {
                          return MyValidators.passwordValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            controller.login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                          }
                        },
                      );
                    }),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed('');
                        },
                        child: const SubtitleTextWidget(
                          label: 'Forgot password',
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
                        label: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
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
                    const SubtitleTextWidget(label: 'OR CONNECT USING'),
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
                            const SizedBox(width: 8),
                            Expanded(
                              child: SizedBox(
                                height: kBottomNavigationBarHeight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Guest',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Get.offAllNamed('');
                                  },
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
                        const SubtitleTextWidget(
                            label: 'Don\'t have an account?'),
                        TextButton(
                          child: const SubtitleTextWidget(
                            label: 'Sign up',
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
