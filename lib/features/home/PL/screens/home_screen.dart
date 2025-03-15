import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/core/widgets/app_name_text.dart';
import 'package:maps_graduation_project/core/widgets/title_text.dart';
import 'package:maps_graduation_project/features/product/BL/controllers/product_controller.dart';
import 'package:maps_graduation_project/features/product/PL/widgets/ctg_rounded_widget.dart';
import 'package:maps_graduation_project/features/product/PL/widgets/latest_arrival.dart';

import '../../../../const/app_constants.dart';
import '../../../../core/services/assets_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(fontSize: 20),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.24,
                child: ClipRRect(
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        AppConstants.bannersImages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    autoplay: true,
                    itemCount: AppConstants.bannersImages.length,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Visibility(
                visible: productController.products.isNotEmpty,
                child: TitlesTextWidget(
                  label: 'Latest arrival'.tr,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Visibility(
                visible: productController.products.isNotEmpty,
                child: SizedBox(
                  height: size.height * 0.2,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productController.products.length < 10
                          ? productController.products.length
                          : 10,
                      itemBuilder: (context, index) {
                        return null;

                        // return ChangeNotifierProvider.value(
                        //     value: controller.products[index],
                        //     child: const LatestArrivalProductsWidget());
                      }),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              TitlesTextWidget(
                label: 'Categories'.tr,
                fontSize: 22,
              ),
              const SizedBox(
                height: 18,
              ),
              GridView.count(
                  mainAxisSpacing: 20,
                  // crossAxisSpacing: 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: List.generate(
                      AppConstants.categoriesList(context).length, (index) {
                    return CategoryRoundedWidget(
                      image: AppConstants.categoriesList(context)[index].image,
                      name: AppConstants.categoriesList(context)[index].name,
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
