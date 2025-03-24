import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/features/cart/BL/controllers/cart_controller.dart';
import 'package:maps_graduation_project/features/cart/DL/data/models/cart_model.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  const QuantityBottomSheetWidget({super.key, required this.cartModel});
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (cartModel.quantity > 1) {
              cartController.updateQuantity(
                  productId: cartModel.productId,
                  quantity: cartModel.quantity - 1);
            }
          },
          color: Colors.blue,
        ),
        Text(
          '${cartModel.quantity}',
          style: const TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            cartController.updateQuantity(
                productId: cartModel.productId,
                quantity: cartModel.quantity + 1);
          },
          color: Colors.blue,
        ),
      ],
    );
  }
}
