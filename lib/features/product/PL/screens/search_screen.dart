import 'dart:async';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/assets_manager.dart';
import 'package:maps_graduation_project/core/widgets/loading_manger.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';

import '../widgets/product_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    var passedCategory = Get.arguments ?? '';

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              title: TitlesTextWidget(label: passedCategory ?? 'Search'.tr),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
            ),
            body: Obx(() {
              productController.newProducts.value = passedCategory == null
                  ? productController.products.value
                  : productController.findByCategory(ctgName: passedCategory);
              return LoadingWidget(
                  isLoading: productController.isLoading.value,
                  child: productController.newProducts.isEmpty
                      ? Center(
                          child: TitlesTextWidget(label: 'No Product Found'.tr))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextField(
                                controller:
                                    productController.searchTextController,
                                decoration: InputDecoration(
                                  hintText: 'Search'.tr,
                                  filled: true,
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      productController.searchTextController
                                          .clear();
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  productController.searchQueryText.value =
                                      value;
                                },
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              if (productController
                                      .searchTextController.text.isNotEmpty &&
                                  productController
                                      .productListSearch.isEmpty) ...[
                                Center(
                                  child: TitlesTextWidget(
                                    label: 'No Result Found'.tr,
                                    fontSize: 40,
                                  ),
                                )
                              ],
                              Expanded(
                                child: DynamicHeightGridView(
                                  itemCount: productController
                                          .searchTextController.text.isNotEmpty
                                      ? productController
                                          .productListSearch.length
                                      : productController.newProducts.length,
                                  builder: ((context, index) {
                                    var product = productController
                                            .searchTextController
                                            .text
                                            .isNotEmpty
                                        ? productController
                                            .productListSearch[index]
                                        : productController.newProducts[index];
                                    print('-------------${product.productId}');
                                    return ProductWidget(
                                        productId: product.productId);
                                  }),
                                  crossAxisCount: 2,
                                ),
                              ),
                            ],
                          ),
                        ));
            })));
  }
}

class Debounce {
  final Duration duration;
  Timer? _timer;

  Debounce(this.duration);

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
