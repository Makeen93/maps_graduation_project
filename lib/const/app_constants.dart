// import '../models/categories_model.dart';
// import '../services/assets_manager.dart';

// class AppConstants {
// static const String productImageUrl =
//     'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';
// static List<String> bannersImages = [
//   AssetsManager.banner1,
//   AssetsManager.banner2,
// ];
//   static List<CategoryModel> categoriesList = [
//     CategoryModel(
//       id: "Phones",
//       image: AssetsManager.mobiles,
//       name: "Phones",
//     ),
//     CategoryModel(
//       id: "Laptops",
//       image: AssetsManager.pc,
//       name: "Laptops",
//     ),
//     CategoryModel(
//       id: "Electronics",
//       image: AssetsManager.electronics,
//       name: "Electronics",
//     ),
//     CategoryModel(
//       id: "Watches",
//       image: AssetsManager.watch,
//       name: "Watches",
//     ),
//     CategoryModel(
//       id: "Clothes",
//       image: AssetsManager.fashion,
//       name: "Clothes",
//     ),
//     CategoryModel(
//       id: "Shoes",
//       image: AssetsManager.shoes,
//       name: "Shoes",
//     ),
//     CategoryModel(
//       id: "Books",
//       image: AssetsManager.book,
//       name: "Books",
//     ),
//     CategoryModel(
//       id: "Cosmetics",
//       image: AssetsManager.cosmetics,
//       name: "Cosmetics",
//     ),
//   ];
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_graduation_project/features/product/DL/data/models/category_model.dart';

import '../core/services/assets_manager.dart';


class AppConstants {
  static const String productImageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';
  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  static List<CategoryModel> categoriesList(BuildContext context) {

    return [
      CategoryModel(
        id: "Phones",
        image: AssetsManager.mobiles,
        name: 'phones'.tr,
      ),
      CategoryModel(
        id: "Laptops",
        image: AssetsManager.pc,
        name: 'laptops'.tr,
      ),
      CategoryModel(
        id: "Electronics",
        image: AssetsManager.electronics,
        name: 'electronics'.tr,
      ),
      CategoryModel(
        id: "Watches",
        image: AssetsManager.watch,
        name: 'watches'.tr,
      ),
      CategoryModel(
        id: "Clothes",
        image: AssetsManager.fashion,
        name: 'clothes'.tr,
      ),
      CategoryModel(
        id: "Shoes",
        image: AssetsManager.shoes,
        name: 'shoes'.tr,
      ),
      CategoryModel(
        id: "Books",
        image: AssetsManager.book,
        name: 'books'.tr,
      ),
      CategoryModel(
        id: "Cosmetics",
        image: AssetsManager.cosmetics,
        name: 'cosmetics'.tr,
      ),
    ];
  }
}
