// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maps_graduation_project/core/services/firebase_auth_service.dart';
import 'package:maps_graduation_project/core/services/firestore_service.dart';
import 'package:maps_graduation_project/features/wishList/DL/data/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repo/wishlist_repo.dart';

class WishlistRepoImp extends WishlistRepo {
  final FireStoreService _fireStoreService;
  final FirebaseAuthService _firebaseAuthService;
  WishlistRepoImp(
    this._fireStoreService,
    this._firebaseAuthService,
  );
  @override
  Future<void> addToWishlist(String productId) async {
    final user = await _firebaseAuthService.getCurrentUser();
    if (user != null) {
      final wishlistId = const Uuid().v4();
      await _fireStoreService.updateUserWishlist(user.uid, [
        {
          "wishlistId": wishlistId,
          'productId': productId,
        },
      ]);
    }
  }

  @override
  Future<void> removeFromWishlist(String userId, String productId) async {
    await _fireStoreService.removeFromWishlist(userId, productId);
  }

  Future<void> removeItemFromWishlist(
      String wishlistId, String productId) async {
    final user = await _firebaseAuthService.getCurrentUser();
    if (user != null) {
      await _fireStoreService.removeUserWishlistItem(
          user.uid, wishlistId, productId);
    }
  }

  Future<User?> getCurrentUser() async {
    return _firebaseAuthService.getCurrentUser();
  }

  @override
  Future<List<WishlistModel>> fetchWishlist() async {
    final user = await _firebaseAuthService.getCurrentUser();
    if (user != null) {
      final data = await _fireStoreService.getUserWishlist(user.uid);
      List<WishlistModel> wishlistItems = [];
      if (data != null && data.containsKey("userWish")) {
        for (var item in data['userWish']) {
          wishlistItems.add(WishlistModel(
            id: item['wishlistId'],
            productId: item['productId'],
          ));
        }
      }
      return wishlistItems;
    }
    return [];
  }

  @override
  Future<void> clearWishlist(String uid) async {
    await _fireStoreService.clearUserWishlist(uid);
  }
}
