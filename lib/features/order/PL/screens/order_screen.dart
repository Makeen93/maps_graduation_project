import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/widgets/loading_manger.dart';
import 'package:maps_graduation_project/features/order/BL/controllers/order_controller.dart';

import '../../../../core/services/assets_manager.dart';
import '../../../../core/widgets/empty_bag.dart';
import '../../../../core/widgets/title_text.dart';
import '../widgets/order_cart_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();
    return Obx(() {
      return LoadingWidget(
        isLoading: orderController.isLoading.value,
        child: orderController.orders.isEmpty
            ? Scaffold(
                body: EmptyBagWidget(
                  imagePath: AssetsManager.bagWish,
                  title: 'Your orders is empty'.tr,
                  subtitle: 'Looks like you didnot have any order'.tr,
                  buttonText: 'Shop Now'.tr,
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: TitlesTextWidget(
                      label:
                          "${'Orders'.tr} (${orderController.orders.length})"),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(AssetsManager.shoppingCart),
                  ),
                ),
                body: ListView.builder(
                  itemCount: orderController.orders.length,
                  itemBuilder: (context, index) {
                    return OrderCardWidget(
                        order: orderController.orders[index]);
                  },
                )),
      );
    });
  }
}
