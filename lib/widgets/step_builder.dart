import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/custom_step.dart';
import '../models/first_run_step.dart';
import '../models/onboarding_step.dart';
import '../models/permission_step.dart';
import '../models/step_type.dart';
import '../ui/onboarding_view.dart';
import '../ui/permission_view.dart';

/// Resolves and builds the correct step widget for a [FirstRunStep].
class StepBuilder extends StatelessWidget {
  /// Creates a step renderer.
  const StepBuilder({
    super.key,
    required this.step,
    required this.onPermissionResult,
  });

  /// The current step model.
  final FirstRunStep step;

  /// Callback for permission status results.
  final ValueChanged<PermissionStatus> onPermissionResult;

  @override
  Widget build(BuildContext context) {
    switch (step.type) {
      case StepType.onboarding:
        return OnboardingView(step: step as OnboardingStep);
      case StepType.permission:
        return PermissionView(
          step: step as PermissionStep,
          onRequestFinished: onPermissionResult,
        );
      case StepType.custom:
        return (step as CustomStep).widget;
    }
  }
}
