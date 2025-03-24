import 'package:get/get.dart';
import 'package:maps_graduation_project/app_bindings.dart';
import 'package:maps_graduation_project/features/home/PL/screens/root_screen.dart';

import '../../../../routes/app_routes.dart';

class RootPage extends GetPage {
  RootPage()
      : super(
            name: AppRouter.home,
            page: () => RootScreen(),
            binding: AppBinding());
}
