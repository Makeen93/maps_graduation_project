import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';

abstract class ProductRepo {
  Future<List<ProductModel>> fetchProducts();
  // ProductModel? findByProdId(String productId);
  // List<ProductModel> findByCategory({required String ctgName});
  // List<ProductModel> searchQuery(
  //     {required String searchtext, required List<ProductModel> passedList});
  // Stream<List<ProductModel>> fetchProductStream();
}
