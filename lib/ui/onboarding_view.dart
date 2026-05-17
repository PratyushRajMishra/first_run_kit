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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final surface = config.surfaceColor ?? colorScheme.surfaceContainerLow;
    final onSurface = config.onSurfaceColor ?? colorScheme.onSurface;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(config.cardBorderRadius),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.45)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (step.image != null) ...[
            Flexible(child: step.image!),
            const SizedBox(height: 24),
          ],
          Text(
            step.title,
            textAlign: TextAlign.center,
            style:
                config.titleStyle ??
                textTheme.headlineSmall?.copyWith(
                  color: onSurface,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            step.description,
            textAlign: TextAlign.center,
            style:
                config.descriptionStyle ??
                textTheme.bodyLarge?.copyWith(color: onSurface.withValues(alpha: 0.85)),
          ),
        ],
      ),
    );
  }
}
