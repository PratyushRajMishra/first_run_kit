import 'package:flutter/material.dart';

import '../controller/flow_controller.dart';
import '../ui/first_run_theme.dart';

/// Row of default navigation buttons for first-run flow.
class NavigationButtons extends StatelessWidget {
  /// Creates navigation buttons.
  const NavigationButtons({
    super.key,
    required this.controller,
    required this.onComplete,
    required this.onBack,
    required this.onSkip,
    required this.onNext,
  });

  /// Navigation controller for step changes.
  final FlowController controller;

  /// Called when the flow should end.
  final VoidCallback onComplete;

  /// Called when back is tapped.
  final VoidCallback onBack;

  /// Called when skip is tapped.
  final VoidCallback onSkip;

  /// Called when next is tapped.
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final config = FirstRunThemeScope.of(context);

    return Row(
      children: [
        if (!controller.isFirstStep)
          config.buildBackButton(context, 'Back', onBack),
        if (!controller.isFirstStep) const SizedBox(width: 8),
        config.buildSkipButton(context, 'Skip', onSkip),
        const Spacer(),
        config.buildNextButton(
          context,
          controller.isLastStep ? 'Finish' : 'Next',
          onNext,
        ),
      ],
    );
  }
}
