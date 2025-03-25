import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/cart/BL/controllers/cart_controller.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';

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
    var cartController = Get.find<CartController>();
    var methods = Get.find<MyAppMethods>();
    Size size = MediaQuery.of(context).size;
    return productController.findByProdId(productId) == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              elevation: 5,
              child: GestureDetector(
                onTap: () async {
                  Get.toNamed(AppRouter.productDetail, arguments: productId);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
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
                          PositionedDirectional(
                            start: 5,
                            top: 5,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 5,
                            child: TitlesTextWidget(
                              label: productController
                                  .findByProdId(productId)!
                                  .productTitle,
                              maxLines: 2,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 3,
                              child: SubtitleTextWidget(
                                  color: Colors.red,
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
            ),
          );
  }
}
