import '../../../../core/utils/app_images.dart';

class BottomNavigationBarEntity {
  final String activeImage, inActiveImage;
  final String name;

  BottomNavigationBarEntity(
      {required this.activeImage,
      required this.inActiveImage,
      required this.name});
}

List<BottomNavigationBarEntity> get bottomNavigationBarItems => [
      BottomNavigationBarEntity(
          activeImage: Assets.imagesActiveHome,
          inActiveImage: Assets.imagesInactiveHome,
          name: 'الرئيسية'),
      BottomNavigationBarEntity(
          activeImage: Assets.imagesActiveProduct,
          inActiveImage: Assets.imagesInactiveProduct,
          name: 'المنتجات'),
      BottomNavigationBarEntity(
          activeImage: Assets.imagesActiveShoppingCart,
          inActiveImage: Assets.imagesInactiveShoppingCart,
          name: 'سلة التسوق'),
      BottomNavigationBarEntity(
          activeImage: Assets.imagesActiveUser,
          inActiveImage: Assets.imagesInactiveUser,
          name: 'حسابي'),
    ];
