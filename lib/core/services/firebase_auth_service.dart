import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maps_graduation_project/core/errors/exceptions.dart';
import '../../features/auth/DL/data/models/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userId;
  UserModel? userModel;
  Future<UserModel?> fetchUserInfo() async {
    User? user = await getCurrentUser();
    if (user == null) {
      return null;
    }
    var uid = user.uid;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if (userDoc.exists) {
        userModel = UserModel.fromFirestore(userDoc);
        return userModel;
        // Or handle accordingly
      }
      // final userDocDict = userDoc.data();
      // print('${userDoc.get("userId")}');
      // print('${userDoc.get("userName")}');
      // print('${userDoc.get("userImage")}');
      // print('${userDoc.get("userEmail")}');
      // userModel = UserModel(
      //   userId: userDoc.get("userId") ?? '',
      //   userName: userDoc.get("userName") ?? '',
      //   userImage: userDoc.get("userImage") ?? '',
      //   userEmail: userDoc.get('userEmail') ?? '',
      //   userCart:
      //       userDocDict!.containsKey("userCart") ? userDoc.get("userCart") : [],
      //   userWish:
      //       userDocDict.containsKey("userWish") ? userDoc.get("userWish") : [],
      //   // createdAt: userDoc.get('createdAt'),
      // );

      print('************************$userModel');
      return userModel;
    } on FirebaseException catch (error) {
      throw error.message.toString();
    } catch (error) {
      rethrow;
    }
  }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code: ${e.code}');
      if (e.code == 'weak-password') {
        throw CustomException(message: 'كلمة المرور ضعيفة');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تأكد من اتصالك بالانترنت');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'لقد قمت بالتسجيل مسبقا. الرجاء تسجيل الدخول');
      } else {
        throw CustomException(
            message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى');
      }
    } catch (e) {
      log('Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}');

      throw CustomException(
          message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code: ${e.code}');
      if (e.code == 'user-not-found') {
        throw CustomException(
            message: 'كلمة المرور أو البريد الالكتروني غير صحيحة');
      } else if (e.code == 'wrong-password') {
        throw CustomException(
            message: 'كلمة المرور أو البريد الالكتروني غير صحيحة');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تأكد من اتصالك بالانترنت');
      } else {
        throw CustomException(
            message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى');
      }
    } catch (e) {
      log('Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}');
      throw CustomException(
          message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى');
    }
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  Future<List<QueryDocumentSnapshot>> fetchOrders() async {
    final user = await getCurrentUser();
    if (user != null) {
      final ordersSnapshot =
          await FirebaseFirestore.instance.collection('orders').get();
      return ordersSnapshot.docs;
    }
    return [];
  }
}
