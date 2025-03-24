import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/features/order/BL/controllers/order_controller.dart';

import '../widgets/order_cart_widget.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Orders"),
        ),
        body: ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            return Obx(() {
              return OrderCardWidget(order: controller.orders[index]);
            });
          },
        ));
  }
}
