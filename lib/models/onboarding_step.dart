import 'package:flutter/widgets.dart';

import 'first_run_step.dart';
import 'step_type.dart';

/// A text/image onboarding page shown in the flow.
class OnboardingStep extends FirstRunStep {
  /// Creates an onboarding step.
  const OnboardingStep({
    required this.title,
    required this.description,
    this.image,
  }) : super(StepType.onboarding);

  /// Heading for the onboarding screen.
  final String title;

  /// Body description for the onboarding screen.
  final String description;

  /// Optional illustration widget.
  final Widget? image;
}
