/// Constants used internally by first_run_kit.
class FirstRunConstants {
  /// Utility class; not meant to be instantiated.
  const FirstRunConstants._();

  /// SharedPreferences key storing first-run completion state.
  static const String firstRunKey = 'first_run';

  /// Default value used when first-run state has not been written yet.
  static const bool defaultFirstRunValue = true;
}
