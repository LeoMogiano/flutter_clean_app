import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsStorage {
  SharedPreferences? _prefs;

  Future<SharedPreferences> get _instance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> write<T>(String key, T value) async {
    final prefs = await _instance;
    switch (value) {
      case int():
        await prefs.setInt(key, value);
      case double():
        await prefs.setDouble(key, value);
      case bool():
        await prefs.setBool(key, value);
      case String():
        await prefs.setString(key, value);
      case List<String>():
        await prefs.setStringList(key, value);
      default:
        await prefs.setString(key, jsonEncode(value));
    }
  }

  Future<T?> read<T>(String key) async {
    final prefs = await _instance;
    final value = prefs.get(key);

    if (value == null) return null;

    if (value is T) return value as T;

    if (T != String && value is String) {
      try {
        return jsonDecode(value) as T;
      } on Exception catch (_) {
        return null;
      }
    }

    return null;
  }

  Future<void> delete(String key) async {
    final prefs = await _instance;
    await prefs.remove(key);
  }

  Future<void> clear() async {
    final prefs = await _instance;
    await prefs.clear();
  }
}
