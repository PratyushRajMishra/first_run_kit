import 'package:flutter/material.dart';

import '../controller/flow_controller.dart';

/// Layout mode for first-run content.
enum FirstRunLayout { centered, fullScreen }

/// Builder signature for custom navigation buttons.
typedef FirstRunButtonBuilder =
    Widget Function(BuildContext context, String label, VoidCallback onPressed);

/// Visual and behavioral configuration for [FirstRunWrapper].
class FirstRunConfig {
  /// Creates a first-run UI configuration.
  const FirstRunConfig({
    this.primaryColor,
    this.backgroundColor,
    this.surfaceColor,
    this.onSurfaceColor,
    this.progressColor,
    this.progressBackgroundColor,
    this.successColor,
    this.warningColor,
    this.errorColor,
    this.cardBorderRadius = 20,
    this.titleStyle,
    this.descriptionStyle,
    this.buttonBuilder,
    this.nextButtonBuilder,
    this.backButtonBuilder,
    this.skipButtonBuilder,
    this.transitionBuilder,
    this.layout = FirstRunLayout.centered,
    this.padding = const EdgeInsets.all(24),
  });

  /// Primary accent color used by default next/finish button.
  final Color? primaryColor;

  /// Flow background color.
  final Color? backgroundColor;

  /// Card/surface color used by default step containers.
  final Color? surfaceColor;

  /// Foreground color on top of [surfaceColor].
  final Color? onSurfaceColor;

  /// Active color for progress bars and chips.
  final Color? progressColor;

  /// Background color for progress bars.
  final Color? progressBackgroundColor;

  /// Semantic success color (for granted permission states).
  final Color? successColor;

  /// Semantic warning color.
  final Color? warningColor;

  /// Semantic error color.
  final Color? errorColor;

  /// Border radius used by default professional cards.
  final double cardBorderRadius;

  /// Optional text style for step titles.
  final TextStyle? titleStyle;

  /// Optional text style for step descriptions.
  final TextStyle? descriptionStyle;

  /// Shared builder used for all navigation buttons.
  final FirstRunButtonBuilder? buttonBuilder;

  /// Builder override for the next/finish button.
  final FirstRunButtonBuilder? nextButtonBuilder;

  /// Builder override for the back button.
  final FirstRunButtonBuilder? backButtonBuilder;

  /// Builder override for the skip button.
  final FirstRunButtonBuilder? skipButtonBuilder;

  /// Transition for switching between steps.
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  /// Layout mode for the step content.
  final FirstRunLayout layout;

  /// Outer padding applied around the flow.
  final EdgeInsetsGeometry padding;

  /// Builds the next/finish button using custom or default styling.
  Widget buildNextButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    final builder = nextButtonBuilder ?? buttonBuilder;
    if (builder != null) return builder(context, label, onPressed);

    final color = primaryColor ?? Theme.of(context).colorScheme.primary;
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardBorderRadius * 0.6),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }

  /// Builds the back button using custom or default styling.
  Widget buildBackButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    final builder = backButtonBuilder ?? buttonBuilder;
    if (builder != null) return builder(context, label, onPressed);
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }

  /// Builds the skip button using custom or default styling.
  Widget buildSkipButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    final builder = skipButtonBuilder ?? buttonBuilder;
    if (builder != null) return builder(context, label, onPressed);
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

/// Inherited scope that provides [FirstRunConfig] to descendants.
class FirstRunThemeScope extends InheritedWidget {
  /// Creates a configuration scope.
  const FirstRunThemeScope({
    required this.config,
    super.key,
    required super.child,
  });

  /// Active configuration.
  final FirstRunConfig config;

  /// Returns config from the nearest [FirstRunThemeScope].
  static FirstRunConfig of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<FirstRunThemeScope>()
            ?.config ??
        const FirstRunConfig();
  }

  /// Whether dependent widgets should rebuild.
  @override
  bool updateShouldNotify(FirstRunThemeScope oldWidget) {
    return oldWidget.config != config;
  }
}

/// Helper actions tied to [FlowController].
class FirstRunActions {
  /// Creates helper actions.
  const FirstRunActions({required this.controller, required this.onComplete});

  /// Controller used by the actions.
  final FlowController controller;

  /// Called when flow is completed.
  final VoidCallback onComplete;

  /// Goes to next step, or completes the flow on the last step.
  void onNext() {
    if (controller.isLastStep) {
      onComplete();
      return;
    }
    controller.next();
  }
}
