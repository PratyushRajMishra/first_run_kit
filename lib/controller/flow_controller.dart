import 'package:flutter/foundation.dart';

/// Lightweight state controller for first-run step navigation.
class FlowController extends ChangeNotifier {
  /// Creates a controller with the provided total [stepCount].
  FlowController({required int stepCount}) : _stepCount = stepCount;

  final int _stepCount;
  int _currentIndex = 0;

  /// Current zero-based step index.
  int get currentIndex => _currentIndex;

  /// Total number of steps in the flow.
  int get stepCount => _stepCount;

  /// Whether the current step is the final step.
  bool get isLastStep => _stepCount == 0 || _currentIndex >= _stepCount - 1;

  /// Whether the current step is the first step.
  bool get isFirstStep => _currentIndex <= 0;

  /// Moves to the next step if possible.
  void next() {
    if (_stepCount == 0) return;
    if (_currentIndex < _stepCount - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  /// Moves to the previous step if possible.
  void back() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  /// Jumps directly to the last step.
  void skip() {
    if (_stepCount == 0) return;
    _currentIndex = _stepCount - 1;
    notifyListeners();
  }
}
