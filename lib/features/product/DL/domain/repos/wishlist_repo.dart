import 'package:maps_graduation_project/features/product/DL/data/models/wishlist_model.dart';

abstract class WishlistRepo {
  Future<void> addToWishlist(String productId);

  Future<List<WishlistModel>> fetchWishlist();

  Future<void> clearWishlist(String uid);
}
