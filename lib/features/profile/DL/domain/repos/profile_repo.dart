import 'package:maps_graduation_project/features/auth/DL/domain/entites/user_entity.dart';

abstract class ProfileRepo {
  Future<UserEntity?> fetchUserInfo();
}
