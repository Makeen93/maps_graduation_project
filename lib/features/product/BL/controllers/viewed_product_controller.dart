import 'package:get/get.dart';
import 'package:maps_graduation_project/features/product/DL/data/repos/viewed_product_repo_imp.dart';

class ViewedProductController extends GetxController {
  final ViewedProductRepoImp viewedProductRepository;

  ViewedProductController({required this.viewedProductRepository});

  void addProductToHistory(String productId) {
    viewedProductRepository.addProductToHistory(productId);
    update(); // Notify listeners to update the UI
  }
}
