import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/features/wishList/BL/controllers/wishlist_controller.dart';

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
    return Obx(() {
      bool isInWishlist = wishlistController.wishlistItems
          .any((item) => item.productId == productId);
      return CircleAvatar(
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: IconButton(
            style: IconButton.styleFrom(
              shape: const CircleBorder(),
            ),
            onPressed: () async {
              try {
                if (isInWishlist) {
                  // Remove item from wishlist
                  await wishlistController.removeFromWishlist(productId);
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
          ),
        ),
      );
    });
  }
}
