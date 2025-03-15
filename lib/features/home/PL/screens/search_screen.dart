import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/services/assets_manager.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';

import '../../../product/PL/widgets/product_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    var passedCategory = Get.arguments ?? '';
    productController.productswithCategory.value = passedCategory == null
        ? productController.products
        : productController.findByCategory(ctgName: passedCategory);
   

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
            body: productController.products.isEmpty
                ? Center(child: TitlesTextWidget(label: 'No Product Found'.tr))
                : Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15.0,
                          ),
                          TextField(
                            controller: productController.searchTextController,
                            decoration: InputDecoration(
                              hintText: ' Search'.tr,
                              filled: true,
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  productController.searchTextController
                                      .clear();
                                  FocusScope.of(context).unfocus();
                                  // });
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              productController.productListSearch.value =
                                  productController.searchQuery(
                                      searchtext: productController
                                          .searchTextController.text,
                                      passedList: productController.products);
                            },
                            onSubmitted: (value) {
                              productController.productListSearch.value =
                                  productController.searchQuery(
                                      searchtext: productController
                                          .searchTextController.text,
                                      passedList: productController.products);
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          if (productController
                                  .searchTextController.text.isNotEmpty &&
                              productController.productListSearch.isEmpty) ...[
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
                                  ? productController.productListSearch.length
                                  : productController.products.length,
                              builder: ((context, index) {
                                return ProductWidget(
                                  productId: productController
                                          .searchTextController.text.isNotEmpty
                                      ? productController
                                          .productListSearch[index].productId
                                      : productController
                                          .products[index].productId,
                                );
                              }),
                              crossAxisCount: 2,
                            ),
                          ),
                        ],
                      ),
                    );
                  })));
  }
}
