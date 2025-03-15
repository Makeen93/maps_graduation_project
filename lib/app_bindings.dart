import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/firebase_auth_service.dart';
import 'package:maps_graduation_project/core/services/firestore_service.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/features/auth/BL/controllers/auth_controller.dart';
import 'package:maps_graduation_project/features/auth/BL/controllers/register_controller.dart';
import 'package:maps_graduation_project/features/auth/DL/data/repos/auth_repo_impl.dart';
import 'package:maps_graduation_project/features/cart/BL/controllers/cart_controller.dart';
import 'package:maps_graduation_project/features/cart/DL/data/repos/cart_repo_impl.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/viewed_product_controller.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/wishlist_controller.dart';
import 'package:maps_graduation_project/features/product/DL/data/repos/viewed_product_repo_imp.dart';
import 'package:maps_graduation_project/features/product/DL/data/repos/wishlist_repo_imp.dart';
import 'package:maps_graduation_project/features/profile/BL/controllers/profile_controller.dart';
import 'package:maps_graduation_project/features/profile/DL/data/repos/profile_repo_impl.dart';
import 'package:maps_graduation_project/features/splash/BL/controller/splash_controller.dart';

import 'core/services/storage_service.dart';
import 'features/product/DL/data/repos/product_repo_impl.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductRepoImp());
    Get.lazyPut(() => MyAppMethods());
    Get.lazyPut(() =>
        SplashController(firebaseAuthService: Get.find<FirebaseAuthService>()));
    Get.lazyPut(() => AuthController(Get.find<AuthRepositoryImp>()));
    Get.lazyPut(
      () => ProductController(productRepoImpl: Get.find()),
    );
    Get.lazyPut(() =>
        RegisterController(authRepository: Get.find<AuthRepositoryImp>()));
    Get.lazyPut(() => FirebaseAuthService());
    Get.lazyPut(() => FireStoreService());
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => ProfileRepoImpl(
        firebaseAuthService: Get.find(), firestore: Get.find()));
    Get.lazyPut(() => ProfileController(profileRepoImpl: Get.find()));

    Get.lazyPut(() => AuthRepositoryImp(
        auth: Get.find<FirebaseAuthService>(),
        firestoreService: Get.find<FireStoreService>(),
        storageService: Get.find<StorageService>()));
    Get.lazyPut(() => ViewedProductRepoImp());
    Get.lazyPut(() => WishlistRepoImp(Get.find(), Get.find()));
    Get.lazyPut(() => WishlistController(wishlistRepository: Get.find()));
    Get.lazyPut(() => CartRepoImpl(
        Get.find<FireStoreService>(), Get.find<FirebaseAuthService>()));
    Get.lazyPut(() => CartController(cartRepository: Get.find()));
    Get.lazyPut(
        () => ViewedProductController(viewedProductRepository: Get.find()));
    Get.lazyPut(() =>
        SplashController(firebaseAuthService: Get.find<FirebaseAuthService>()));
  }
}
