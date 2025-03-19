import 'package:maps_graduation_project/features/product/DL/domain/repos/viewed_product_repo.dart';
import 'package:uuid/uuid.dart';
import '../models/viewed_product_model.dart';

class ViewedProductRepoImp extends ViewedProductRepo {

  @override
  void addProductToHistory(String productId,Map<String, ViewedProductModel> viewedProductItems) {
    if (viewedProductItems.containsKey(productId)) {
      viewedProductItems.remove(productId);
    } else {
      viewedProductItems[productId] = ViewedProductModel(
        id: const Uuid().v4(),
        productId: productId,
      );
    }
  }
}
