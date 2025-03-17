import 'package:maps_graduation_project/features/order/DL/data/models/order_model.dart';
import 'package:maps_graduation_project/features/order/DL/domain/repos/order_repo.dart';
import '../../../../../core/services/firebase_auth_service.dart';

class OrderRepoImp extends OrderRepo {
  final FirebaseAuthService _firebaseAuthService;
  OrderRepoImp(
    this._firebaseAuthService,
  );

  @override
  Future<List<OrderModel>> fetchOrders() async {
    final ordersSnapshot = await _firebaseAuthService.fetchOrders();
    List<OrderModel> orders = ordersSnapshot
        .map((documentSnapshot) => OrderModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>))
        .toList();
    // for (var element in ordersSnapshot) {
    //   orders.add(element.

    //     OrderModel(
    //     orderId: element.get('orderId'),
    //     userId: element.get('userId'),
    //     productId: element.get('productId'),
    //     productTitle: element.get('productTitle'),
    //     userName: element.get('userName'),
    //     price: element.get('price').toString(),
    //     totalPrice: element.get('totalPrice').toString(),
    //     imageUrl: element.get('imageUrl'),
    //     quantity: element.get('quantity').toString(),
    //     orderDate:
    //         element.get('orderDate'), // Convert Firestore Timestamp to DateTime
    //   )
    //   );
    // }
    return orders;
  }
}
