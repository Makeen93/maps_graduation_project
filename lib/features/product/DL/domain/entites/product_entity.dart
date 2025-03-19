// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductEntity {
  final String productId;
  final String productTitle;
  final String productPrice;
  final String productCategory;
  final String productDescription;
  final String productImage;
  final String productQuantity;
  String? createdAt;
  ProductEntity({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.productQuantity,
    this.createdAt,
  });

 

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      productId: map['productId'] as String,
      productTitle: map['productTitle'] as String,
      productPrice: map['productPrice'] as String,
      productCategory: map['productCategory'] as String,
      productDescription: map['productDescription'] as String,
      productImage: map['productImage'] as String,
      productQuantity: map['productQuantity'] as String,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

}
