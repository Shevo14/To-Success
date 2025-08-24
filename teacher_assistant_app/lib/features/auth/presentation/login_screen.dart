import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/role_provider.dart';
import '../../../models/user_role.dart';
import '../../dashboard/presentation/teacher_dashboard_screen.dart';
import '../../dashboard/presentation/student_dashboard_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() { isLoading = true; });
    try {
      if (isLogin) {
        await ref.read(authStateProvider.notifier).signIn(emailController.text.trim(), passwordController.text.trim());
      } else {
        await ref.read(authStateProvider.notifier).signUp(emailController.text.trim(), passwordController.text.trim());
      }
      final role = ref.read(userRoleProvider);
      if (role == UserRole.teacher) {
        if (mounted) Navigator.of(context).pushReplacementNamed(TeacherDashboardScreen.routeName);
      } else {
        if (mounted) Navigator.of(context).pushReplacementNamed(StudentDashboardScreen.routeName);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Auth error: $e')));
    } finally {
      if (mounted) setState(() { isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(userRoleProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Teacher Assistant')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SegmentedButton<UserRole>(
                  segments: const [
                    ButtonSegment(value: UserRole.teacher, label: Text('Teacher'), icon: Icon(Icons.school)),
                    ButtonSegment(value: UserRole.student, label: Text('Student'), icon: Icon(Icons.person)),
                  ],
                  selected: {role},
                  onSelectionChanged: (s) => ref.read(userRoleProvider.notifier).state = s.first,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Switch(value: isLogin, onChanged: (v) => setState(() => isLogin = v)),
                    const SizedBox(width: 8),
                    Text(isLogin ? 'Login' : 'Sign Up'),
                  ],
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : Text(isLogin ? 'Login' : 'Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}