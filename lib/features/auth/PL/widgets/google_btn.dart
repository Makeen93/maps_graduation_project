import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:maps_graduation_project/core/services/my_app_method.dart';

class GoogleButton extends StatelessWidget {
  final MyAppMethods _methodsController = Get.find();
  GoogleButton({super.key});
  Future<void> _googleSignIn({required BuildContext context}) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null
          // && googleAuth.idToken != null
          ) {
        try {
          final authResults = await FirebaseAuth.instance.signInWithCredential(
              GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken));
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            // Navigator.pushReplacementNamed(context, RootScreen.routName);
          });
          if (authResults.additionalUserInfo!.isNewUser) {
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
        } on FirebaseAuthException catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await _methodsController.showErrorOrWarningDialog(
                subtitle: '${'An_error_has_been_occured'.tr} ${error.message}',
                fct: () {});
          });
        } catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await _methodsController.showErrorOrWarningDialog(
                subtitle: '${'An_error_has_been_occured'.tr} $error',
                fct: () {});
          });
        }
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Navigator.pushReplacementNamed(context, RootScreen.routName);
    });
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
