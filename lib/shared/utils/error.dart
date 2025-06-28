import 'package:workforce/Core/app_core.dart';

class ErrorUtils {
  static void handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        _showError('Invalid Email', 'The email address is not valid.');
        break;
      case 'user-disabled':
        _showError('User Disabled', 'This user has been disabled.');
        break;
      case 'user-not-found':
        _showError('User Not Found', 'No user found with this email.');
        break;
      case 'wrong-password':
        _showError('Wrong Password', 'The password entered is incorrect.');
        break;
      case 'email-already-in-use':
        _showError('Email In Use', 'This email is already registered.');
        break;
      case 'operation-not-allowed':
        _showError('Not Allowed', 'Email/password sign-in is not enabled.');
        break;
      case 'weak-password':
        _showError('Weak Password', 'Password must be at least 6 characters.');
        break;
      case 'account-exists-with-different-credential':
        _showError(
            'Account Exists', 'Account exists with different credentials.');
        break;
      case 'invalid-credential':
        _showError('Invalid Credential', 'Provided credentials are invalid.');
        break;
      case 'invalid-verification-code':
        _showError('Invalid Code', 'The verification code is invalid.');
        break;
      case 'invalid-verification-id':
        _showError(
            'Invalid Verification ID', 'The verification ID is not correct.');
        break;
      case 'network-request-failed':
        _showError('Network Error', 'Please check your internet connection.');
        break;
      case 'too-many-requests':
        _showError('Too Many Attempts', 'Please try again later.');
        break;
      case 'timeout':
        _showError('Timeout', 'The request has timed out.');
        break;
      case 'credential-already-in-use':
        _showError('Already Linked',
            'This credential is already linked to another account.');
        break;
      case 'requires-recent-login':
        _showError(
            'Re-authentication Required', 'Please log in again to continue.');
        break;
      case 'missing-verification-code':
        _showError('Missing Code', 'Please enter the verification code.');
        break;
      case 'missing-verification-id':
        _showError('Missing Verification ID', 'Verification ID not found.');
        break;
      case 'internal-error':
        _showError('Internal Error', 'Something went wrong. Please try again.');
        break;
      default:
        _showError('Auth Error', 'An unexpected error occurred: ${e.code}');
    }
  }

  static void handleFirestoreError(Exception exception) {
    if (exception is! FirebaseException) return;

    switch (exception.code) {
      case 'cancelled':
        _showError('Cancelled', 'The operation was cancelled by the user.');
        break;
      case 'unknown':
        _showError('Unknown Error', 'An unknown error occurred.');
        break;
      case 'invalid-argument':
        _showError('Invalid Argument', 'Invalid data was provided.');
        break;
      case 'deadline-exceeded':
        _showError('Timeout', 'The operation took too long to complete.');
        break;
      case 'not-found':
        _showError('Not Found', 'The requested document does not exist.');
        break;
      case 'already-exists':
        _showError('Duplicate', 'The document already exists.');
        break;
      case 'permission-denied':
        _showError('Permission Denied', 'You do not have access to this data.');
        break;
      case 'unauthenticated':
        _showError('Unauthenticated', 'Please login to continue.');
        break;
      case 'resource-exhausted':
        _showError('Limit Reached', 'Quota exceeded or too many requests.');
        break;
      case 'failed-precondition':
        _showError('Precondition Failed', 'Firestore rules were not met.');
        break;
      case 'aborted':
        _showError('Aborted', 'The operation was aborted.');
        break;
      case 'out-of-range':
        _showError('Out of Range', 'A field value was out of range.');
        break;
      case 'unimplemented':
        _showError('Unimplemented', 'This feature is not available.');
        break;
      case 'internal':
        _showError('Internal Error', 'Something went wrong internally.');
        break;
      case 'unavailable':
        _showError('Unavailable', 'Firestore is temporarily unavailable.');
        break;
      case 'data-loss':
        _showError('Data Loss', 'Unrecoverable data loss occurred.');
        break;
      default:
        _showError('Firestore Error', 'Unexpected error: ${exception.code}');
    }
  }

  static void _showError(String title, String message) {
    Get.closeCurrentSnackbar();
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundGradient: const LinearGradient(
        colors: [Colors.red, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      colorText: Colors.black,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 3),
    );
  }
}
