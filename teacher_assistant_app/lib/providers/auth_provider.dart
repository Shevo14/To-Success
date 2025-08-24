import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final bool isLoggedIn;
  final String? uid;
  const AuthState({required this.isLoggedIn, this.uid});
  factory AuthState.loggedOut() => const AuthState(isLoggedIn: false);
  factory AuthState.loggedIn(String uid) => AuthState(isLoggedIn: true, uid: uid);
}

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(AuthState.loggedOut()) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        state = AuthState.loggedIn(user.uid);
      } else {
        state = AuthState.loggedOut();
      }
    }, onError: (e, st) {
      if (kDebugMode) {
        developer.log('authStateChanges error: $e', name: 'AuthController', stackTrace: st);
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, st) {
      if (kDebugMode) {
        developer.log('signIn error: $e', name: 'AuthController', stackTrace: st);
      }
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e, st) {
      if (kDebugMode) {
        developer.log('signUp error: $e', name: 'AuthController', stackTrace: st);
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e, st) {
      if (kDebugMode) {
        developer.log('signOut error: $e', name: 'AuthController', stackTrace: st);
      }
    }
  }
}

final authStateProvider = StateNotifierProvider<AuthController, AuthState>((ref) => AuthController());