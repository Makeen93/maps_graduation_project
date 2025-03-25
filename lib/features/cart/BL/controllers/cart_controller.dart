import 'package:get/get.dart';
import 'package:maps_graduation_project/core/widgets/custom_snackbar.dart';
import 'package:maps_graduation_project/features/cart/DL/data/repos/cart_repo_impl.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';
import '../../DL/data/models/cart_model.dart';

class CartController extends GetxController {
  final CartRepoImpl cartRepository;

  var cartItems = <String, CartModel>{}.obs;
  var isLoading = false.obs;

  CartController({required this.cartRepository});

  @override
  void onInit() async {
    super.onInit();
    await fetchCart();
  }

  Future<void> addToCart({required String productId, required int qty}) async {
    try {
      isLoading.value = true;

      await cartRepository.addToCart(productId, qty);
      await fetchCart();
    } catch (error) {
      CustomSnackbar.show(title: 'Error'.tr, message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateQuantity(
      {required String productId, required int quantity}) async {
    try {
      isLoading.value = true;
      await cartRepository.updateQuantity(productId, quantity);

      if (cartItems.containsKey(productId)) {
        cartItems[productId] =
            cartItems[productId]!.copyWith(quantity: quantity);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update quantity");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;

      final items = await cartRepository.fetchCart();
      cartItems.clear();
      // items.map((cart) => CartModel.fromJson(cart)).toList();

      for (var item in items) {
        cartItems[item['productId']] = CartModel(
          cartId: item['cartId'],
          productId: item['productId'],
          quantity: item['quantity'],
        );
      }
    } catch (error) {
      CustomSnackbar.show(title: 'Error'.tr, message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearCart() async {
    await cartRepository.clearCart();
    cartItems.clear();
  }

  int getQty() {
    int total = 0;
    cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  double getTotal({required ProductController productProvider}) {
    double total = 0;
    cartItems.forEach((key, value) {
      final ProductModel? getCurrProduct =
          productProvider.findByProdId(value.productId);
      if (getCurrProduct == null) {
        total += 0;
      } else {
        total += double.parse(getCurrProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  removeOneItem({required String productId}) async {
    try {
      isLoading.value = true;

      await cartRepository.removeOneFromUserCart(productId);
      cartItems.remove(productId);
    } catch (error) {
      CustomSnackbar.show(title: 'Error'.tr, message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  bool isProductInCart({required String productId}) {
    return cartItems.containsKey(productId);
  }
}
