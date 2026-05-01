import '../utils/constants.dart';
import 'storage_service.dart';

/// Manages first-launch state for the app.
class FirstRunManager {
  /// Creates a manager backed by [StorageService].
  FirstRunManager({StorageService? storageService})
    : _storageService = storageService ?? StorageService();

  final StorageService _storageService;

  /// Returns `true` when onboarding should be shown.
  ///
  /// If storage has no saved value (for example, after reinstall or manual
  /// storage clear), this safely falls back to the default first-run value.
  Future<bool> isFirstRun() async {
    final value = await _storageService.getBool(FirstRunConstants.firstRunKey);
    return value ?? FirstRunConstants.defaultFirstRunValue;
  }

  /// Marks first-run flow as completed.
  Future<void> markFirstRunComplete() async {
    await _storageService.setBool(FirstRunConstants.firstRunKey, false);
  }

  /// Resets the first-run flag for QA/debug scenarios.
  Future<void> resetFirstRun() async {
    await _storageService.setBool(FirstRunConstants.firstRunKey, true);
  }
}
