import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/assets_manager.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/core/widgets/empty_bag.dart';
import 'package:maps_graduation_project/core/widgets/loading_manger.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/wishList/BL/controllers/wishlist_controller.dart';

import '../../../product/PL/widgets/product_widget.dart';

class WishlistScreen extends GetView<WishlistController> {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var myMethods = Get.find<MyAppMethods>();
    return Obx(() {
      return LoadingWidget(
        isLoading: controller.isLoading.value,
        child: controller.wishlistItems.isEmpty
            ? Scaffold(
                body: Center(
                  child: EmptyBagWidget(
                    imagePath: AssetsManager.bagWish,
                    title: 'Your wishlist is empty'.tr,
                    subtitle: 'Looks like you didnot have wishlist'.tr,
                    buttonText: 'Shop Now'.tr,
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: TitlesTextWidget(
                      label:
                          "${'Wishlist'.tr} (${controller.wishlistItems.length})"),
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
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DynamicHeightGridView(
                    itemCount: controller.wishlistItems.length,
                    builder: ((context, index) {
                      var wishlistItem =
                          controller.wishlistItems.values.toList()[index];

                      return ProductWidget(
                        productId: wishlistItem.productId,
                      );
                    }),
                    crossAxisCount: 2,
                  ),
                )),
      );
    });
  }
}
