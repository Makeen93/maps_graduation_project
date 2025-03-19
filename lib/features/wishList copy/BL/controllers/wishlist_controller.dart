import 'package:get/get.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/wishlist_model.dart';
import 'package:maps_graduation_project/features/product/DL/data/repos/wishlist_repo_imp.dart';

class WishlistController extends GetxController {
  final WishlistRepoImp wishlistRepository;

  var wishlistItems = <WishlistModel>[].obs;
  var isLoading = false.obs;
  WishlistController({required this.wishlistRepository});
  bool isProductInWishlist({required String productId}) {
    return wishlistItems.contains(productId);
  }

  Future<void> addToWishlist(String productId) async {
    isLoading.value = true;
    try {
      await wishlistRepository.addToWishlist(productId);
      await fetchWishlist();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWishlist() async {
    isLoading.value = true;
    try {
      final items = await wishlistRepository.fetchWishlist();
      wishlistItems.assignAll(items);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearWishlist() async {
    final user = await wishlistRepository.getCurrentUser();
    isLoading.value = true;
    try {
      await wishlistRepository.clearWishlist(user!.uid);
      wishlistItems.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeItem(String wishlistId, String productId) async {
    isLoading.value = true; // Set loading to true
    try {
      await wishlistRepository.removeItemFromWishlist(wishlistId, productId);
      await fetchWishlist();
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }
}
