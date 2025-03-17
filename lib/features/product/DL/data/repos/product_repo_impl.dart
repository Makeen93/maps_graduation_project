import 'package:maps_graduation_project/core/services/firestore_service.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/product_model.dart';
import 'package:maps_graduation_project/features/product/DL/domain/repos/product_repo.dart';

class ProductRepoImp extends ProductRepo {
  final FireStoreService _firestoreService = FireStoreService();

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      var productList = await _firestoreService.fetchProducts();

      return productList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
