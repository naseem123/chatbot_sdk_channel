import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKey { sessionId, sessionIdleTimout }

class Preference {
  Preference();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  T? get<T extends Object>(PreferenceKey key, [T? defaultValue]) {
    final data = _prefs.get(key.name) as T?;
    return data ?? defaultValue;
  }

  Future<void> put(PreferenceKey key, String value) async {
    _prefs.setString(key.name, value);
  }

  Future<void> remove(PreferenceKey key) async {
    await _prefs.remove(key.name);
  }
}
