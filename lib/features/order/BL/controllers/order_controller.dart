import 'package:get/get.dart';
import 'package:maps_graduation_project/features/order/DL/data/models/order_model.dart';
import 'package:maps_graduation_project/features/order/DL/data/repos/order_repo_imp.dart';

class OrderController extends GetxController {
  final OrderRepoImp _orderRepository;
  var orders = <OrderModel>[].obs;

  OrderController(this._orderRepository);

  Future<void> fetchOrders() async {
    final fetchedOrders = await _orderRepository.fetchOrders();
    orders.assignAll(fetchedOrders); // Update the observable list
  }
}
