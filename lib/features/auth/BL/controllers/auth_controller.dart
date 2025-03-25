import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/widgets/custom_snackbar.dart';
import 'package:maps_graduation_project/features/auth/DL/data/repos/auth_repo_impl.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepositoryImp _authRepository;

  AuthController(this._authRepository);

  final RxBool isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      await _authRepository.signInWithEmailAndPassword(
          email: email, password: password);
      Get.toNamed(AppRouter.home); // Navigate to root screen after login
    } on FirebaseAuthException catch (error) {
      CustomSnackbar.show(
          title: 'An error occurred'.tr, message: error.toString());
    } catch (error) {
      CustomSnackbar.show(title: 'Error'.tr, message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signout() async {
    try {
      isLoading.value = true;

      await _authRepository.signOut();
      Get.offAll(AppRouter.login);
    } on FirebaseAuthException catch (error) {
      CustomSnackbar.show(
          title: 'An error occurred'.tr, message: error.toString());
    } catch (error) {
      CustomSnackbar.show(title: 'Error'.tr, message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
