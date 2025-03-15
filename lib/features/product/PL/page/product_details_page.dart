import 'package:get/get.dart';
import 'package:maps_graduation_project/app_bindings.dart';
import 'package:maps_graduation_project/features/product/PL/screens/product_details_screen.dart';

import '../../../../routes/app_routes.dart';

class ProductDetailsPage extends GetPage {
  ProductDetailsPage()
      : super(
          name: AppRouter.productDetail,
          page: () => const ProductDetailsScreen(),
          binding: AppBinding(),
        );
}
