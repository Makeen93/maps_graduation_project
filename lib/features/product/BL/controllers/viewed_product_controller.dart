import 'package:get/get.dart';
import 'package:maps_graduation_project/features/product/DL/data/repos/viewed_product_repo_imp.dart';

import '../../DL/data/models/viewed_product_model.dart';

class ViewedProductController extends GetxController {
  final ViewedProductRepoImp viewedProductRepository;

  ViewedProductController({required this.viewedProductRepository});
  var viewedItems = <String, ViewedProductModel>{}.obs;
  var isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  void addProductToHistory(String productId) {
    viewedProductRepository.addProductToHistory(productId, viewedItems);
  }
}
