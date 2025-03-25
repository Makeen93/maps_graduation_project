import 'package:get/get.dart';
import 'package:maps_graduation_project/core/widgets/custom_snackbar.dart';
import 'package:maps_graduation_project/features/wishList/DL/data/models/wishlist_model.dart';
import 'package:maps_graduation_project/features/wishList/DL/data/repo/wishlist_repo_imp.dart';

class WishlistController extends GetxController {
  final WishlistRepoImp wishlistRepository;

  var wishlistItems = <String, WishlistModel>{}.obs;
  var isLoading = false.obs;
  WishlistController({required this.wishlistRepository});

  bool isProductInWishlist({required String productId}) {
    return wishlistItems.containsKey(productId);
  }

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();
  }

  Future<void> addToWishlist(String productId) async {
    try {
      // isLoading.value = true;
      await wishlistRepository.addToWishlist(productId);
      await fetchWishlist();
    } catch (error) {
      CustomSnackbar.show(title: 'Error'.tr, message: error.toString());
    } finally {
      // isLoading.value = false;
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    try {
      // isLoading.value = true;

      await wishlistRepository.removeFromWishlist(productId);
      wishlistItems.remove(productId);
    } catch (e) {
      Get.snackbar("Error", "Failed to remove from wishlist");
    } finally {
      // isLoading.value = false;
    }
  }

  Future<void> fetchWishlist() async {
    // isLoading.value = true;
    try {
      final items = await wishlistRepository.fetchWishlist();
      wishlistItems.clear();
      for (var item in items) {
        wishlistItems[item['productId']] = WishlistModel(
            wishlistId: item['wishlistId'], productId: item['productId']);
      }
    } catch (error) {
      CustomSnackbar.show(title: 'Error'.tr, message: error.toString());
    } finally {
      // isLoading.value = false;
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
}
