import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  const AuthService({required this.firebaseAuth, required this.firestore});

  Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithEmail(String email, String password) {
    return firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signUpWithEmail({required String email, required String password, required String role}) async {
    final cred = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await firestore.collection('users').doc(cred.user!.uid).set({
      'email': email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    return cred;
  }

  Future<void> signOut() => firebaseAuth.signOut();
}