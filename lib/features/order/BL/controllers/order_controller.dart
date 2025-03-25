// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:maps_graduation_project/core/widgets/custom_snackbar.dart';
import 'package:maps_graduation_project/features/order/DL/data/models/order_model.dart';
import 'package:maps_graduation_project/features/order/DL/data/repos/order_repo_imp.dart';

class OrderController extends GetxController {
  final OrderRepoImp _orderRepository;
  var orders = <OrderModel>[].obs;
  var isLoading = false.obs;

  OrderController(
    this._orderRepository,
  );
  @override
  void onInit() async {
    await fetchOrders();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading = true.obs;

      final fetchedOrders = await _orderRepository.fetchOrders();
      orders.assignAll(fetchedOrders);
    } catch (error) {
      CustomSnackbar.show(title: 'Error'.tr, message: error.toString());
    } finally {
      isLoading = false.obs;
    }
  }

  Future<void> addOrder() async {
    try {
      isLoading.value = true;

      await _orderRepository.addOrder();
      CustomSnackbar.show(
          title: 'Sucsecc'.tr,
          message: 'Order has been requseted sucseccfully'.tr,
          backgroundColor: Colors.green);
      await fetchOrders();
    } catch (error) {
      CustomSnackbar.show(title: 'Error'.tr, message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
