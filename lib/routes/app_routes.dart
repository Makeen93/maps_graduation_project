import 'package:get/get.dart';
import 'package:maps_graduation_project/features/auth/PL/pages/login_page.dart';
import 'package:maps_graduation_project/features/auth/PL/pages/register_page.dart';
import 'package:maps_graduation_project/features/home/PL/pages/root_page.dart';
import 'package:maps_graduation_project/features/home/PL/pages/search_page.dart';
import 'package:maps_graduation_project/features/product/PL/page/product_details_page.dart';
import 'package:maps_graduation_project/features/splash/PL/pages/splash_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String productDetail = '/product_detail';
  static const String search = '/search';
  static List<GetPage> routes = [
    LoginPage(),
    RegisterPage(),
    RootPage(),
    SplashPage(),
    SearchPage(),
    ProductDetailsPage(),
  ];
}
