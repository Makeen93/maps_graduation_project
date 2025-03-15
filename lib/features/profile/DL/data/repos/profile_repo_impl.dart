import 'package:firebase_auth/firebase_auth.dart';
import 'package:maps_graduation_project/core/services/firestore_service.dart';
import 'package:maps_graduation_project/features/auth/DL/data/models/user_model.dart';
import 'package:maps_graduation_project/features/auth/DL/domain/entites/user_entity.dart';
import 'package:maps_graduation_project/features/profile/DL/domain/repos/profile_repo.dart';

import '../../../../../core/services/firebase_auth_service.dart';

class ProfileRepoImpl extends ProfileRepo {
  final FirebaseAuthService firebaseAuthService;
  final FireStoreService firestore;
  ProfileRepoImpl({
    required this.firestore,
    required this.firebaseAuthService,
  });
  @override
  Future<UserModel?> fetchUserInfo() async {
    try {
      User? user = await firebaseAuthService.getCurrentUser();
      if (user == null) {
        return null;
      }
      var uid = user.uid;
      var x = await firestore.getUser(uid);
      print('****************-------------------------------$x');
      return x;
    } on Exception catch (e, s) {
      print(e);
      print(s);
      throw Exception(e);
    }
  }
}
