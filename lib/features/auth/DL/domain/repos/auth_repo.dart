import 'package:image_picker/image_picker.dart';
import 'package:maps_graduation_project/features/auth/DL/domain/entites/user_entity.dart';

abstract class AuthRepo {
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});
 Future<void> signOut();
  Future<UserEntity> addUser(
      {required String email,
      required XFile? filePath,
      required String password,
      required String name});
  Future<UserEntity> getUser(String userId);
  //Future<UserEntity> signinWithGoogle();
}
