import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_graduation_project/features/cart/DL/domain/entites/cart_entity.dart';
import 'package:maps_graduation_project/features/order/DL/domain/entites/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel(
      {required super.orderId,
      required super.userId,
      required super.productId,
      required super.productTitle,
      required super.userName,
      required super.price,
      required super.totalPrice,
      required super.imageUrl,
      required super.quantity,
      required super.orderDate});
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String,
      userId: json['userId'] as String,
      productId: json['productId'] as String,
      productTitle: json['productTitle'] as String,
      userName: json['userName'] as String,
      price: json['price'] as String,
      totalPrice: json['totalPrice'] as String,
      imageUrl: json['imageUrl'] as String,
      quantity: json['quantity'] as String,
      orderDate: Timestamp.fromMillisecondsSinceEpoch(json['orderDate'] * 1000),
    );
  }

  // Convert an OrderModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'productId': productId,
      'productTitle': productTitle,
      'userName': userName,
      'price': price,
      'totalPrice': totalPrice,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'orderDate':
          orderDate.millisecondsSinceEpoch ~/ 1000, // Adjust if necessary
    };
  }
}
