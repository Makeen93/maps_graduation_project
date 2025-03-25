abstract class WishlistRepo {
  Future<void> addToWishlist(String productId);

  Future<List<Map<String, dynamic>>> fetchWishlist();
  Future<void> removeFromWishlist(String productId);
  Future<void> clearWishlist(String uid);
}
