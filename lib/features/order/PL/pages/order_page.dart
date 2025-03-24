import 'package:get/get.dart';
import 'package:maps_graduation_project/app_bindings.dart';
import 'package:maps_graduation_project/features/order/PL/screens/order_screen.dart';

import '../../../../routes/app_routes.dart';

class OrderPage extends GetPage {
  OrderPage()
      : super(
            name: AppRouter.myOrders,
            page: () => const OrderScreen(),
            binding: AppBinding());
}
