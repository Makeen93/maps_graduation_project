// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/core/widgets/app_name_text.dart';
import 'package:maps_graduation_project/core/widgets/subtitle_text.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';
import 'package:maps_graduation_project/features/product/PL/widgets/heart_btn.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    // this.productId,
  });
  @override
  Widget build(BuildContext context) {
    var myMethod = Get.find<MyAppMethods>();
    var productController = Get.find<ProductController>();
    var productId = Get.arguments;
    final product = productController.findByProdId(productId);
    Size size = MediaQuery.of(context).size;
    return product == null
        ? const SizedBox.shrink()
        : Scaffold(
            appBar: AppBar(
              title: const AppNameTextWidget(fontSize: 20),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  )),
              // automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  FancyShimmerImage(
                    imageUrl: product.productImage,
                    height: size.height * 0.38,
                    width: double.infinity,
                    boxFit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              // flex: 5,
                              child: Text(
                                product.productTitle,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            SubtitleTextWidget(
                              label: "${product.productPrice}\$",
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              HeartButtonWidget(
                                productId: product.productId,
                                color: Colors.blue.shade300,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight - 10,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          30,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      //  if (cartProvider.isProductInCart(
                                      //       productId: product.productId)) {
                                      //     return;
                                      //   }
                                      //  try {
                                      //     await cartProvider.addToCartFirebase(
                                      //         productId: product.productId,
                                      //         qty: 1,
                                      //         context: context);
                                      //   } catch (error) {
                                      //     // ignore: use_build_context_synchronously
                                      //     MyAppMethods.showErrorORWarningDialog(
                                      //         context: context,
                                      //         subtitle: error.toString(),
                                      //         fct: () {});
                                      //   }
                                    },
                                    icon: const Icon(
                                        // cartProvider.isProductInCart(
                                        //     productId: product.productId)
                                        // ? Icons.check
                                        // :
                                        Icons.add_shopping_cart),
                                    label: Text(
                                      // cartProvider.isProductInCart(
                                      //         productId: product.productId)
                                      //     ? 'In Cart'.tr
                                      //     :
                                      'Add to cart'.tr,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitlesTextWidget(label: 'About this item'.tr),
                            SubtitleTextWidget(
                                label: "In ${product.productCategory}")
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SubtitleTextWidget(label: product.productDescription),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
