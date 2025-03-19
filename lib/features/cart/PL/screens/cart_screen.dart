import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/assets_manager.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/core/widgets/empty_bag.dart';
import 'package:maps_graduation_project/core/widgets/loading_manger.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/cart/BL/controllers/cart_controller.dart';
import 'package:maps_graduation_project/features/cart/PL/widgets/bottom_checkout.dart';
import 'package:maps_graduation_project/features/cart/PL/widgets/cart_widget.dart';
import 'package:maps_graduation_project/features/order/BL/controllers/order_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var orderController = Get.find<OrderController>();
    var myMethods = Get.find<MyAppMethods>();
    return Obx(() {
      return cartController.cartItems.isEmpty
          ? Scaffold(
              body: EmptyBagWidget(
                imagePath: AssetsManager.shoppingBasket,
                title: 'Your cart is empty'.tr,
                subtitle: 'Looks like you didn'.tr,
                buttonText: 'Shop Now'.tr,
              ),
            )
          : Scaffold(
              bottomSheet: CartBottomCheckout(
                function: () async {
                  await orderController.addOrder();
                  await cartController.clearCart();
                },
              ),
              appBar: AppBar(
                title: Obx(() => TitlesTextWidget(
                    label:
                        "${'Cart'.tr} (${cartController.cartItems.length})")),
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
                            await cartController.clearCart();
                          });
                    },
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              body: LoadingWidget(
                isLoading: cartController.isLoading.value,
                child: Column(
                  children: [
                    Obx(() {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (context, index) {
                            var cartItem =
                                cartController.cartItems.values.toList()[index];
                            return CartWidget(cart: cartItem);
                          },
                        ),
                      );
                    }),
                    const SizedBox(
                      height: kBottomNavigationBarHeight + 25,
                    )
                  ],
                ),
              ),
            );
    });
  }
}
