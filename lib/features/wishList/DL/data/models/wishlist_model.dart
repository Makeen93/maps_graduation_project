// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../domain/entities/wishlist_product_entitiy.dart';

class WishlistModel extends WishlistProductEntitiy {
  WishlistModel({required super.id, required super.productId});
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
    };
  }

  factory WishlistModel.fromJson(Map<String, dynamic> map) {
    return WishlistModel(
      id: map['id'] as String,
      productId: map['productId'] as String,
    );
  }
}
