import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_graduation_project/features/auth/DL/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.userEmail,
      required super.userId,
      required super.userName,
      super.createdAt,
      required super.userImage,
      required super.userCart,
      required super.userWish});
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserModel(
      userId: doc.id,
      userName: data['userName'] ?? '',
      userImage: data['userImage'] ?? '',
      userEmail: data['userEmail'] ?? '',
      createdAt: data['createdAt'],
      userCart: List.from(data['userCart'] ?? []),
      userWish: List.from(data['userWish'] ?? []),
    );
  }
}
