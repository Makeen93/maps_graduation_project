abstract class CartRepo {
  Future<void> addToCart(String productId, int qty);
  Future<List<Map<String, dynamic>>> fetchCart();
  Future<void> clearCart();
  Future<void> removeOneFromUserCart(String productId);
  Future<void> updateQuantity(String productId, int newQuantity);
}
