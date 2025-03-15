import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps_graduation_project/core/errors/exceptions.dart';

import 'package:maps_graduation_project/core/services/firebase_auth_service.dart';
import 'package:maps_graduation_project/core/services/firestore_service.dart';
import 'package:maps_graduation_project/core/services/storage_service.dart';
import 'package:maps_graduation_project/features/auth/DL/domain/entites/user_entity.dart';
import 'package:maps_graduation_project/features/auth/DL/domain/repos/auth_repo.dart';

import '../../../../../core/errors/failures.dart';

class AuthRepositoryImp extends AuthRepo {
  final FirebaseAuthService auth;
  final FireStoreService firestoreService;
  final StorageService storageService;
  AuthRepositoryImp({
    required this.auth,
    required this.firestoreService,
    required this.storageService,
  });
  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await auth.deleteUser();
    }
  }

  @override
  Future<UserEntity> addUser(
      {required String email,
      required XFile? filePath,
      required String password,
      required String name}) async {
    User? user;
    try {
      var image = await storageService.uploadImageAndGetUrl(
          imageFile: filePath, email: email);
      user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      var userEntity = UserEntity(
          userId: user.uid,
          userName: name,
          userImage: image,
          userEmail: email,
          userCart: [],
          userWish: []);
      // await firestoreService.usersDb.doc(user.uid).set(userEntity.toMap());
      await firestoreService.addData(
          documentId: user.uid, path: 'users', data: userEntity.toMap());
      return userEntity;
    } on CustomException catch (e) {
      await deleteUser(user);
      ServerFailure(e.message);
      throw CustomException(message: e.toString());
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImp.createUserWithEmailAndPassword: ${e.toString()}');
      ServerFailure("لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى");
      throw CustomException(message: e.toString());
    }
  }

  @override
  //Future<UserEntity> signinWithGoogle() async {
  // User? user;

  // try {
  //   user = await auth.signInWithGoogle();
  //   var userEntity = UserModel.fromFirebaseUser(user);
  //   var isUserExist = await databaseService.checkIfDataExist(
  //       path: BackendEndpoint.isUserExist, documnetId: user.uid);
  //   if (isUserExist) {
  //     await getUserData(uid: user.uid);
  //   } else {
  //     await addUserData(user: userEntity);
  //   }
  //   await saveUserData(user: userEntity);
  //   return right(userEntity);
  // } catch (e) {
  //   await deleteUser(user);
  //   log('Exception in AuthRepoImpl.createUserwithEmailAndPassword: ${e.toString()}');
  //   return left(ServerFailure('حدث خطأ ما. الرجاء المحاولة مرة أخرى'));
  // }
  //}

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
  
  @override
  Future<UserEntity> getUser(String userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
