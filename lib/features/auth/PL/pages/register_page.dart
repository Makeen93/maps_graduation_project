import 'package:get/get.dart';
import 'package:maps_graduation_project/app_bindings.dart';
import 'package:maps_graduation_project/features/auth/BL/bindings/auth_bindings.dart';
import 'package:maps_graduation_project/features/auth/PL/screens/register_screen.dart';

import '../../../../routes/app_routes.dart';

class RegisterPage extends GetPage {
  RegisterPage()
      : super(
            name: AppRouter.register,
            page: () => RegisterScreen(),
            binding: AppBinding());
}
