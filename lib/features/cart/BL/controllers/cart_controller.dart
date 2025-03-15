import 'package:get/get.dart';
import 'package:maps_graduation_project/features/cart/DL/data/repos/cart_repo_impl.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';
import 'package:uuid/uuid.dart';

import '../../DL/data/models/cart_model.dart';

class CartController extends GetxController {
  final CartRepoImpl cartRepository;

  var cartItems = <String, CartModel>{}.obs;
  var isLoading = true.obs;
  CartController({required this.cartRepository});

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> addToCart({required String productId, required int qty}) async {
    await cartRepository.addToCart(productId, qty);
    await fetchCart();
  }

  void addProductToCart({required String productId}) {
    cartItems.putIfAbsent(
        productId,
        () => CartModel(
            cartId: const Uuid().v4(), productId: productId, quantity: 1));
  }

  void updateQuantity({required String productId, required int quantity}) {
    cartItems.update(
        productId,
        (item) => CartModel(
            cartId: item.cartId, productId: productId, quantity: quantity));
  }

  Future<void> fetchCart() async {
    final items = await cartRepository.fetchCart();
    cartItems.clear();
    for (var item in items) {
      cartItems[item['productId']] = CartModel(
        cartId: item['cartId'],
        productId: item['productId'],
        quantity: item['quantity'],
      );
    }
  }

  Future<void> clearCart() async {
    await cartRepository.clearCart();
    cartItems.clear();
  }

  void clrearLocalCart() {
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

  void removeOneItem({required String productId}) {
    cartItems.remove(productId);
  }

  bool isProductInCart({required String productId}) {
    return cartItems.containsKey(productId);
  }
}
