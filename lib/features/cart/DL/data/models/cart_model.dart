import 'package:maps_graduation_project/features/cart/DL/domain/entites/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel(
      {required super.cartId,
      required super.productId,
      required super.quantity});
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cartId': cartId,
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
      cartId: map['cartId'] as String,
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
    );
  }
  CartModel copyWith({
    String? cartId,
    String? productId,
    int? quantity,
  }) {
    return CartModel(
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }
}
