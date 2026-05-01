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
  });

  /// Navigation controller for step changes.
  final FlowController controller;

  /// Called when the flow should end.
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    final config = FirstRunThemeScope.of(context);

    return Row(
      children: [
        if (!controller.isFirstStep)
          config.buildBackButton(context, 'Back', controller.back),
        if (!controller.isFirstStep) const SizedBox(width: 8),
        config.buildSkipButton(context, 'Skip', onComplete),
        const Spacer(),
        config.buildNextButton(
          context,
          controller.isLastStep ? 'Finish' : 'Next',
          controller.isLastStep ? onComplete : controller.next,
        ),
      ],
    );
  }
}
