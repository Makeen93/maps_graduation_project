import 'package:get/get.dart';
import 'package:maps_graduation_project/app_bindings.dart';
import 'package:maps_graduation_project/features/wishList/PL/screens/wish_list_screen.dart';

import '../../../../routes/app_routes.dart';

class WishListPage extends GetPage {
  WishListPage()
      : super(
            name: AppRouter.wishList,
            page: () => const WishlistScreen(),
            binding: AppBinding());
}
