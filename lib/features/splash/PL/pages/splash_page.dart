import 'package:get/get.dart';
import 'package:maps_graduation_project/app_bindings.dart';
import 'package:maps_graduation_project/features/auth/PL/screens/login_screen.dart';
import 'package:maps_graduation_project/features/auth/PL/screens/register_screen.dart';
import 'package:maps_graduation_project/features/home/PL/screens/root_screen.dart';
import 'package:maps_graduation_project/features/splash/PL/screens/splash_screen.dart';

import '../../../../routes/app_routes.dart';

class SplashPage extends GetPage {
  SplashPage()
      : super(
            name: AppRouter.splash,
            page: () => SplashScreen(),
            binding: AppBinding());
}
