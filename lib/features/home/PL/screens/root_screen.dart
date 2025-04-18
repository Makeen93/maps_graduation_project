import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:maps_graduation_project/features/cart/BL/controllers/cart_controller.dart';
import 'package:maps_graduation_project/features/cart/PL/screens/cart_screen.dart';
import 'package:maps_graduation_project/features/home/BL/controllers/root_controller.dart';
import 'package:maps_graduation_project/features/product/PL/screens/search_screen.dart';
import 'package:maps_graduation_project/features/home/PL/screens/home_screen.dart';
import 'package:maps_graduation_project/features/profile/PL/screens/profile_screen.dart';

class RootScreen extends StatelessWidget {
  final BottomNavigationController controller =
      Get.put(BottomNavigationController());

  final List<Widget> pages = [
    const HomeScreen(),
    SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return Scaffold(
      body: SafeArea(child: Obx(() => pages[controller.selectedIndex.value])),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 2,
          height: kBottomNavigationBarHeight,
          onDestinationSelected: controller.changePage,
          destinations: [
            NavigationDestination(
              selectedIcon: const Icon(IconlyBold.home),
              icon: const Icon(IconlyLight.home),
              label: 'Home'.tr,
            ),
            NavigationDestination(
              selectedIcon: const Icon(IconlyBold.search),
              icon: const Icon(IconlyLight.search),
              label: 'Search'.tr,
            ),
            NavigationDestination(
              selectedIcon: const Icon(IconlyBold.bag_2),
              icon: Badge(
                backgroundColor: Colors.blue,
                label: Obx(() {
                  return Text((cartController.cartItems.length.toString()));
                }),
                child: const Icon(IconlyLight.bag_2),
              ),
              label: 'Cart'.tr,
            ),
            NavigationDestination(
              selectedIcon: const Icon(IconlyBold.profile),
              icon: const Icon(IconlyLight.profile),
              label: 'Profile'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
