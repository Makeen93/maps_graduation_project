// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';

import 'package:maps_graduation_project/features/product/DL/data/repos/product_repo_impl.dart';

class ProductController extends GetxController {
  final ProductRepoImp productRepoImpl;

  ProductController({
    required this.productRepoImpl,
  });
  var products = <ProductModel>[].obs;
  var productswithCategory = <ProductModel>[].obs;
  var productListSearch = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final TextEditingController searchTextController = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    await fetchProducts();
  }

  @override
  void onClose() {
    // Dispose of the TextEditingController when the controller is removed
    searchTextController.dispose();
    super.onClose();
  }

  ProductModel? findByProdId(String productId) {
    if (products.where((element) => element.productId == productId).isEmpty) {
      return null;
    }
    return products.firstWhere((element) => element.productId == productId);
  }

  List<ProductModel> searchQuery(
      {required String searchtext, required List<ProductModel> passedList}) {
    List<ProductModel> searchList = passedList
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchtext.toLowerCase()))
        .toList();

    return searchList;
  }

  List<ProductModel> findByCategory({required String ctgName}) {
    List<ProductModel> ctgList = products
        .where((element) => element.productCategory
            .toLowerCase()
            .contains(ctgName.toLowerCase()))
        .toList();

    return ctgList;
  }

  // Stream<List<ProductModel>> fetchProductStream() {
  //   try {
  //     return productRepoImpl.getdoc.snapshots().map((snapshot) {
  //       products.clear();
  //       // products = [];
  //       for (var element in snapshot.docs) {
  //         products.insert(0, ProductModel.fromFireStore(element));
  //       }
  //       return products;
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final fetchedPosts = await productRepoImpl.fetchProducts();
      products.value = fetchedPosts;
      print('MAKEEN${products.length}');
      return products;
    } catch (e, s) {
      print(s);
      errorMessage.value = e.toString();
      throw Exception();
    } finally {
      isLoading.value = false;
    }
  }
}
