import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_graduation_project/features/cart/DL/domain/entites/cart_entity.dart';
import 'package:maps_graduation_project/features/order/DL/domain/entites/order_entity.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.orderId,
    required super.userId,
    required super.userName,
    required super.products,
    required super.totalPrice,
    required super.orderDate,
    required super.orderStatus,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'orderId': orderId,
      'userId': userId,
      'userName': userName,
      'products': products.map((x) => x.toJson()).toList(),
      'totalPrice': totalPrice,
      'orderDate': orderDate.millisecondsSinceEpoch ~/ 1000,
      'orderStatus': orderStatus.name,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      products: (json['products'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList(),
      totalPrice: json['totalPrice'] as double,
      orderDate: Timestamp.fromMillisecondsSinceEpoch(json['orderDate'] * 1000),
      orderStatus: OrderStatus.values.byName(json['orderStatus']),
    );
  }
}
