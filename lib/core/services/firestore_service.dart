// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_graduation_project/core/services/database_service.dart';
import 'package:maps_graduation_project/features/auth/DL/data/models/user_model.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';

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
        return UserModel.fromFirestore(doc);
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

  Future<void> removeOneFromUserCart(String uid, String productId) async {
    final userDoc = await usersDb.doc(uid).get();
    if (userDoc.exists) {
      final userData = userDoc.data();

      // Step 2: Get the current userCart array
      if (userData != null && userData['userCart'] is List) {
        List<dynamic> userCart = List.from(userData['userCart']);

        // Step 3: Remove the product with the given productId
        userCart.removeWhere((item) => item['productId'] == productId);

        // Step 4: Update the userCart in Firestore
        await usersDb.doc(uid).update({"userCart": userCart});
      }
    }
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
