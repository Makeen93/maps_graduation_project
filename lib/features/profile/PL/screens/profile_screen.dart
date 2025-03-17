import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:maps_graduation_project/core/services/firebase_auth_service.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/core/utils/convert_code_to_flag.dart';
import 'package:maps_graduation_project/core/widgets/app_name_text.dart';
import 'package:maps_graduation_project/core/widgets/loading_manger.dart';
import 'package:maps_graduation_project/core/widgets/subtitle_text.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/auth/BL/controllers/auth_controller.dart';
import 'package:maps_graduation_project/features/home/BL/controllers/theme_service_controller.dart';
import 'package:maps_graduation_project/features/profile/BL/controllers/profile_controller.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';

import '../../../../core/services/assets_manager.dart';
import '../../../../core/services/localization_service.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var profileController = Get.find<ProfileController>();
    print('${controller.userModel}');
    var user = Get.find<FirebaseAuthService>();
    var authController = Get.find<AuthController>();
    var themeController = Get.find<ThemeServiceController>();

    var myMethod = Get.find<MyAppMethods>();
    return Scaffold(
        appBar: AppBar(
          title: const AppNameTextWidget(fontSize: 20),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
        ),
        body: Obx(() {
          return LoadingWidget(
            isLoading: controller.isLoading.value,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: user == null ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TitlesTextWidget(
                        label: 'Please login to have ultimate access'.tr),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                controller.userModel == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    width: 3),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    controller.userModel.value?.userImage ??
                                        'https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitlesTextWidget(
                                    label:
                                        controller.userModel.value?.userName ??
                                            ''),
                                SubtitleTextWidget(
                                    label:
                                        controller.userModel.value?.userEmail ??
                                            ''),
                              ],
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitlesTextWidget(label: 'General'.tr),
                      user == null
                          ? const SizedBox.shrink()
                          : CustomListTile(
                              imagePath: AssetsManager.orderSvg,
                              text: 'AllOrders'.tr,
                              function: () async {
                                // await Navigator.pushNamed(
                                //   context,
                                //   OrdersScreenFree.routeName,
                                // );
                              },
                            ),
                      user == null
                          ? const SizedBox.shrink()
                          : CustomListTile(
                              imagePath: AssetsManager.wishlistSvg,
                              text: 'Wishlist'.tr,
                              function: () async {
                                // await Navigator.pushNamed(
                                //   context,
                                //   WishlistScreen.routName,
                                // );
                              },
                            ),
                      CustomListTile(
                        imagePath: AssetsManager.recent,
                        text: 'ViewedRecently'.tr,
                        function: () async {
                          // await Navigator.pushNamed(
                          //   context,
                          //   ViewedRecentlyScreen.routName,
                          // );
                        },
                      ),
                      CustomListTile(
                        imagePath: AssetsManager.address,
                        text: 'Address'.tr,
                        function: () {},
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      TitlesTextWidget(label: 'Settings'.tr),
                      const SizedBox(
                        height: 7,
                      ),
                      SwitchListTile(
                        secondary: Image.asset(
                          AssetsManager.theme,
                          height: 30,
                        ),
                        title: Text(themeController.isDarkMode
                            ? 'Dark Mode'.tr
                            : 'Light Mode'.tr),
                        value: themeController.isDarkMode,
                        // themeProvider.getIsDarkTheme,
                        onChanged: (value) {
                          themeController.toggleTheme();
                        },
                      ),
                      CustomListTile(
                        imagePath: AssetsManager.langSvg,
                        text: 'Languages'.tr,
                        function: () async {
                          // Get.bottomSheet(Container(
                          //   height: 150,
                          //   color: Colors.amberAccent,
                          //   child: const Center(
                          //       child: Text(
                          //     'Count has reached }',
                          //     style: TextStyle(
                          //         fontSize: 28.0, color: Colors.white),
                          //   )),
                          // ));
                          showLanguageDialog();
                          // Get.back();
                          // await Navigator.pushNamed(
                          //   context,
                          //   WishlistScreen.routName,
                          // );
                        },
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                    ),
                    icon: Icon(user == null ? Icons.login : Icons.logout),
                    label: Text(
                      user == null ? 'Login'.tr : 'Logout'.tr,
                    ),
                    onPressed: () async {
                      await myMethod.showErrorOrWarningDialog(
                          subtitle: 'Are you sure'.tr,
                          fct: () async {
                            authController.signout();
                            Get.offAllNamed(AppRouter.login);
                          },
                          isError: false);
                    },
                  ),
                ),
              ],
            )),
          );
        }));
  }
}

void showLanguageDialog() {
  var localController = Get.find<LocalizationService>();
  Get.defaultDialog(
    title: 'Select Language',
    content: Column(
      children: [
        ListTile(
          leading: Text("US".toFlag, style: const TextStyle(fontSize: 30)),
          title: const Text('English'),
          onTap: () {
            localController.changeLocale('en');
            Get.back();
          },
        ),
        ListTile(
          leading: Text("TR".toFlag, style: const TextStyle(fontSize: 30)),
          title: const Text('Türkçe'),
          onTap: () {
            localController.changeLocale('tr');
            Get.back();
          },
        ),
        ListTile(
          leading: Text("SA".toFlag, style: const TextStyle(fontSize: 30)),
          title: const Text('العربية'),
          onTap: () {
            localController.changeLocale('ar');
            Get.back();
          },
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Get.back(); // Close the dialog
        },
        child: const Text('Cancel'),
      ),
    ],
  );
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.function});
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        imagePath,
        height: 30,
      ),
      title: SubtitleTextWidget(label: text),
      trailing: const Icon(IconlyLight.arrow_right_2),
    );
  }
}
