import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/features/cart/BL/controllers/cart_controller.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';
import '../../../../core/widgets/subtitle_text.dart';
import 'heart_btn.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  final ProductModel productModel;
  const LatestArrivalProductsWidget({super.key, required this.productModel});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productController = Get.find<ProductController>();

    final cartController = Get.find<CartController>();
    final myAppMethods = Get.find<MyAppMethods>();
    var product = productController.findByProdId(productModel.productId);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          // viewController.addProductToHistory(productModel.productId);
          Get.toNamed(AppRouter.productDetail,
              arguments: productModel.productId);
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
                    imageUrl: product!.productImage,
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
                    Text(
                      product.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Obx(() {
                      return FittedBox(
                        child: Row(
                          children: [
                            HeartButtonWidget(productId: product.productId),
                            IconButton(
                              onPressed: () async {
                                if (cartController.isProductInCart(
                                    productId: product.productId)) {
                                  return;
                                }
                                try {
                                  await cartController.addToCart(
                                    productId: product.productId,
                                    qty: 1,
                                  );
                                } catch (error) {
                                  myAppMethods.showErrorOrWarningDialog(
                                      subtitle: error.toString(), fct: () {});
                                }
                              },
                              icon: Icon(
                                cartController.isProductInCart(
                                        productId: product.productId)
                                    ? Icons.check
                                    : Icons.add_shopping_cart_rounded,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    FittedBox(
                      child: SubtitleTextWidget(
                        label: "${product.productPrice}\$",
                        color: Colors.blue,
                      ),
                    ),
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
