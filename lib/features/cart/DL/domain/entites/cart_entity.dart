import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartEntity {
  final String cartId;
  final String productId;
  final int quantity;
  CartEntity({
    required this.cartId,
    required this.productId,
    required this.quantity,
  });
}
