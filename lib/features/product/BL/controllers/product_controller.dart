// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/widgets/custom_snackbar.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';

import 'package:maps_graduation_project/features/product/DL/data/repos/product_repo_impl.dart';

class ProductController extends GetxController {
  final ProductRepoImp productRepoImpl;

  ProductController({
    required this.productRepoImpl,
  });
  var products = <ProductModel>[].obs;
  var newProducts = <ProductModel>[].obs;
  var productListSearch = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  RxString searchQueryText = ''.obs;
  final TextEditingController searchTextController = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    await fetchProducts();
    debounce(searchQueryText, (val) {
      productListSearch.value = searchQuery(
        searchtext: val,
        passedList: newProducts,
      );
    }, time: const Duration(milliseconds: 500));
  }

  @override
  void onClose() {
    super.onClose();
    searchTextController.dispose();
  }

  void searchProducts() {
    if (searchTextController.text.isEmpty) {
      productListSearch.clear();
      return;
    }
    productListSearch.assignAll(
      searchQuery(
        searchtext: searchTextController.text,
        passedList: newProducts,
      ),
    );
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
    return products
        .where((element) => element.productCategory
            .toLowerCase()
            .contains(ctgName.toLowerCase()))
        .toList();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final fetchedProducts = await productRepoImpl.fetchProducts();
      products.value = fetchedProducts;
      newProducts.value = fetchedProducts;
    } catch (e, s) {
      errorMessage.value = e.toString();
      CustomSnackbar.show(message: '$e', title: 'Erorr');
      throw Exception();
    } finally {
      isLoading.value = false;
    }
  }
}
