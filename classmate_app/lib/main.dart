import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

/// Simple enum to represent roles
enum UserRole { teacher, student }

/// Provider to simulate auth state and role. Replace with real Firebase Auth logic later.
final authStateProvider = StateProvider<AuthState?>((ref) => null);

class AuthState {
	AuthState({required this.uid, required this.role});
	final String uid;
	final UserRole role;
}

final _routerProvider = Provider<GoRouter>((ref) {
	return GoRouter(
		initialLocation: '/',
		routes: [
			GoRoute(
				path: '/',
				builder: (context, state) => const SplashScreen(),
			),
			GoRoute(
				path: '/login',
				builder: (context, state) => const LoginScreen(),
			),
			GoRoute(
				path: '/teacher',
				builder: (context, state) => const TeacherHomeScreen(),
			),
			GoRoute(
				path: '/student',
				builder: (context, state) => const StudentHomeScreen(),
			),
		],
		redirect: (context, state) {
			final auth = ref.read(authStateProvider);
			final isLoggingIn = state.matchedLocation == '/login';
			if (auth == null) {
				return isLoggingIn ? null : '/login';
			}
			// If logged in, send to role home if trying to access login or root
			if (isLoggingIn || state.matchedLocation == '/') {
				return auth.role == UserRole.teacher ? '/teacher' : '/student';
			}
			return null;
		},
	);
});

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp(); // Replace with Firebase options when wiring
	runApp(const ProviderScope(child: ClassmateApp()));
}

class ClassmateApp extends ConsumerWidget {
	const ClassmateApp({super.key});

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final router = ref.watch(_routerProvider);
		return MaterialApp.router(
			title: 'Classmate',
			theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), useMaterial3: true),
			darkTheme: ThemeData.dark(useMaterial3: true),
			themeMode: ThemeMode.system,
			routerConfig: router,
		);
	}
}

class SplashScreen extends StatelessWidget {
	const SplashScreen({super.key});
	@override
	Widget build(BuildContext context) {
		return const Scaffold(
			body: Center(child: CircularProgressIndicator()),
		);
	}
}

class LoginScreen extends ConsumerWidget {
	const LoginScreen({super.key});
	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return Scaffold(
			appBar: AppBar(title: const Text('Login')),
			body: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						ElevatedButton(
							onPressed: () {
								ref.read(authStateProvider.notifier).state = AuthState(uid: 'demo-teacher', role: UserRole.teacher);
							},
							child: const Text('Continue as Teacher'),
						),
						ElevatedButton(
							onPressed: () {
								ref.read(authStateProvider.notifier).state = AuthState(uid: 'demo-student', role: UserRole.student);
							},
							child: const Text('Continue as Student'),
						),
					],
				),
			),
		);
	}
}

class TeacherHomeScreen extends ConsumerWidget {
	const TeacherHomeScreen({super.key});
	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return Scaffold(
			appBar: AppBar(title: const Text('Teacher Dashboard'), actions: [
				IconButton(
					icon: const Icon(Icons.logout),
					onPressed: () => ref.read(authStateProvider.notifier).state = null,
				),
			]),
			body: ListView(
				padding: const EdgeInsets.all(16),
				children: const [
					ListTile(leading: Icon(Icons.class_), title: Text('Classes & Attendance')),
					ListTile(leading: Icon(Icons.quiz), title: Text('Quizzes')),
					ListTile(leading: Icon(Icons.grade), title: Text('Grades')),
					ListTile(leading: Icon(Icons.video_library), title: Text('Content Library')),
					ListTile(leading: Icon(Icons.analytics), title: Text('Analytics')),
				],
			),
		);
	}
}

class StudentHomeScreen extends ConsumerWidget {
	const StudentHomeScreen({super.key});
	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return Scaffold(
			appBar: AppBar(title: const Text('Student Dashboard'), actions: [
				IconButton(
					icon: const Icon(Icons.logout),
					onPressed: () => ref.read(authStateProvider.notifier).state = null,
				),
			]),
			body: const Center(child: Text('Progress: Attendance, Quizzes, Grades')),
		);
	}
}
