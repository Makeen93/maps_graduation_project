import 'package:maps_graduation_project/features/product/DL/data/models/viewed_product_model.dart';

abstract class ViewedProductRepo {
  void addProductToHistory(String productId,Map<String, ViewedProductModel> viewedProductItems);
}
