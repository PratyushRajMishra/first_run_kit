import 'package:flutter/widgets.dart';

import 'first_run_step.dart';
import 'step_type.dart';

/// A flow step that renders a custom widget supplied by the app.
class CustomStep extends FirstRunStep {
  /// Creates a custom step.
  const CustomStep({required this.widget}) : super(StepType.custom);

  /// Widget rendered for this step.
  final Widget widget;
}
