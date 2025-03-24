import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/widgets/subtitle_text.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/cart/BL/controllers/cart_controller.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({super.key, required this.function});
  final Function function;
  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var productController = Get.find<ProductController>();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(builder: (context) {
                        return FittedBox(
                            child: TitlesTextWidget(
                                label:
                                    "${'Total'.tr} (${cartController.cartItems.length} ${'products'.tr}/${cartController.getQty()} ${'Items'.tr})"));
                      }),
                      SubtitleTextWidget(
                        label:
                            "${cartController.getTotal(productProvider: productController).toStringAsFixed(2)}\$",
                        color: Colors.blue,
                      ),
                    ],
                  );
                }),
              ),
              ElevatedButton(
                onPressed: () async {
                  function();
                },
                child: Text('Checkout'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
