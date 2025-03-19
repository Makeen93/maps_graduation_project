import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';
import 'package:maps_graduation_project/routes/app_routes.dart';

class GoogleButton extends StatelessWidget {
  final MyAppMethods _methodsController = Get.find();
  GoogleButton({super.key});
  Future<void> _googleSignIn({required BuildContext context}) async {
    final googleSignIn = GoogleSignIn();

    try {
      // Start the Google Sign-In process
      final googleAccount = await googleSignIn.signIn();
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;

        if (googleAuth.accessToken != null) {
          // Use the retrieved tokens to sign in to Firebase
          final authResults = await FirebaseAuth.instance.signInWithCredential(
              GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken));

          // Optional: Check if new user and add to Firestore
          if (authResults.additionalUserInfo?.isNewUser ?? false) {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(authResults.user!.uid)
                .set({
              'userId': authResults.user!.uid,
              'userName': authResults.user!.displayName,
              'userImage': authResults.user!.photoURL,
              'userEmail': authResults.user!.email,
              'createdAt': Timestamp.now(),
              'userCart': [],
              'userWish': [],
            });
          }
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Get.toNamed(AppRouter.home);
          });
        }
      }
    } on FirebaseAuthException catch (error, s) {
      await _methodsController.showErrorOrWarningDialog(
          subtitle: '${'An_error_has_been_occured'.tr} ${error.message}',
          fct: () {});
      print(error.message);
      print(s);
    } catch (error, s) {
      await _methodsController.showErrorOrWarningDialog(
          subtitle: '${'An_error_has_been_occured'.tr} $error', fct: () {});
      print(error);
    }

    // Navigation can go here if needed
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      icon: const Icon(
        Ionicons.logo_google,
        color: Colors.red,
      ),
      label: Text(
        'Sign in with google'.tr,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      onPressed: () async {
        await _googleSignIn(context: context);
      },
    );
  }
}
