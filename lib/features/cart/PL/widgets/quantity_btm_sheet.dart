import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/widgets/subtitle_text.dart';
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
            // Decrement quantity while making sure it doesn't go below 1
            if (cartModel.quantity > 1) {
              cartController.updateQuantity(
                  productId: cartModel.productId,
                  quantity: cartModel.quantity - 1); // Notify parent
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

    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Column(
    //     children: [
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Container(
    //         height: 6,
    //         width: 50,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(12.0),
    //           color: Colors.grey,
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Expanded(
    //         child: ListView.builder(
    //             shrinkWrap: true,
    //             physics: NeverScrollableScrollPhysics(),
    //             itemCount: 30,
    //             itemBuilder: (context, index) {
    //               return Obx(() {
    //                 return InkWell(
    //                   onTap: () {
    //                     cartController.updateQuantity(
    //                         productId: cartModel.productId,
    //                         quantity: index + 1);
    //                     // log("index  $index");
    //                     Navigator.pop(context);
    //                   },
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(3.0),
    //                     child: Center(
    //                       child: SubtitleTextWidget(
    //                         label: "${index + 1}",
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               });
    //             }),
    //       ),
    //     ],
    //   ),
    // );
  }
}
