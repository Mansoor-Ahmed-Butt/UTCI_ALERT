import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthDataSource {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  Future<User?> signIn() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // user cancelled — not an error

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final result = await _firebaseAuth.signInWithCredential(credential);
    return result.user;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    if (Firebase.apps.isNotEmpty) {
      await _firebaseAuth.signOut();
    }
  }
}
