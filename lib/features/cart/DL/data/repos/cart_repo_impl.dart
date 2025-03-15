// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maps_graduation_project/features/cart/DL/domain/repos/cart_repo.dart';

import '../../../../../core/services/firebase_auth_service.dart';
import '../../../../../core/services/firestore_service.dart';

class CartRepoImpl extends CartRepo {
  final FireStoreService _fireStoreService;
  final FirebaseAuthService _firebaseAuthService;
  CartRepoImpl(
    this._fireStoreService,
    this._firebaseAuthService,
  );
  @override
  Future<void> addToCart(String productId, int qty) async {
    final user = await _firebaseAuthService.getCurrentUser();
    if (user != null) {
      final cartId = DateTime.now().millisecondsSinceEpoch.toString();
      await _fireStoreService.updateUserCart(user.uid, [
        {
          "cartId": cartId,
          'productId': productId,
          'quantity': qty,
        }
      ]);
    }
  }

  @override
  Future<void> clearCart() async {
    final user = await _firebaseAuthService.getCurrentUser();
    if (user != null) {
      await _fireStoreService.clearUserCart(user.uid);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchCart() async {
    final user = await _firebaseAuthService.getCurrentUser();
    if (user != null) {
      final data = await _fireStoreService.getUserCart(user.uid);
      return data?['userCart'] ?? [];
    }
    return [];
  }
}
