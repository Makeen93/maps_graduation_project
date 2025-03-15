import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? url;
  Future<String> uploadImageAndGetUrl({
    required XFile? imageFile,
    required String email,
  }) async {
    try {
      final ref = _storage.ref().child('usersImages').child("$email.jpg");

      await ref.putFile(File(imageFile!.path));
      url = await ref.getDownloadURL();
      final downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw e.toString();
    }
  }
}
