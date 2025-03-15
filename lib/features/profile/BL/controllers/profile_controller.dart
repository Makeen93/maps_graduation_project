// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:maps_graduation_project/features/auth/DL/data/models/user_model.dart';
import 'package:maps_graduation_project/features/auth/DL/domain/entites/user_entity.dart';

import '../../DL/data/repos/profile_repo_impl.dart';

class ProfileController extends GetxController {
  final ProfileRepoImpl profileRepoImpl;
  ProfileController({
    required this.profileRepoImpl,
  });

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  var userModel = Rx<UserModel?>(null);

  // Getter for userModel
  @override
  void onInit() async {
    super.onInit();
    await fetchUserInfo();
  }

  fetchUserInfo() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final user = await profileRepoImpl.fetchUserInfo();
      print(user!.userEmail);
      userModel.value = user;
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
