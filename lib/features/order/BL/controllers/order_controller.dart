import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/widgets/custom_snackbar.dart';
import 'package:maps_graduation_project/features/order/DL/data/models/order_model.dart';
import 'package:maps_graduation_project/features/order/DL/data/repos/order_repo_imp.dart';

class OrderController extends GetxController {
  final OrderRepoImp _orderRepository;
  var orders = <OrderModel>[].obs;
  var isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  OrderController(this._orderRepository);
  @override
  void onInit() async {
    super.onInit();
    await fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading = true.obs;
      errorMessage.value = '';
      final fetchedOrders = await _orderRepository.fetchOrders();
      orders.assignAll(fetchedOrders); // Update the observable list
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading = false.obs;
    }
  }

  Future<void> addOrder() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _orderRepository.addOrder();
      CustomSnackbar.show(
          title: 'Sucsecc',
          message: 'Order has been requseted sucseccfully',
          backgroundColor: Colors.green);
      // await fetchCart();
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
