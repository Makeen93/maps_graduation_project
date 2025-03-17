import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/cart/BL/controllers/cart_controller.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/viewed_product_controller.dart';
import 'package:maps_graduation_project/features/product/PL/widgets/heart_btn.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';

import '../../../../core/widgets/subtitle_text.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.productId,
  });
  final String productId;

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    var viewedProductController = Get.find<ViewedProductController>();
    var cartController = Get.find<CartController>();
    var methods = Get.find<MyAppMethods>();
    Size size = MediaQuery.of(context).size;
    return productController.findByProdId(productId) == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () async {
                viewedProductController.addProductToHistory(productId);
                Get.toNamed(AppRouter.productDetail, arguments: productId);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: FancyShimmerImage(
                        imageUrl: productController
                            .findByProdId(productId)!
                            .productImage,
                        width: double.infinity,
                        height: size.height * 0.22,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TitlesTextWidget(
                            label: productController
                                .findByProdId(productId)!
                                .productTitle,
                            maxLines: 2,
                            fontSize: 18,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: HeartButtonWidget(
                              productId: productController
                                  .findByProdId(productId)!
                                  .productId),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: SubtitleTextWidget(
                                label:
                                    "${productController.findByProdId(productId)!.productPrice}\$"),
                          ),
                          Flexible(
                            child: Material(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.lightBlue,
                              child: Obx(() {
                                return InkWell(
                                  splashColor: Colors.red,
                                  borderRadius: BorderRadius.circular(16.0),
                                  onTap: () async {
                                    if (cartController.isProductInCart(
                                        productId: productController
                                            .findByProdId(productId)!
                                            .productId)) {
                                      return;
                                    }
                                    cartController.addProductToCart(
                                        productId: productController
                                            .findByProdId(productId)!
                                            .productId);
                                    try {
                                      await cartController.addToCart(
                                        productId: productController
                                            .findByProdId(productId)!
                                            .productId,
                                        qty: 1,
                                      );
                                    } catch (error) {
                                      methods.showErrorOrWarningDialog(
                                          subtitle: error.toString(),
                                          fct: () {});
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      cartController.isProductInCart(
                                              productId: productController
                                                  .findByProdId(productId)!
                                                  .productId)
                                          ? Icons.check
                                          : Icons.add_shopping_cart_rounded,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          // SizedBox(
                          //   width: 1,
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
