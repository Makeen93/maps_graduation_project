import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/features/cart/BL/controllers/cart_controller.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/viewed_product_controller.dart';
import '../../../../core/widgets/subtitle_text.dart';
import 'heart_btn.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productController = Get.find<ProductController>();

    final cartController = Get.find<CartController>();
    final myAppMethods = Get.find<MyAppMethods>();

    final viewController = Get.find<ViewedProductController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          // viewController.addProductToHistory(
          //      productController.productId);
          // await Navigator.pushNamed(context, ProductDetails.routName,
          //     arguments: productController.productId);
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: '',
                    // productController.productImage,
                    width: size.width * 0.28,
                    height: size.width * 0.28,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '',
                      // productController.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          // HeartButtonWidget(
                          //     productId: productController.productId
                          //     ),
                          IconButton(
                            onPressed: () async {
                              // if (cartController.isProductInCart(
                              //     productId: productController.productId)) {
                              //   return;
                              // }
                              // cartController.addProductToCart(
                              //     productId: getCurrProduct.productId);
                              // try {
                              //   await cartController.addToCart(
                              //     productId: productController.productId,
                              //     qty: 1,
                              //   );
                              // } catch (error) {
                              //   // ignore: use_build_context_synchronously
                              //   myAppMethods.showErrorOrWarningDialog(
                              //       subtitle: error.toString(), fct: () {});
                              // }
                            },
                            icon: const Icon(
                              // cartController.isProductInCart(
                              //         productId: productController.productId)
                              //     ?
                              //  Icons.check
                              // :
                              Icons.add_shopping_cart_rounded,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // FittedBox(
                    //   child: SubtitleTextWidget(
                    //     label: "${productController.productPrice}\$",
                    //     color: Colors.blue,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
