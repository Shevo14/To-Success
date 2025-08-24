import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineSyncService {
  static StreamSubscription<List<ConnectivityResult>>? _sub;

  static Future<void> initialize() async {
    _sub?.cancel();
    _sub = Connectivity().onConnectivityChanged.listen((results) {
      final online = results.any((r) => r != ConnectivityResult.none);
      if (online) {
        developer.log('Connectivity restored. Syncing offline changes...', name: 'OfflineSyncService');
        // TODO: apply queued writes to Firestore
      }
    });
  }

  static Future<void> dispose() async {
    await _sub?.cancel();
  }
}