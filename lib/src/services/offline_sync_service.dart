import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineSyncService {
  static const String _queueKey = 'offline_queue';

  Future<void> enqueue(Map<String, dynamic> task) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_queueKey) ?? <String>[];
    list.add(jsonEncode(task));
    await prefs.setStringList(_queueKey, list);
  }

  Future<List<Map<String, dynamic>>> dequeueAll() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_queueKey) ?? <String>[];
    await prefs.remove(_queueKey);
    return list.map((e) => Map<String, dynamic>.from(jsonDecode(e) as Map)).toList();
  }

  Stream<bool> connectivityStream() async* {
    await for (final result in Connectivity().onConnectivityChanged) {
      yield !result.contains(ConnectivityResult.none);
    }
  }
}