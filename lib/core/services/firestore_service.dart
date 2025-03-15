// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maps_graduation_project/core/services/database_service.dart';
import 'package:maps_graduation_project/features/auth/DL/data/models/user_model.dart';

import 'package:maps_graduation_project/features/auth/DL/domain/entites/user_entity.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';

import 'firebase_auth_service.dart';

class FireStoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final usersDb = FirebaseFirestore.instance.collection('users');
  final productDB = FirebaseFirestore.instance.collection('products');
  // late final doc;

  Future<UserModel> getUser(String userId) async {
    try {
      print(userId);
      var doc = await usersDb.doc(userId).get();
      if (doc.exists) {
        print('------------------------------------------$doc');
        return UserModel.fromFirestore(doc);
        // return UserModel(
        //   userId: doc.data()?['userId'],
        //   userName: doc.data()?['userName'],
        //   userImage: doc.data()?['userImage'],
        //   userEmail: doc.data()?['userEmail'],
        //   // createdAt: doc.data()?['createdAt'],
        //   userCart: doc.data()?['userCart'] ?? [],
        //   userWish: doc.data()?['userWish'] ?? [],
        // );
      } else {
        throw Exception('User not found');
      }
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      List<ProductModel> productsList = [];

      await productDB
          // .orderBy('createdAt', descending: false)
          .get()
          .then((productsSnapshot) {
        productsList.clear();
        for (var element in productsSnapshot.docs) {
          productsList.insert(0, ProductModel.fromFireStore(element));
        }
      });

      return productsList;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ProductModel>> fetchProductStream() {
    try {
      List<ProductModel> productsList = [];
      return productDB.snapshots().map((snapshot) {
        productsList.clear();
        for (var element in snapshot.docs) {
          productsList.insert(0, ProductModel.fromFireStore(element));
        }
        return productsList;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserCart(
      String uid, List<Map<String, dynamic>> cartItems) async {
    await usersDb.doc(uid).update({
      'userCart': FieldValue.arrayUnion(cartItems),
    });
  }

  Future<void> clearUserCart(String uid) async {
    await usersDb.doc(uid).update({"userCart": []});
  }

  Future<Map<String, dynamic>?> getUserCart(String uid) async {
    final userDoc = await usersDb.doc(uid).get();
    return userDoc.data();
  }

  Future<void> updateUserWishlist(
      String uid, List<Map<String, dynamic>> wishlistItems) async {
    await usersDb.doc(uid).update({
      'userWish': FieldValue.arrayUnion(wishlistItems),
    });
  }

  Future<void> clearUserWishlist(String uid) async {
    await usersDb.doc(uid).update({"userWish": []});
  }

  Future<Map<String, dynamic>?> getUserWishlist(String uid) async {
    final userDoc = await usersDb.doc(uid).get();
    return userDoc.data();
  }

  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId}) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<Map<String, dynamic>> getData(
      {required String path, required String documnetId}) async {
    var data = await firestore.collection(path).doc(documnetId).get();
    return (data.data() as Map<String, dynamic>);
  }

  @override
  Future<bool> checkIfDataExist(
      {required String path, required String documnetId}) async {
    var data = await firestore.collection(path).doc(documnetId).get();
    return data.exists;
  }
}
