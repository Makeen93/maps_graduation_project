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
      bool isInWishlist =
          wishlistController.isProductInWishlist(productId: productId);
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
                  await wishlistController.removeFromWishlist(productId);
                } else {
                  await wishlistController.addToWishlist(productId);
                }
              } catch (e) {
                methods.showErrorOrWarningDialog(
                    subtitle: e.toString(), fct: () {});
              }
            },
            icon: wishlistController.isLoading.value
                ? const CircularProgressIndicator()
                : Icon(
                    isInWishlist ? IconlyBold.heart : IconlyLight.heart,
                    size: size,
                    color: isInWishlist ? Colors.red : Colors.grey,
                  ),
          ),
        ),
      );
    });
  }
}
