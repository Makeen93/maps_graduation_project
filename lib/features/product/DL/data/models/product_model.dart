import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_graduation_project/features/product/DL/domain/entites/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.productId,
    required super.productTitle,
    required super.productPrice,
    required super.productCategory,
    required super.productDescription,
    required super.productImage,
    required super.productQuantity,
    super.createdAt,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'],
      productTitle: json['productTitle'],
      productPrice: json['productPrice'],
      productCategory: json['productCategory'],
      productDescription: json['productDescription'],
      productImage: json['productImage'],
      productQuantity: json['productQuantity'],
      createdAt: json['createdAt'],
    );
  }
  factory ProductModel.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ProductModel(
        productId: data['productId'],
        productTitle: data['productTitle'],
        productPrice: data['productPrice'],
        productCategory: data['productCategory'],
        productDescription: data['productDescription'],
        productImage: data['productImage'],
        productQuantity: data['productQuantity'],
        createdAt: data['createdAt']);
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'productId': productId,
      'productTitle': productTitle,
      'productPrice': productPrice,
      'productCategory': productCategory,
      'productDescription': productDescription,
      'productImage': productImage,
      'productQuantity': productQuantity,
      'createdAt': createdAt,
    };
  }
}
