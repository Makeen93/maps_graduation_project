import 'package:cloud_firestore/cloud_firestore.dart';

class OrderEntity {
  final String orderId;
  final String userId;
  final String productId;
  final String productTitle;
  final String userName;
  final String price;
  final String totalPrice;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;
  OrderEntity({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.productTitle,
    required this.userName,
    required this.price,
    required this.totalPrice,
    required this.imageUrl,
    required this.quantity,
    required this.orderDate,
  });
}
