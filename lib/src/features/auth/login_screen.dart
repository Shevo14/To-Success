import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = true;
  String role = 'student';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(firebaseAuthProvider);
    final db = ref.watch(firestoreProvider);

    Future<void> handleSubmit() async {
      setState(() => loading = true);
      try {
        if (isLogin) {
          await auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
        } else {
          final cred = await auth.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          await db.collection('users').doc(cred.user!.uid).set({
            'email': cred.user!.email,
            'role': role,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      } on Exception catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Auth error: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => loading = false);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Class Manager')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ToggleButtons(
                  isSelected: [isLogin, !isLogin],
                  onPressed: (i) => setState(() => isLogin = i == 0),
                  children: const [Padding(padding: EdgeInsets.all(8), child: Text('Login')), Padding(padding: EdgeInsets.all(8), child: Text('Sign up'))],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                if (!isLogin) ...[
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: role,
                    decoration: const InputDecoration(labelText: 'Role'),
                    items: const [
                      DropdownMenuItem(value: 'teacher', child: Text('Teacher')),
                      DropdownMenuItem(value: 'student', child: Text('Student')),
                    ],
                    onChanged: (v) => setState(() => role = v ?? 'student'),
                  ),
                ],
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: loading ? null : handleSubmit,
                  child: Text(loading ? 'Please wait...' : (isLogin ? 'Login' : 'Create account')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}