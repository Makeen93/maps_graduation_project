import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maps_graduation_project/features/order/BL/controllers/order_controller.dart';

import '../../DL/data/models/order_model.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderModel order;

  const OrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();
    // Format the order date
    String formattedDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(order.orderDate.toDate());

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID:'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              order.orderId.tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('User:'.tr),
            Text(order.userName.tr),
            const SizedBox(height: 8),
            Text('Date:'.tr),
            Text(formattedDate),
            const SizedBox(height: 8),
            Text('Total Price:'.tr),
            Text('\$${order.totalPrice.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text('Status:'.tr),
            Chip(
                backgroundColor: Colors.lightGreenAccent,
                label: Text(' ${order.orderStatus.name.toString()}'.tr)),
            const SizedBox(height: 8),
            Text('Products:'.tr),
            const Text('', style: TextStyle(fontWeight: FontWeight.bold)),
            ...order.products.map((product) => Text(product.productTitle)),
          ],
        ),
      ),
    );
  }
}
