// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../domain/entities/wishlist_product_entitiy.dart';

class WishlistModel extends WishlistProductEntitiy {
  WishlistModel({required super.wishlistId, required super.productId});
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'wishlistId': wishlistId,
      'productId': productId,
    };
  }

  factory WishlistModel.fromJson(Map<String, dynamic> map) {
    return WishlistModel(
      wishlistId: map['wishlistId'] as String,
      productId: map['productId'] as String,
    );
  }
}
