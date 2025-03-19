// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../product/DL/data/models/product_model.dart';

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

class OrderEntity {
  final String orderId;
  final String userId;
  final String userName;
  final List<ProductModel> products;
  final double totalPrice;
  final Timestamp orderDate;
  final OrderStatus orderStatus;
  OrderEntity({
    required this.orderId,
    required this.userId,
    required this.userName,
    required this.products,
    required this.totalPrice,
    required this.orderDate,
     required this.orderStatus,
  });
}
