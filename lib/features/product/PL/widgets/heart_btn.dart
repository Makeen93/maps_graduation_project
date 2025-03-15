import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/wishlist_controller.dart';

class HeartButtonWidget extends StatelessWidget {
  const HeartButtonWidget({
    super.key,
    this.size = 22,
    this.color = Colors.transparent,
    required this.productId,
  });

  final double size;
  final Color color;
  final String productId;
  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();
    final methods = Get.find<MyAppMethods>();
    // final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Obx(() => IconButton(
            style: IconButton.styleFrom(
              shape: const CircleBorder(),
            ),
            onPressed: () async {
              try {
                if (wishlistController.wishlistItems
                    .any((item) => item.productId == productId)) {
                  // Remove item from wishlist
                  final itemToRemove = wishlistController.wishlistItems
                      .firstWhere((item) => item.productId == productId);
                  await wishlistController.removeItem(
                      itemToRemove.id, productId);
                } else {
                  // Add item to wishlist
                  await wishlistController.addToWishlist(productId);
                }
              } catch (e) {
                methods.showErrorOrWarningDialog(
                    subtitle: e.toString(), fct: () {});
              } finally {
                // Stop loading
                wishlistController.isLoading.value = false;
              }
            },
            icon: wishlistController.isLoading.value
                ? const CircularProgressIndicator()
                : Icon(
                    wishlistController.wishlistItems
                            .any((item) => item.productId == productId)
                        ? IconlyBold.heart
                        : IconlyLight.heart,
                    size: size,
                    color: wishlistController.wishlistItems
                            .any((item) => item.productId == productId)
                        ? Colors.red
                        : Colors.grey,
                  ),
          )),
    );
  }
}
