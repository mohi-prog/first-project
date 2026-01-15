import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static Future<User?> handleGoogleSignIn() async {
    try {
      final googleSignIn = GoogleSignIn();

      // WICHTIG: Erst ausloggen, um sicherzugehen
      await googleSignIn.signOut();

      print("🔵 Starting Google Sign-In...");
      final googleUser = await googleSignIn.signIn();
      print("🔵 Google User: ${googleUser?.email}");

      if (googleUser == null) {
        print("❌ User cancelled sign-in");
        return null;
      }

      final googleAuth = await googleUser.authentication;
      print("🔵 Got authentication tokens");

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      print("✅ Successfully signed in: ${userCredential.user?.email}");
      return userCredential.user;
    } catch (e) {
      print("❌ Google Login Fehler: $e");
      return null;
    }
  }
}
