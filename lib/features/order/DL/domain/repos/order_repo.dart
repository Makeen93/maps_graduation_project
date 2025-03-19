import '../../data/models/order_model.dart';

abstract class OrderRepo {
  Future<List<OrderModel>> fetchOrders();
  Future<void> addOrder();
}
