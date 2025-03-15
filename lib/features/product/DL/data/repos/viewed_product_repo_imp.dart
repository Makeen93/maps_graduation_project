import 'package:maps_graduation_project/features/product/DL/domain/repos/viewed_product_repo.dart';
import 'package:uuid/uuid.dart';
import '../models/viewed_product_model.dart';

class ViewedProductRepoImp extends ViewedProductRepo {
  final Map<String, ViewedProductModel> _viewedProductItems = {};

  Map<String, ViewedProductModel> get viewedProductItems => _viewedProductItems;

  @override
  void addProductToHistory(String productId) {
    if (_viewedProductItems.containsKey(productId)) {
      _viewedProductItems.remove(productId);
    } else {
      _viewedProductItems[productId] = ViewedProductModel(
        id: const Uuid().v4(),
        productId: productId,
      );
    }
  }
}
