import 'package:get/get.dart';
import 'package:maps_graduation_project/features/cart/DL/data/repos/cart_repo_impl.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';
import 'package:uuid/uuid.dart';

import '../../DL/data/models/cart_model.dart';

class CartController extends GetxController {
  final CartRepoImpl cartRepository;

  var cartItems = <String, CartModel>{}.obs;
  var isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  CartController({required this.cartRepository});

  @override
  void onInit() async {
    super.onInit();
    await fetchCart();
  }

  Future<void> addToCart({required String productId, required int qty}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await cartRepository.addToCart(productId, qty);
      await fetchCart();
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void addProductToCart({required String productId}) {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      cartItems.putIfAbsent(
          productId,
          () => CartModel(
              cartId: const Uuid().v4(), productId: productId, quantity: 1));
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void updateQuantity({required String productId, required int quantity}) {
    cartItems.update(
        productId,
        (item) => CartModel(
            cartId: item.cartId, productId: productId, quantity: quantity));
  }

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
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
      errorMessage.value = error.toString();
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
      errorMessage.value = '';
      await cartRepository.removeOneFromUserCart(productId);
      cartItems.remove(productId);
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  bool isProductInCart({required String productId}) {
    return cartItems.containsKey(productId);
  }
}
