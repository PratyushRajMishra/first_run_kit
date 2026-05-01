import 'package:flutter/material.dart';

import '../models/onboarding_step.dart';
import 'first_run_theme.dart';

/// Default UI renderer for [OnboardingStep].
class OnboardingView extends StatelessWidget {
  /// Creates an onboarding view.
  const OnboardingView({super.key, required this.step});

  /// Data for the onboarding screen.
  final OnboardingStep step;

  @override
  Widget build(BuildContext context) {
    final config = FirstRunThemeScope.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (step.image != null) ...[
          Flexible(child: step.image!),
          const SizedBox(height: 24),
        ],
        Text(
          step.title,
          textAlign: TextAlign.center,
          style: config.titleStyle ?? textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        Text(
          step.description,
          textAlign: TextAlign.center,
          style: config.descriptionStyle ?? textTheme.bodyLarge,
        ),
      ],
    );
  }
}
