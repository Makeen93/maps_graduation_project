// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String userId;
  final String userName;
  final String userImage;
  final String userEmail;

  final Timestamp? createdAt;
  final List userCart;
  final List userWish;
  UserEntity({
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.userEmail,
    this.createdAt,
    required this.userCart,
    required this.userWish,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'userEmail': userEmail,
      'userCart': userCart,
      'userWish': userWish,
    };
  }

  
}
