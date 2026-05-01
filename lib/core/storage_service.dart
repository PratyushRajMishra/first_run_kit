import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

/// Safe wrapper around `SharedPreferences` used by first_run_kit.
class StorageService {
  /// Creates a storage service.
  ///
  /// Passing [prefs] is useful for tests.
  StorageService({SharedPreferences? prefs}) : _prefs = prefs;

  SharedPreferences? _prefs;

  Future<SharedPreferences> _instance() async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  /// Reads a bool value by [key].
  Future<bool?> getBool(String key) async {
    final prefs = await _instance();
    return prefs.getBool(key);
  }

  /// Stores a bool [value] by [key].
  Future<bool> setBool(String key, bool value) async {
    final prefs = await _instance();
    return prefs.setBool(key, value);
  }

  /// Removes a value by [key].
  Future<bool> remove(String key) async {
    final prefs = await _instance();
    return prefs.remove(key);
  }

  /// Clears all keys except the first-run flag.
  ///
  /// The value of [FirstRunConstants.firstRunKey] is preserved to avoid
  /// accidentally resetting onboarding behavior when clearing user data.
  Future<bool> safeClear() async {
    final prefs = await _instance();
    final preservedFirstRun =
        prefs.getBool(FirstRunConstants.firstRunKey) ??
        FirstRunConstants.defaultFirstRunValue;

    final cleared = await prefs.clear();
    final restored = await prefs.setBool(
      FirstRunConstants.firstRunKey,
      preservedFirstRun,
    );

    return cleared && restored;
  }
}
