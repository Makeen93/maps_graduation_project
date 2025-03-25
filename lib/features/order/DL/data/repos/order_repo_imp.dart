import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_graduation_project/core/services/firestore_service.dart';
import 'package:maps_graduation_project/features/cart/BL/controllers/cart_controller.dart';
import 'package:maps_graduation_project/features/order/DL/data/models/order_model.dart';
import 'package:maps_graduation_project/features/order/DL/domain/entites/order_entity.dart';
import 'package:maps_graduation_project/features/order/DL/domain/repos/order_repo.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';
import 'package:uuid/uuid.dart';
import '../../../../profile/BL/controllers/profile_controller.dart';

class OrderRepoImp extends OrderRepo {
  final FireStoreService _firestoreService;
  final CartController _cartcontroller;
  final ProductController _productcontroller;
  final ProfileController _profileController;
  OrderRepoImp(
    this._firestoreService,
    this._cartcontroller,
    this._productcontroller,
    this._profileController,
  );

  @override
  Future<List<OrderModel>> fetchOrders() async {
    final user = _profileController.userModel;
    final ordersSnapshot =
        await _firestoreService.fetchOrders(user.value!.userId);
    List<OrderModel> orders = ordersSnapshot
        .map((documentSnapshot) => OrderModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>))
        .toList();
    return orders;
  }

  @override
  Future<void> addOrder() async {
    // final user = await _firebaseAuthService.getCurrentUser();
    final user = _profileController.userModel;
    var cartList = _cartcontroller.cartItems;
    final orderId = const Uuid().v4();
    List<ProductModel> products = [];
    cartList.forEach((key, value) async {
      final getCurrProduct = _productcontroller.findByProdId(value.productId);
      products.add(getCurrProduct!);
    });
    var order = OrderModel(
      orderId: orderId,
      userId: user.value!.userId,
      userName: user.value!.userName,
      orderStatus: OrderStatus.Pending,
      totalPrice: _cartcontroller.getTotal(productProvider: _productcontroller),
      orderDate: Timestamp.now(),
      products: products,
    );

    await _firestoreService.orderDB.doc(orderId).set(order.toJson());
  }
}
