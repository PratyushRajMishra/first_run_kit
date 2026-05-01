import 'step_type.dart';

/// Base model for all first-run flow steps.
abstract class FirstRunStep {
  /// Creates a step with a specific [type].
  const FirstRunStep(this.type);

  /// Type of the step used by the renderer.
  final StepType type;
}
