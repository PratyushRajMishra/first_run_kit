import 'first_run_step.dart';

/// Event type emitted during first-run flow interactions.
enum FirstRunFlowEventType { started, next, back, skipped, completed }

/// Structured event payload for first-run flow analytics and logging.
class FirstRunFlowEvent {
  /// Creates a flow event.
  const FirstRunFlowEvent({
    required this.type,
    required this.stepIndex,
    required this.totalSteps,
    required this.step,
    required this.timestamp,
  });

  /// Category of the emitted event.
  final FirstRunFlowEventType type;

  /// Zero-based index of the active step when event was emitted.
  final int stepIndex;

  /// Total number of steps configured in the flow.
  final int totalSteps;

  /// Step model active when event was emitted.
  final FirstRunStep step;

  /// Event creation time.
  final DateTime timestamp;
}
