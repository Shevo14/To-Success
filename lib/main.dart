import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialized inside App bootstrap to allow web/desktop flexibility
  runApp(const ProviderScope(child: ClassManagerApp()));
}