import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/assets_manager.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/core/widgets/empty_bag.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/wishList/BL/controllers/wishlist_controller.dart';

import '../../../product/PL/widgets/product_widget.dart';

class WishlistScreen extends GetView<WishlistController> {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var myMethods = Get.find<MyAppMethods>();
    return Obx(() {
      return controller.wishlistItems.isEmpty
          ? Scaffold(
              body: EmptyBagWidget(
                imagePath: AssetsManager.bagWish,
                title: 'Your wishlist is empty',
                subtitle: 'Looks like you didnot have wishlist',
                buttonText: 'Shop Now',
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: TitlesTextWidget(
                    label:
                        "${'Wishlist'} (${controller.wishlistItems.length})"),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(AssetsManager.shoppingCart),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      myMethods.showErrorOrWarningDialog(
                          isError: false,
                          subtitle: 'Remove Items'.tr,
                          fct: () async {
                            await controller.clearWishlist();
                          });
                    },
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              body: DynamicHeightGridView(
                itemCount: controller.wishlistItems.length,
                builder: ((context, index) {
                  return ProductWidget(
                    productId:
                        controller.wishlistItems.toList()[index].productId,
                  );
                }),
                crossAxisCount: 2,
              ),
            );
    });
  }
}
