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
      style: FilledButton.styleFrom(backgroundColor: color),
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
    return TextButton(onPressed: onPressed, child: Text(label));
  }

  /// Builds the skip button using custom or default styling.
  Widget buildSkipButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    final builder = skipButtonBuilder ?? buttonBuilder;
    if (builder != null) return builder(context, label, onPressed);
    return TextButton(onPressed: onPressed, child: Text(label));
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
