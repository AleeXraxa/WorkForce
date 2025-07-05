import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseErrorHandler {
  static void handle(dynamic error) {
    String message = 'An unexpected error occurred';

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          message = 'Invalid email address.';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'user-not-found':
          message = 'No user found with this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password.';
          break;
        case 'email-already-in-use':
          message = 'This email is already in use.';
          break;
        case 'weak-password':
          message = 'Password is too weak.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled.';
          break;
        default:
          message = error.message ?? 'Authentication error';
      }
    } else if (error is FirebaseException) {
      message = error.message ?? 'Firebase error occurred';
    } else if (error is PlatformException) {
      message = error.message ?? 'Platform error occurred';
    } else {
      message = error.toString();
    }

    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade900,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}
